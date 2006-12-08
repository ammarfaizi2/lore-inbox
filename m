Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164229AbWLHAyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164229AbWLHAyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164240AbWLHAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:54:41 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:13761 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164229AbWLHAyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:54:40 -0500
Date: Thu, 7 Dec 2006 16:55:08 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jesper.juhl@gmail.com, akpm <akpm@osdl.org>
Subject: [PATCH/v2] CodingStyle updates
Message-Id: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Add some kernel coding style comments, mostly pulled from emails
by Andrew Morton, Jesper Juhl, and Randy Dunlap.

- add paragraph on switch/case indentation (with fixes)
- add paragraph on multiple-assignments
- add more on Braces
- add section on Spaces; add typeof, alignof, & __attribute__ with sizeof;
  add more on postfix/prefix increment/decrement operators
- add paragraph on function breaks in source files; add info on
  function prototype parameter names
- add paragraph on EXPORT_SYMBOL placement
- add section on /*-comment style, long-comment style, and data
  declarations and comments
- correct some chapter number references that were missed when
  chapters were renumbered

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jesper Juhl <jesper.juhl@gmail.com>
---
 Documentation/CodingStyle |  125 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

--- linux-2.6.19-git11.orig/Documentation/CodingStyle
+++ linux-2.6.19-git11/Documentation/CodingStyle
@@ -35,12 +35,37 @@ In short, 8-char indents make things eas
 benefit of warning you when you're nesting your functions too deep.
 Heed that warning.
 
+The preferred way to ease multiple indentation levels in a switch
+statement is to align the "switch" and its subordinate "case" labels in
+the same column instead of "double-indenting" the "case" labels.  E.g.:
+
+	switch (suffix) {
+	case 'G':
+	case 'g':
+		mem <<= 30;
+		break;
+	case 'M':
+	case 'm':
+		mem <<= 20;
+		break;
+	case 'K':
+	case 'k':
+		mem <<= 10;
+		/* fall through */
+	default:
+		break;
+	}
+
+
 Don't put multiple statements on a single line unless you have
 something to hide:
 
 	if (condition) do_this;
 	  do_something_everytime;
 
+Don't put multiple assignments on a single line either.  Kernel
+coding style is super simple.  Avoid tricky expressions.
+
 Outside of comments, documentation and except in Kconfig, spaces are never
 used for indentation, and the above example is deliberately broken.
 
@@ -69,7 +94,7 @@ void fun(int a, int b, int c)
 		next_statement;
 }
 
-		Chapter 3: Placing Braces
+		Chapter 3: Placing Braces and Spaces
 
 The other issue that always comes up in C styling is the placement of
 braces.  Unlike the indent size, there are few technical reasons to
@@ -81,6 +106,20 @@ brace last on the line, and put the clos
 		we do y
 	}
 
+This applies to all non-function statement blocks (if, switch, for,
+while, do).  E.g.:
+
+	switch (action) {
+	case KOBJ_ADD:
+		return "add";
+	case KOBJ_REMOVE:
+		return "remove";
+	case KOBJ_CHANGE:
+		return "change";
+	default:
+		return NULL;
+	}
+
 However, there is one special case, namely functions: they have the
 opening brace at the beginning of the next line, thus:
 
@@ -121,6 +160,48 @@ supply of new-lines on your screen is no
 25-line terminal screens here), you have more empty lines to put
 comments on.
 
+		3.1:  Spaces
+
+Linux kernel style for use of spaces depends (mostly) on
+function-versus-keyword usage.  Use a space after (most) keywords.  The
+notable exceptions are sizeof, typeof, alignof, and __attribute__, which
+look somewhat like functions (and are usually used with parentheses in
+Linux, although they are not required in the language, as in: "sizeof info"
+after "struct fileinfo info;" is declared).
+
+So use a space after these keywords:
+	if, switch, case, for, do, while
+but not with sizeof, typeof, alignof, or __attribute__.  E.g.,
+	s = sizeof(struct file);
+
+Do not add spaces around (inside) parenthesized expressions.
+This example is *bad*:
+
+	s = sizeof( struct file );
+
+When declaring pointer data or a function that returns a pointer type,
+the preferred use of '*' is adjacent to the data name or function name
+and not adjacent to the type name.  Examples:
+
+	char *linux_banner;
+	unsigned long long memparse(char *ptr, char **retptr);
+	char *match_strdup(substring_t *s);
+
+Use one space around (on each side of) most binary and ternary operators,
+such as any of these:
+	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
+
+but no space after unary operators:
+	&  *  +  -  ~  !  sizeof  typeof  alignof  __attribute__  defined
+
+no space before the postfix increment & decrement unary operators:
+	++  --
+
+no space after the prefix increment & decrement unary operators:
+	++  --
+
+and no space around the '.' and "->" structure member operators.
+
 
 		Chapter 4: Naming
 
@@ -152,7 +233,7 @@ variable that is used to hold a temporar
 
 If you are afraid to mix up your local variable names, you have another
 problem, which is called the function-growth-hormone-imbalance syndrome.
-See next chapter.
+See chapter 6 (Functions).
 
 
 		Chapter 5: Typedefs
@@ -258,6 +339,20 @@ generally easily keep track of about 7 d
 and it gets confused.  You know you're brilliant, but maybe you'd like
 to understand what you did 2 weeks from now.
 
+In source files, separate functions with one blank line.
+If the function is exported, the EXPORT* macro for it should follow
+immediately after the closing function brace line.  E.g.:
+
+int system_is_up(void)
+{
+	return system_state == SYSTEM_RUNNING;
+}
+EXPORT_SYMBOL(system_is_up);
+
+In function prototypes, include parameter names with their data types.
+Although this is not required by the C language, it is preferred in Linux
+because it is a simple way to add valuable information for the reader.
+
 
 		Chapter 7: Centralized exiting of functions
 
@@ -306,16 +401,36 @@ time to explain badly written code.
 Generally, you want your comments to tell WHAT your code does, not HOW.
 Also, try to avoid putting comments inside a function body: if the
 function is so complex that you need to separately comment parts of it,
-you should probably go back to chapter 5 for a while.  You can make
+you should probably go back to chapter 6 for a while.  You can make
 small comments to note or warn about something particularly clever (or
 ugly), but try to avoid excess.  Instead, put the comments at the head
 of the function, telling people what it does, and possibly WHY it does
 it.
 
-When commenting the kernel API functions, please use the kerneldoc format.
+When commenting the kernel API functions, please use the kernel-doc format.
 See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
 for details.
 
+Linux style for comments is the C89 "/* ... */" style.
+Don't use C99-style "// ..." comments.
+
+The preferred style for long (multi-line) comments is:
+
+	/*
+	 * This is the preferred style for multi-line
+	 * comments in the Linux kernel source code.
+	 * Please use it consistently.
+	 *
+	 * Description:  A column of asterisks on the left side,
+	 * with beginning and ending almost-blank lines.
+	 */
+
+It's also important to comment data, whether they are basic types or
+derived types.  To this end, use just one data declaration per line
+(no commas for multiple data declarations).  This leaves you room for
+a small comment on each item, explaining its use.
+
+
 		Chapter 9: You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix
@@ -591,4 +706,4 @@ Kernel CodingStyle, by greg@kroah.com at
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
 
 --
-Last updated on 30 April 2006.
+Last updated on 2006-December-06.


---
