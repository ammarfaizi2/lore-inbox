Return-Path: <linux-kernel-owner+w=401wt.eu-S965058AbWLOVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWLOVNE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWLOVNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:13:04 -0500
Received: from lazybastard.de ([212.112.238.170]:37281 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbWLOVNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:13:01 -0500
Date: Fri, 15 Dec 2006 21:10:14 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-ID: <20061215211014.GB32210@lazybastard.org>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com> <20061215201127.GA32210@lazybastard.org> <20061215122659.ebccdede.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061215122659.ebccdede.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 December 2006 12:26:59 -0800, Randy Dunlap wrote:
> 
> then send patches  :)

Like so?  I manually edited the patch and weakened a few of the space
rules, basically the ones in dispute in this thread.

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
Acked-by: Jörn Engel <joern@lazybastard.org>
---
 Documentation/CodingStyle |  129 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 5 deletions(-)

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
 
@@ -121,6 +160,52 @@ supply of new-lines on your screen is no
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
+When placing spaces around operators, try to make the code as readable
+as possible.  While readability is a highly personal matter, the
+following rules are a good starting point (and _not_ the ultimate
+wisdom in all cases, mind you ;):
+Tend to use one space around (on each side of) most binary and ternary
+operators, such as any of these:
+	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
+
+avoid spaces after unary operators:
+	&  *  +  -  ~  !  sizeof  typeof  alignof  __attribute__  defined
+
+no spaces before the postfix increment & decrement unary operators:
+	++  --
+
+avoid spaces after the prefix increment & decrement unary operators:
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



Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
