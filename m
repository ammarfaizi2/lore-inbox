Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266605AbUBLWGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUBLWGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:06:19 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:37066 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266605AbUBLWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:05:35 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 06:15:10 +0800
User-Agent: KMail/1.5.4
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402130615.10608.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is Codingstyle updated. 

Updates:
	Kconfig

Clarifies: 
	Indentation

Adds:
	Exiting functions
	Parenthesis in expressions
	Macros
	Printk formatting
Cleans up:	
	Lagging spaces

Will update chapter numbering and spelling once contents OK.

Comments and suggestions are appreciated.

Regards
Michael


diff -uN linux-2.6.2-rc3-mhf170/Documentation/CodingStyle.mhf.orig linux-2.6.2-rc3-mhf170/Documentation/CodingStyle
--- linux-2.6.2-rc3-mhf170/Documentation/CodingStyle.mhf.orig	2004-01-31 17:38:02.000000000 +0800
+++ linux-2.6.2-rc3-mhf170/Documentation/CodingStyle	2004-02-13 06:05:11.000000000 +0800
@@ -1,42 +1,78 @@
 
-		Linux kernel coding style 
+		Linux kernel coding style
 
 This is a short document describing the preferred coding style for the
 linux kernel.  Coding style is very personal, and I won't _force_ my
 views on anybody, but this is what goes for anything that I have to be
 able to maintain, and I'd prefer it for most other things too.  Please
-at least consider the points made here. 
+at least consider the points made here.
 
 First off, I'd suggest printing out a copy of the GNU coding standards,
-and NOT read it.  Burn them, it's a great symbolic gesture. 
+and NOT read it.  Burn them, it's a great symbolic gesture.
 
 Anyway, here goes:
 
 
 	 	Chapter 1: Indentation
 
-Tabs are 8 characters, and thus indentations are also 8 characters. 
+Tabs are 8 characters, and thus indentations are also 8 characters.
 There are heretic movements that try to make indentations 4 (or even 2!)
 characters deep, and that is akin to trying to define the value of PI to
-be 3. 
+be 3.
 
 Rationale: The whole idea behind indentation is to clearly define where
 a block of control starts and ends.  Especially when you've been looking
 at your screen for 20 straight hours, you'll find it a lot easier to see
-how the indentation works if you have large indentations. 
+how the indentation works if you have large indentations.
 
 Now, some people will claim that having 8-character indentations makes
 the code move too far to the right, and makes it hard to read on a
 80-character terminal screen.  The answer to that is that if you need
 more than 3 levels of indentation, you're screwed anyway, and should fix
-your program. 
+your program.
 
 In short, 8-char indents make things easier to read, and have the added
-benefit of warning you when you're nesting your functions too deep. 
-Heed that warning. 
+benefit of warning you when you're nesting your functions too deep.
+Heed that warning.
 
+Note that perhaps the most terrible way to write code is to put multiple
+statements onto a single line:
 
-		Chapter 2: Placing Braces
+	if (condition) do_this;
+
+Outside of comments and except in Kconfig, spaces are never used for
+indentation.
+
+Lagging spaces are deprecated.
+
+		Chapter 2: Breaking long lines and strings
+
+Coding style is all about readability and maintainability using commonly
+available tools.
+
+The limit on the length of lines is 80 columns and this is a hard limit.
+
+Statements longer than 80 columns will be broken into sensible chunks.
+The beginning of a statement is the parent and further chunks are
+descendent's. Descendent's are always shorter than the parent and
+are placed substantially to the right.
+
+Long strings are broken into smaller strings too.
+
+void fun(int a, int b, int c)
+{
+	if (condition)
+		printk(KERN_WARNING "Warning this is a long printk with "
+						"3 parameters a: %u b: %u "
+						"c: %u \n", a, b, c);
+        else
+		next_statement;
+}
+
+This method makes it very obvious that the printk is a single statement.
+
+
+		Chapter : Placing Braces
 
 The other issue that always comes up in C styling is the placement of
 braces.  Unlike the indent size, there are few technical reasons to
@@ -59,7 +95,7 @@
 Heretic people all over the world have claimed that this inconsistency
 is ...  well ...  inconsistent, but all right-thinking people know that
 (a) K&R are _right_ and (b) K&R are right.  Besides, functions are
-special anyway (you can't nest them in C). 
+special anyway (you can't nest them in C).
 
 Note that the closing brace is empty on a line of its own, _except_ in
 the cases where it is followed by a continuation of the same statement,
@@ -79,60 +115,60 @@
 	} else {
 		....
 	}
-			
-Rationale: K&R. 
+
+Rationale: K&R.
 
 Also, note that this brace-placement also minimizes the number of empty
 (or almost empty) lines, without any loss of readability.  Thus, as the
 supply of new-lines on your screen is not a renewable resource (think
 25-line terminal screens here), you have more empty lines to put
-comments on. 
+comments on.
 
 
-		Chapter 3: Naming
+		Chapter : Naming
 
 C is a Spartan language, and so should your naming be.  Unlike Modula-2
 and Pascal programmers, C programmers do not use cute names like
 ThisVariableIsATemporaryCounter.  A C programmer would call that
 variable "tmp", which is much easier to write, and not the least more
-difficult to understand. 
+difficult to understand.
 
 HOWEVER, while mixed-case names are frowned upon, descriptive names for
 global variables are a must.  To call a global function "foo" is a
-shooting offense. 
+shooting offense.
 
 GLOBAL variables (to be used only if you _really_ need them) need to
 have descriptive names, as do global functions.  If you have a function
 that counts the number of active users, you should call that
-"count_active_users()" or similar, you should _not_ call it "cntusr()". 
+"count_active_users()" or similar, you should _not_ call it "cntusr()".
 
 Encoding the type of a function into the name (so-called Hungarian
 notation) is brain damaged - the compiler knows the types anyway and can
 check those, and it only confuses the programmer.  No wonder MicroSoft
-makes buggy programs. 
+makes buggy programs.
 
 LOCAL variable names should be short, and to the point.  If you have
-some random integer loop counter, it should probably be called "i". 
+some random integer loop counter, it should probably be called "i".
 Calling it "loop_counter" is non-productive, if there is no chance of it
 being mis-understood.  Similarly, "tmp" can be just about any type of
-variable that is used to hold a temporary value. 
+variable that is used to hold a temporary value.
 
 If you are afraid to mix up your local variable names, you have another
-problem, which is called the function-growth-hormone-imbalance syndrome. 
-See next chapter. 
+problem, which is called the function-growth-hormone-imbalance syndrome.
+See next chapter.
 
-		
-		Chapter 4: Functions
+
+		Chapter : Functions
 
 Functions should be short and sweet, and do just one thing.  They should
-fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
-as we all know), and do one thing and do that well. 
+fit on one or two screens full of text (the ISO/ANSI screen size is 80x24,
+as we all know), and do one thing and do that well.
 
 The maximum length of a function is inversely proportional to the
 complexity and indentation level of that function.  So, if you have a
 conceptually simple function that is just one long (but simple)
 case-statement, where you have to do lots of small things for a lot of
-different cases, it's OK to have a longer function. 
+different cases, it's OK to have a longer function.
 
 However, if you have a complex function, and you suspect that a
 less-than-gifted first-year high-school student might not even
@@ -140,41 +176,86 @@
 maximum limits all the more closely.  Use helper functions with
 descriptive names (you can ask the compiler to in-line them if you think
 it's performance-critical, and it will probably do a better job of it
-than you would have done). 
+than you would have done).
 
 Another measure of the function is the number of local variables.  They
 shouldn't exceed 5-10, or you're doing something wrong.  Re-think the
 function, and split it into smaller pieces.  A human brain can
 generally easily keep track of about 7 different things, anything more
 and it gets confused.  You know you're brilliant, but maybe you'd like
-to understand what you did 2 weeks from now. 
+to understand what you did 2 weeks from now.
+
+Centralized exiting of functions
+
+Albeit deprecated by some people, the goto statement is used frequently
+by compilers in form of the unconditional jump instruction.
+
+The goto statement comes handy when a function exits from multiple
+locations and some common work such as cleanup has to be done.
+
+The rationale is:
+
+- unconditional statements are easier to understand and follow
+- nesting is reduced
+- errors by not updating individual exit points when making modifications
+  are prevented
+- saves the compiler work to optimize redundant code away ;)
 
+int fun(int )
+{
+	int result = 0;
+	char *buffer = kmalloc(SIZE);
+
+	if (buffer == 0) {
+		result = -1;
+		goto out;
+	}
+
+	if (condition1) {
+		while (loop1) {
+			...
+		}
+		result = 1;
+		goto out;
+	}
+	if (condition2) {
+		while (loop2) {
+			...
+		}
+		result = 2;
+		goto out;
+	}
+out:
+	if (buffer)
+		kfree(buffer);
+	return result;
+}
 
-		Chapter 5: Commenting
+		Chapter : Commenting
 
 Comments are good, but there is also a danger of over-commenting.  NEVER
 try to explain HOW your code works in a comment: it's much better to
 write the code so that the _working_ is obvious, and it's a waste of
-time to explain badly written code. 
+time to explain badly written code.
 
-Generally, you want your comments to tell WHAT your code does, not HOW. 
+Generally, you want your comments to tell WHAT your code does, not HOW.
 Also, try to avoid putting comments inside a function body: if the
 function is so complex that you need to separately comment parts of it,
 you should probably go back to chapter 4 for a while.  You can make
 small comments to note or warn about something particularly clever (or
 ugly), but try to avoid excess.  Instead, put the comments at the head
 of the function, telling people what it does, and possibly WHY it does
-it. 
+it.
 
 
-		Chapter 6: You've made a mess of it
+		Chapter : You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that "GNU emacs" automatically formats the C sources for
 you, and you've noticed that yes, it does do that, but the defaults it
 uses are less than desirable (in fact, they are worse than random
 typing - an infinite number of monkeys typing into GNU emacs would never
-make a good program). 
+make a good program).
 
 So, you can either get rid of GNU emacs, or change it to use saner
 values.  To do the latter, you can stick the following in your .emacs file:
@@ -201,33 +282,35 @@
 everything is lost: use "indent".
 
 Now, again, GNU indent has the same brain-dead settings that GNU emacs
-has, which is why you need to give it a few command line options. 
+has, which is why you need to give it a few command line options.
 However, that's not too bad, because even the makers of GNU indent
 recognize the authority of K&R (the GNU people aren't evil, they are
 just severely misguided in this matter), so you just give indent the
-options "-kr -i8" (stands for "K&R, 8 character indents"). 
+options "-kr -i8" (stands for "K&R, 8 character indents").
 
 "indent" has a lot of options, and especially when it comes to comment
 re-formatting you may want to take a look at the manual page.  But
-remember: "indent" is not a fix for bad programming. 
+remember: "indent" is not a fix for bad programming.
 
 
-		Chapter 7: Configuration-files
+		Chapter : Configuration-files
 
-For configuration options (arch/xxx/config.in, and all the Config.in files),
+For configuration options (arch/xxx/Kconfig, and all the Kconfig files),
 somewhat different indentation is used.
 
-An indention level of 3 is used in the code, while the text in the config-
-options should have an indention-level of 2 to indicate dependencies. The
-latter only applies to bool/tristate options. For other options, just use
-common sense. An example:
-
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   tristate 'Apply nitroglycerine inside the keyboard (DANGEROUS)' CONFIG_BOOM
-   if [ "$CONFIG_BOOM" != "n" ]; then
-      bool '  Output nice messages when you explode' CONFIG_CHEER
-   fi
-fi
+Help text is indented with 2 spaces.
+
+if CONFIG_EXPERIMENTAL
+	tristate CONFIG_BOOM
+	default n
+	help
+	  Apply nitroglycerine inside the keyboard (DANGEROUS)
+	bool CONFIG_CHEER
+	depends on CONFIG_BOOM
+	default y
+	help
+	  Output nice messages when you explode
+endif
 
 Generally, CONFIG_EXPERIMENTAL should surround all options not considered
 stable. All options that are known to trash data (experimental write-
@@ -235,20 +318,20 @@
 experimental options should be denoted (EXPERIMENTAL).
 
 
-		Chapter 8: Data structures
+		Chapter : Data structures
 
 Data structures that have visibility outside the single-threaded
 environment they are created and destroyed in should always have
 reference counts.  In the kernel, garbage collection doesn't exist (and
 outside the kernel garbage collection is slow and inefficient), which
-means that you absolutely _have_ to reference count all your uses. 
+means that you absolutely _have_ to reference count all your uses.
 
 Reference counting means that you can avoid locking, and allows multiple
 users to have access to the data structure in parallel - and not having
 to worry about the structure suddenly going away from under them just
-because they slept or did something else for a while. 
+because they slept or did something else for a while.
 
-Note that locking is _not_ a replacement for reference counting. 
+Note that locking is _not_ a replacement for reference counting.
 Locking is used to keep data structures coherent, while reference
 counting is a memory management technique.  Usually both are needed, and
 they are not to be confused with each other.
@@ -264,3 +347,50 @@
 
 Remember: if another thread can find your data structure, and you don't
 have a reference count on it, you almost certainly have a bug.
+
+		Chapter : Parenthesis in expressions
+
+Complex expressions are easier to understand and maintain when extra
+parenthesis are used. Here is an extreme example
+
+x = (((a + (b * c)) & d) | e)  // would work also without any parenthesis
+
+
+		Chapter : Macros
+
+Macros defining constants are capitalized.
+
+#define CONSTANT 0x12345
+
+CAPITALIZED macro names are appreciated but macros resembling functions
+may be named in lower case.
+
+Macros with multiple statements should be enclosed in a do - while block.
+
+#define macrofun(a,b,c) 		\
+do {					\
+	if (a == 5)			\
+		do_this(b,c);		\
+					\
+} while (0)
+
+Macros defining expressions must enclose the expression in parenthesis
+to reduce sideeffects.
+
+#define CONSTEXP (CONSTANT | 3)
+#define MACWEXP(a,b) ((a) + (b))
+
+
+		Chapter : printk formating
+
+Periods terminating kernel messages are deprecated
+
+Usage of the apostrophe <'> in kernel messages is deprecated
+
+Mis-spellings allowed in kernel messages are:
+
+	dont, cant
+
+Printing numbers in parenthesis ie (%d) is deprecated
+
+

