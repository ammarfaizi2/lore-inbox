Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUCGUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUCGUJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 15:09:59 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:52897 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262322AbUCGUJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 15:09:11 -0500
Date: Mon, 08 Mar 2004 04:08:34 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "kernel mailing list" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4icwkqr4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Here is a patch to update 2.4 Codingstyle.

It is equivalent to the 2.6 version except for
Chapter 9 Configuration files which is unchanged

Please apply.

Regards
Michael

diff -uN linux-2.4.25-mhf184/Documentation/CodingStyle.mhf.orig linux-2.4.25-mhf184/Documentation/CodingStyle
--- linux-2.4.25-mhf184/Documentation/CodingStyle.mhf.orig	2004-02-27 12:30:50.000000000 +0800
+++ linux-2.4.25-mhf184/Documentation/CodingStyle	2004-03-08 04:04:11.000000000 +0800
@@ -1,42 +1,75 @@

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

+Don't put multiple statements on a single line unless you have
+something to hide:

-		Chapter 2: Placing Braces
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
+substantially to the right. The same applies to function headers with a long
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

  The other issue that always comes up in C styling is the placement of
  braces.  Unlike the indent size, there are few technical reasons to
@@ -59,7 +92,7 @@
  Heretic people all over the world have claimed that this inconsistency
  is ...  well ...  inconsistent, but all right-thinking people know that
  (a) K&R are _right_ and (b) K&R are right.  Besides, functions are
-special anyway (you can't nest them in C).
+special anyway (you can't nest them in C).

  Note that the closing brace is empty on a line of its own, _except_ in
  the cases where it is followed by a continuation of the same statement,
@@ -79,60 +112,60 @@
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
+		Chapter 4: Naming

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
+		Chapter 5: Functions

  Functions should be short and sweet, and do just one thing.  They should
  fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
-as we all know), and do one thing and do that well.
+as we all know), and do one thing and do that well.

  The maximum length of a function is inversely proportional to the
  complexity and indentation level of that function.  So, if you have a
  conceptually simple function that is just one long (but simple)
  case-statement, where you have to do lots of small things for a lot of
-different cases, it's OK to have a longer function.
+different cases, it's OK to have a longer function.

  However, if you have a complex function, and you suspect that a
  less-than-gifted first-year high-school student might not even
@@ -140,41 +173,78 @@
  maximum limits all the more closely.  Use helper functions with
  descriptive names (you can ask the compiler to in-line them if you think
  it's performance-critical, and it will probably do a better job of it
-that you would have done).
+than you would have done).

  Another measure of the function is the number of local variables.  They
  shouldn't exceed 5-10, or you're doing something wrong.  Re-think the
  function, and split it into smaller pieces.  A human brain can
  generally easily keep track of about 7 different things, anything more
  and it gets confused.  You know you're brilliant, but maybe you'd like
-to understand what you did 2 weeks from now.
+to understand what you did 2 weeks from now.
+
+
+		Chapter 6: Centralized exiting of functions

+Albeit deprecated by some people, the equivalent of the goto statement is
+used frequently by compilers in form of the unconditional jump instruction.

-		Chapter 5: Commenting
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
+	int result = 0;
+	char *buffer = kmalloc(SIZE);
+
+	if (buffer == NULL)
+		return -ENOMEM;
+
+	if (condition1) {
+		while (loop1) {
+			...
+		}
+		result = 1;
+		goto out;
+	}
+	...
+out:
+	kfree(buffer);
+	return result;
+}
+
+		Chapter 7: Commenting

  Comments are good, but there is also a danger of over-commenting.  NEVER
  try to explain HOW your code works in a comment: it's much better to
  write the code so that the _working_ is obvious, and it's a waste of
-time to explain badly written code.
+time to explain badly written code.

-Generally, you want your comments to tell WHAT your code does, not HOW.
+Generally, you want your comments to tell WHAT your code does, not HOW.
  Also, try to avoid putting comments inside a function body: if the
  function is so complex that you need to separately comment parts of it,
-you should probably go back to chapter 4 for a while.  You can make
+you should probably go back to chapter 5 for a while.  You can make
  small comments to note or warn about something particularly clever (or
  ugly), but try to avoid excess.  Instead, put the comments at the head
  of the function, telling people what it does, and possibly WHY it does
-it.
+it.


-		Chapter 6: You've made a mess of it
+		Chapter 8: You've made a mess of it

  That's OK, we all do.  You've probably been told by your long-time Unix
  user helper that "GNU emacs" automatically formats the C sources for
  you, and you've noticed that yes, it does do that, but the defaults it
  uses are less than desirable (in fact, they are worse than random
-typing - a infinite number of monkeys typing into GNU emacs would never
-make a good program).
+typing - an infinite number of monkeys typing into GNU emacs would never
+make a good program).

  So, you can either get rid of GNU emacs, or change it to use saner
  values.  To do the latter, you can stick the following in your .emacs file:
@@ -192,7 +262,7 @@
  to add

  (setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
-                       auto-mode-alist))
+			auto-mode-alist))

  to your .emacs file if you want to have linux-c-mode switched on
  automagically when you edit source files under /usr/src/linux.
@@ -200,19 +270,20 @@
  But even if you fail in getting emacs to do sane formatting, not
  everything is lost: use "indent".

-Now, again, GNU indent has the same brain dead settings that GNU emacs
-has, which is why you need to give it a few command line options.
+Now, again, GNU indent has the same brain-dead settings that GNU emacs
+has, which is why you need to give it a few command line options.
  However, that's not too bad, because even the makers of GNU indent
  recognize the authority of K&R (the GNU people aren't evil, they are
  just severely misguided in this matter), so you just give indent the
-options "-kr -i8" (stands for "K&R, 8 character indents").
+options "-kr -i8" (stands for "K&R, 8 character indents"), or use
+"scripts/Lindent", which indents in the latest style.

  "indent" has a lot of options, and especially when it comes to comment
-re-formatting you may want to take a look at the manual page.  But
-remember: "indent" is not a fix for bad programming.
+re-formatting you may want to take a look at the man page.  But
+remember: "indent" is not a fix for bad programming.


-		Chapter 7: Configuration-files
+		Chapter 9: Configuration-files

  For configuration options (arch/xxx/config.in, and all the Config.in files),
  somewhat different indentation is used.
@@ -235,20 +306,20 @@
  Experimental options should be denoted (EXPERIMENTAL).


-		Chapter 8: Data structures
+		Chapter 10: Data structures

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
@@ -258,9 +329,99 @@
  the number of subclass users, and decrements the global count just once
  when the subclass count goes to zero.

-Examples of this kind of "multi-reference-counting" can be found in
+Examples of this kind of "multi-level-reference-counting" can be found in
  memory management ("struct mm_struct": mm_users and mm_count), and in
  filesystem code ("struct super_block": s_count and s_active).

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
+		if (a == 5)			\
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
+is a _very_ bad idea.  It looks like a function call but exits the "calling"
+function; don't break the internal parsers of those who will read the code.
+
+2) macros that depend on having a local variable with a magic name:
+
+#define FOO(val) bar(index, val)
+
+might look like a good thing, but it's confusing as hell when one reads the
+code and it's prone to breakage from seemingly innocent changes.
+
+3) macros with arguments that are used as l-values: FOO(x) = y; will
+bite you if somebody e.g. turns FOO into an inline function.
+
+4) forgetting about precedence: macros defining constants using expressions
+must enclose the expression in parentheses. Beware of similar issues with
+macros using parameters.
+
+#define CONSTANT 0x4000
+#define CONSTEXP (CONSTANT | 3)
+
+The cpp manual deals with macros exhaustively. The gcc internals manual also
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
+URL: http://cm.bell-labs.com/cm/cs/cbook/
+
+The Practice of Programming
+by Brian W. Kernighan and Rob Pike.
+Addison-Wesley, Inc., 1999.
+ISBN 0-201-61586-X.
+URL: http://cm.bell-labs.com/cm/cs/tpop/
+
+GNU manuals - where in compliance with K&R and this text - for cpp, gcc,
+gcc internals and indent, all available from http://www.gnu.org
+
+WG14 is the international standardization working group for the programming
+language C, URL: http://std.dkuug.dk/JTC1/SC22/WG14/
+
+--
+Last updated on 16 February 2004 by a community effort on LKML.

