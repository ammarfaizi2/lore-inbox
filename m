Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUBPDj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUBPDj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:39:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:2239 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265315AbUBPDiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:38:51 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH, RFC: Version 5 of 2.6 Codingstyle
Date: Mon, 16 Feb 2004 11:47:53 +0800
User-Agent: KMail/1.5.4
References: <200402130615.10608.mhf@linuxmail.org>
In-Reply-To: <200402130615.10608.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p1DMAxToDOHfQO2"
Message-Id: <200402161147.53123.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_p1DMAxToDOHfQO2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changes:

Expanded references.

Pointer to RTL reference.

Cleanups and fixed more typos

diff against in-kernel version attached.

Regards
Michael

--- Documentation/CodingStyle.mhf.orig.4	2004-02-15 04:30:40.000000000 +0800
+++ Documentation/CodingStyle	2004-02-16 11:38:40.000000000 +0800
@@ -41,10 +41,10 @@
 	if (condition) do_this;
 	  do_something_everytime;

-Outside of comments and except in Kconfig, spaces are never used for
-indentation, and the above example is deliberately broken.
+Outside of comments, documentation and except in Kconfig, spaces are never
+used for indentation, and the above example is deliberately broken.

-Don't leave whitespace at the end of lines.
+Get a decent editor and don't leave whitespace at the end of lines.
 
 
 		Chapter 2: Breaking long lines and strings
@@ -57,7 +57,7 @@
 Statements longer than 80 columns will be broken into sensible chunks.
 Descendants are always substantially shorter than the parent and are placed
 substantially to the right. The same applies to function headers with a long
-argument list. Long strings are as well broken into smaller strings.
+argument list. Long strings are as well broken into shorter strings.
 
 void fun(int a, int b, int c)
 {
@@ -203,12 +203,9 @@
 {
 	int result = 0;
 	char *buffer = kmalloc(SIZE);
-	lock(something);
 
-	if (buffer == NULL) {
-		result = -1;
-		goto out;
-	}
+	if (buffer == NULL)
+		return -ENOMEM;

 	if (condition1) {
 		while (loop1) {
@@ -219,9 +216,7 @@
 	}
 	...
 out:
-	unlock(something);
-	if (buffer != NULL)	// This test is not needed for kfree
-		kfree(buffer);	// as kfree checks pointer
+	kfree(buffer);
 	return result;
 }
 
@@ -235,7 +230,7 @@
 Generally, you want your comments to tell WHAT your code does, not HOW.
 Also, try to avoid putting comments inside a function body: if the
 function is so complex that you need to separately comment parts of it,
-you should probably go back to chapter 4 for a while.  You can make
+you should probably go back to chapter 5 for a while.  You can make
 small comments to note or warn about something particularly clever (or
 ugly), but try to avoid excess.  Instead, put the comments at the head
 of the function, telling people what it does, and possibly WHY it does
@@ -344,7 +339,7 @@
 have a reference count on it, you almost certainly have a bug.
 
 
-		Chapter 11: Macros, Enums and Inline functions
+		Chapter 11: Macros, Enums, Inline functions and RTL
 
 Names of macros defining constants and labels in enums are capitalized.
 
@@ -357,13 +352,13 @@
 
 Generally, inline functions are preferable to macros resembling functions.
 
-Macros with multiple statements should be enclosed in a do - while block.
+Macros with multiple statements should be enclosed in a do - while block:
 
-#define macrofun(a,b,c) 		\
-do {					\
-	if (a == 5)			\
-		do_this(b,c);		\
-} while (0)
+#define macrofun(a,b,c) 			\
+	do {					\
+		if (a == 5)			\
+			do_this(b,c);		\
+	} while (0)
 
 Things to avoid when using macros:
 
@@ -389,12 +384,15 @@
 bite you if somebody e.g. turns FOO into an inline function.

 4) forgetting about precedence: macros defining constants using expressions
-must enclose the expression in parentheses. Beware of similar issues in
+must enclose the expression in parentheses. Beware of similar issues with
 macros using parameters.
 
 #define CONSTANT 0x4000
 #define CONSTEXP (CONSTANT | 3)
 
+The cpp manual deals with macros exhaustively. The gcc internals manual also
+covers RTL which is used frequently with assembly language in the kernel.
+
 
 		Chapter 12: Printing kernel messages
 
@@ -404,7 +402,7 @@
 
 Kernel messages do not have to be terminated with a period.
 
-Printing numbers in parenthesis (%d) adds no value and should be avoided.
+Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
 		Chapter 13: References
@@ -414,8 +412,12 @@
 Prentice Hall, Inc., 1988.
 ISBN 0-13-110362-8 (paperback), 0-13-110370-9 (hardback).
 
-GNU manuals for cpp, gcc and indent, available from www.gnu.org, while in
-compliance with K&R and this text.
+The Practice of Programming
+Brian W. Kernighan, Rob Pike
+Addison-Wesley, 1999, ISBN 0-201-61586-X
+
+GNU manuals - where in compliance with K&R and this text - for cpp, gcc,
+gcc internals and indent, all available from www.gnu.org.
 
 --
-This document was updated by a community effort on LKML on 14 February 2004.
+Last updated on 16 February 2004 by a community effort on LKML.

--Boundary-00=_p1DMAxToDOHfQO2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Codingstyle-5.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Codingstyle-5.diff"

=2D-- Documentation/CodingStyle.mhf.orig	2004-01-31 17:38:02.000000000 +0800
+++ Documentation/CodingStyle	2004-02-16 11:38:40.000000000 +0800
@@ -1,42 +1,75 @@
=20
=2D		Linux kernel coding style=20
+		Linux kernel coding style
=20
 This is a short document describing the preferred coding style for the
 linux kernel.  Coding style is very personal, and I won't _force_ my
 views on anybody, but this is what goes for anything that I have to be
 able to maintain, and I'd prefer it for most other things too.  Please
=2Dat least consider the points made here.=20
+at least consider the points made here.
=20
 First off, I'd suggest printing out a copy of the GNU coding standards,
=2Dand NOT read it.  Burn them, it's a great symbolic gesture.=20
+and NOT read it.  Burn them, it's a great symbolic gesture.
=20
 Anyway, here goes:
=20
=20
 	 	Chapter 1: Indentation
=20
=2DTabs are 8 characters, and thus indentations are also 8 characters.=20
+Tabs are 8 characters, and thus indentations are also 8 characters.
 There are heretic movements that try to make indentations 4 (or even 2!)
 characters deep, and that is akin to trying to define the value of PI to
=2Dbe 3.=20
+be 3.
=20
 Rationale: The whole idea behind indentation is to clearly define where
 a block of control starts and ends.  Especially when you've been looking
 at your screen for 20 straight hours, you'll find it a lot easier to see
=2Dhow the indentation works if you have large indentations.=20
+how the indentation works if you have large indentations.
=20
 Now, some people will claim that having 8-character indentations makes
 the code move too far to the right, and makes it hard to read on a
 80-character terminal screen.  The answer to that is that if you need
 more than 3 levels of indentation, you're screwed anyway, and should fix
=2Dyour program.=20
+your program.
=20
 In short, 8-char indents make things easier to read, and have the added
=2Dbenefit of warning you when you're nesting your functions too deep.=20
=2DHeed that warning.=20
+benefit of warning you when you're nesting your functions too deep.
+Heed that warning.
=20
+Don't put multiple statements on a single line unless you have
+something to hide:
=20
=2D		Chapter 2: Placing Braces
+	if (condition) do_this;
+	  do_something_everytime;
+
+Outside of comments, documentation and except in Kconfig, spaces are never
+used for indentation, and the above example is deliberately broken.
+
+Get a decent editor and don't leave whitespace at the end of lines.
+
+
+		Chapter 2: Breaking long lines and strings
+
+Coding style is all about readability and maintainability using commonly
+available tools.
+
+The limit on the length of lines is 80 columns and this is a hard limit.
+
+Statements longer than 80 columns will be broken into sensible chunks.
+Descendants are always substantially shorter than the parent and are placed
+substantially to the right. The same applies to function headers with a lo=
ng
+argument list. Long strings are as well broken into shorter strings.
+
+void fun(int a, int b, int c)
+{
+	if (condition)
+		printk(KERN_WARNING "Warning this is a long printk with "
+						"3 parameters a: %u b: %u "
+						"c: %u \n", a, b, c);
+	else
+		next_statement;
+}
+
+		Chapter 3: Placing Braces
=20
 The other issue that always comes up in C styling is the placement of
 braces.  Unlike the indent size, there are few technical reasons to
@@ -59,7 +92,7 @@
 Heretic people all over the world have claimed that this inconsistency
 is ...  well ...  inconsistent, but all right-thinking people know that
 (a) K&R are _right_ and (b) K&R are right.  Besides, functions are
=2Dspecial anyway (you can't nest them in C).=20
+special anyway (you can't nest them in C).
=20
 Note that the closing brace is empty on a line of its own, _except_ in
 the cases where it is followed by a continuation of the same statement,
@@ -79,60 +112,60 @@
 	} else {
 		....
 	}
=2D		=09
=2DRationale: K&R.=20
+
+Rationale: K&R.
=20
 Also, note that this brace-placement also minimizes the number of empty
 (or almost empty) lines, without any loss of readability.  Thus, as the
 supply of new-lines on your screen is not a renewable resource (think
 25-line terminal screens here), you have more empty lines to put
=2Dcomments on.=20
+comments on.
=20
=20
=2D		Chapter 3: Naming
+		Chapter 4: Naming
=20
 C is a Spartan language, and so should your naming be.  Unlike Modula-2
 and Pascal programmers, C programmers do not use cute names like
 ThisVariableIsATemporaryCounter.  A C programmer would call that
 variable "tmp", which is much easier to write, and not the least more
=2Ddifficult to understand.=20
+difficult to understand.
=20
 HOWEVER, while mixed-case names are frowned upon, descriptive names for
 global variables are a must.  To call a global function "foo" is a
=2Dshooting offense.=20
+shooting offense.
=20
 GLOBAL variables (to be used only if you _really_ need them) need to
 have descriptive names, as do global functions.  If you have a function
 that counts the number of active users, you should call that
=2D"count_active_users()" or similar, you should _not_ call it "cntusr()".=
=20
+"count_active_users()" or similar, you should _not_ call it "cntusr()".
=20
 Encoding the type of a function into the name (so-called Hungarian
 notation) is brain damaged - the compiler knows the types anyway and can
 check those, and it only confuses the programmer.  No wonder MicroSoft
=2Dmakes buggy programs.=20
+makes buggy programs.
=20
 LOCAL variable names should be short, and to the point.  If you have
=2Dsome random integer loop counter, it should probably be called "i".=20
+some random integer loop counter, it should probably be called "i".
 Calling it "loop_counter" is non-productive, if there is no chance of it
 being mis-understood.  Similarly, "tmp" can be just about any type of
=2Dvariable that is used to hold a temporary value.=20
+variable that is used to hold a temporary value.
=20
 If you are afraid to mix up your local variable names, you have another
=2Dproblem, which is called the function-growth-hormone-imbalance syndrome.=
=20
=2DSee next chapter.=20
+problem, which is called the function-growth-hormone-imbalance syndrome.
+See next chapter.
=20
=2D	=09
=2D		Chapter 4: Functions
+
+		Chapter 5: Functions
=20
 Functions should be short and sweet, and do just one thing.  They should
 fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
=2Das we all know), and do one thing and do that well.=20
+as we all know), and do one thing and do that well.
=20
 The maximum length of a function is inversely proportional to the
 complexity and indentation level of that function.  So, if you have a
 conceptually simple function that is just one long (but simple)
 case-statement, where you have to do lots of small things for a lot of
=2Ddifferent cases, it's OK to have a longer function.=20
+different cases, it's OK to have a longer function.
=20
 However, if you have a complex function, and you suspect that a
 less-than-gifted first-year high-school student might not even
@@ -140,41 +173,78 @@
 maximum limits all the more closely.  Use helper functions with
 descriptive names (you can ask the compiler to in-line them if you think
 it's performance-critical, and it will probably do a better job of it
=2Dthan you would have done).=20
+than you would have done).
=20
 Another measure of the function is the number of local variables.  They
 shouldn't exceed 5-10, or you're doing something wrong.  Re-think the
 function, and split it into smaller pieces.  A human brain can
 generally easily keep track of about 7 different things, anything more
 and it gets confused.  You know you're brilliant, but maybe you'd like
=2Dto understand what you did 2 weeks from now.=20
+to understand what you did 2 weeks from now.
+
+
+		Chapter 6: Centralized exiting of functions
=20
+Albeit deprecated by some people, the equivalent of the goto statement is
+used frequently by compilers in form of the unconditional jump instruction.
=20
=2D		Chapter 5: Commenting
+The goto statement comes in handy when a function exits from multiple
+locations and some common work such as cleanup has to be done.
+
+The rationale is:
+
+- unconditional statements are easier to understand and follow
+- nesting is reduced
+- errors by not updating individual exit points when making
+    modifications are prevented
+- saves the compiler work to optimize redundant code away ;)
+
+int fun(int )
+{
+	int result =3D 0;
+	char *buffer =3D kmalloc(SIZE);
+
+	if (buffer =3D=3D NULL)
+		return -ENOMEM;
+
+	if (condition1) {
+		while (loop1) {
+			...
+		}
+		result =3D 1;
+		goto out;
+	}
+	...
+out:
+	kfree(buffer);
+	return result;
+}
+
+		Chapter 7: Commenting
=20
 Comments are good, but there is also a danger of over-commenting.  NEVER
 try to explain HOW your code works in a comment: it's much better to
 write the code so that the _working_ is obvious, and it's a waste of
=2Dtime to explain badly written code.=20
+time to explain badly written code.
=20
=2DGenerally, you want your comments to tell WHAT your code does, not HOW.=
=20
+Generally, you want your comments to tell WHAT your code does, not HOW.
 Also, try to avoid putting comments inside a function body: if the
 function is so complex that you need to separately comment parts of it,
=2Dyou should probably go back to chapter 4 for a while.  You can make
+you should probably go back to chapter 5 for a while.  You can make
 small comments to note or warn about something particularly clever (or
 ugly), but try to avoid excess.  Instead, put the comments at the head
 of the function, telling people what it does, and possibly WHY it does
=2Dit.=20
+it.
=20
=20
=2D		Chapter 6: You've made a mess of it
+		Chapter 8: You've made a mess of it
=20
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that "GNU emacs" automatically formats the C sources for
 you, and you've noticed that yes, it does do that, but the defaults it
 uses are less than desirable (in fact, they are worse than random
 typing - an infinite number of monkeys typing into GNU emacs would never
=2Dmake a good program).=20
+make a good program).
=20
 So, you can either get rid of GNU emacs, or change it to use saner
 values.  To do the latter, you can stick the following in your .emacs file:
@@ -192,7 +262,7 @@
 to add
=20
 (setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
=2D                       auto-mode-alist))
+auto-mode-alist))
=20
 to your .emacs file if you want to have linux-c-mode switched on
 automagically when you edit source files under /usr/src/linux.
@@ -201,33 +271,36 @@
 everything is lost: use "indent".
=20
 Now, again, GNU indent has the same brain-dead settings that GNU emacs
=2Dhas, which is why you need to give it a few command line options.=20
+has, which is why you need to give it a few command line options.
 However, that's not too bad, because even the makers of GNU indent
 recognize the authority of K&R (the GNU people aren't evil, they are
 just severely misguided in this matter), so you just give indent the
=2Doptions "-kr -i8" (stands for "K&R, 8 character indents").=20
+options "-kr -i8" (stands for "K&R, 8 character indents"), or use
+"scripts/Lindent", which indents in the latest style.
=20
 "indent" has a lot of options, and especially when it comes to comment
=2Dre-formatting you may want to take a look at the manual page.  But
=2Dremember: "indent" is not a fix for bad programming.=20
+re-formatting you may want to take a look at the man page.  But
+remember: "indent" is not a fix for bad programming.
=20
=20
=2D		Chapter 7: Configuration-files
+		Chapter 9: Configuration-files
=20
=2DFor configuration options (arch/xxx/config.in, and all the Config.in fil=
es),
+For configuration options (arch/xxx/Kconfig, and all the Kconfig files),
 somewhat different indentation is used.
=20
=2DAn indention level of 3 is used in the code, while the text in the confi=
g-
=2Doptions should have an indention-level of 2 to indicate dependencies. The
=2Dlatter only applies to bool/tristate options. For other options, just use
=2Dcommon sense. An example:
=2D
=2Dif [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
=2D   tristate 'Apply nitroglycerine inside the keyboard (DANGEROUS)' CONFI=
G_BOOM
=2D   if [ "$CONFIG_BOOM" !=3D "n" ]; then
=2D      bool '  Output nice messages when you explode' CONFIG_CHEER
=2D   fi
=2Dfi
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
=20
 Generally, CONFIG_EXPERIMENTAL should surround all options not considered
 stable. All options that are known to trash data (experimental write-
@@ -235,20 +308,20 @@
 experimental options should be denoted (EXPERIMENTAL).
=20
=20
=2D		Chapter 8: Data structures
+		Chapter 10: Data structures
=20
 Data structures that have visibility outside the single-threaded
 environment they are created and destroyed in should always have
 reference counts.  In the kernel, garbage collection doesn't exist (and
 outside the kernel garbage collection is slow and inefficient), which
=2Dmeans that you absolutely _have_ to reference count all your uses.=20
+means that you absolutely _have_ to reference count all your uses.
=20
 Reference counting means that you can avoid locking, and allows multiple
 users to have access to the data structure in parallel - and not having
 to worry about the structure suddenly going away from under them just
=2Dbecause they slept or did something else for a while.=20
+because they slept or did something else for a while.
=20
=2DNote that locking is _not_ a replacement for reference counting.=20
+Note that locking is _not_ a replacement for reference counting.
 Locking is used to keep data structures coherent, while reference
 counting is a memory management technique.  Usually both are needed, and
 they are not to be confused with each other.
@@ -264,3 +337,87 @@
=20
 Remember: if another thread can find your data structure, and you don't
 have a reference count on it, you almost certainly have a bug.
+
+
+		Chapter 11: Macros, Enums, Inline functions and RTL
+
+Names of macros defining constants and labels in enums are capitalized.
+
+#define CONSTANT 0x12345
+
+Enums are preferred when defining several related constants.
+
+CAPITALIZED macro names are appreciated but macros resembling functions
+may be named in lower case.
+
+Generally, inline functions are preferable to macros resembling functions.
+
+Macros with multiple statements should be enclosed in a do - while block:
+
+#define macrofun(a,b,c) 			\
+	do {					\
+		if (a =3D=3D 5)			\
+			do_this(b,c);		\
+	} while (0)
+
+Things to avoid when using macros:
+
+1) macros that affect control flow:
+
+#define FOO(x)					\
+	do {					\
+		if (blah(x) < 0)		\
+			return -EBUGGERED;	\
+	} while(0)
+
+is a _very_ bad idea. =A0It looks like a function call but exits the "call=
ing"
+function; don't break the internal parsers of those who will read the code.
+
+2) macros that depend on having a local variable with a magic name:
+
+#define FOO(val) bar(index, val)
+
+might look like a good thing, but it's confusing as hell when one reads the
+code and it's prone to breakage from seemingly innocent changes.
+
+3) macros with arguments that are used as l-values: FOO(x) =3D y; will
+bite you if somebody e.g. turns FOO into an inline function.
+
+4) forgetting about precedence: macros defining constants using expressions
+must enclose the expression in parentheses. Beware of similar issues with
+macros using parameters.
+
+#define CONSTANT 0x4000
+#define CONSTEXP (CONSTANT | 3)
+
+The cpp manual deals with macros exhaustively. The gcc internals manual al=
so
+covers RTL which is used frequently with assembly language in the kernel.
+
+
+		Chapter 12: Printing kernel messages
+
+Kernel developers like to be seen as literate. Do mind the spelling
+of kernel messages to make a good impression. Do not use crippled
+words like "dont" and use "do not" or "don't" instead.
+
+Kernel messages do not have to be terminated with a period.
+
+Printing numbers in parentheses (%d) adds no value and should be avoided.
+
+
+		Chapter 13: References
+
+The C Programming Language, Second Edition
+by Brian W. Kernighan and Dennis M. Ritchie.
+Prentice Hall, Inc., 1988.
+ISBN 0-13-110362-8 (paperback), 0-13-110370-9 (hardback).
+
+The Practice of Programming
+Brian W. Kernighan, Rob Pike
+Addison-Wesley, 1999, ISBN 0-201-61586-X
+
+GNU manuals - where in compliance with K&R and this text - for cpp, gcc,
+gcc internals and indent, all available from www.gnu.org.
+
+--
+Last updated on 16 February 2004 by a community effort on LKML.

--Boundary-00=_p1DMAxToDOHfQO2--

