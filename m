Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbULOXwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbULOXwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbULOXwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:52:31 -0500
Received: from mail.dif.dk ([193.138.115.101]:52898 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262511AbULOXwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:52:16 -0500
Date: Thu, 16 Dec 2004 01:02:44 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/30] return statement cleanup - kill pointless parentheses
Message-ID: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here's the first batch of return statement cleanups (*many* to go).

The following patches clean up return statements of the forms
	return(foo);
	return ( fn() );
	return (123);
	return(a + b);
etc. To be instead
	return foo;
	return fn();
	return 123
	return a + b;

There are rare cases where a return expression is long and/or complicated 
where having the parentheses is a nice readability help. In those cases 
I've let them be.

This is only the first batch. I have many, many more patches lined up, but 
I need sleep as well as the next erson, so I'm going to submit this in 
batches over a couple of days (unless someone yells STOP ofcourse ;)

If these patches are generally acceted then I think it would make sense to 
make a small addition to Documentation/CodingStyle mentioning the prefered 
form of return statements, so we (hopefully) won't have to do cleanups 
like this too often in the future.
Below I've included a proposed patch adding such a bit to CodingStyle.

As I mentioned in my previous mail to lkml with the subject of 
"[RFC][example patch inside] return statement cleanups, get rid of unnecessary parentheses"
The reasons for doing this are :

1) the parentheses are pointless.
2) removing the parentheses decreases source file size slightly.
3) they look odd and when reading code you don't want to be stopped wondering - no parentheses is simply more readable (at least to me).
4) When I've submitted patches for other stuff in the past I've a few times been asked if I could fix up the return statements while I was at it - so it seems to be wanted.

Comments are welcome - as always :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/Documentation/CodingStyle	2004-10-18 23:53:46.000000000 +0200
+++ linux-2.6.10-rc3-bk8/Documentation/CodingStyle	2004-12-16 00:28:37.000000000 +0100
@@ -183,7 +183,28 @@
 to understand what you did 2 weeks from now.
 
 
-		Chapter 6: Centralized exiting of functions
+		Chapter 6: return statements and parentheses
+
+'return' is not a function, it's a statement.
+A lot of people like to write return(n); or return(fn()); or similar. Well
+don't. Adding parentheses to return is pointless in 99+% of all cases, it
+gains you nothing at all, except people spending more time puzzling over
+your code. 
+There are rare excetions where the return statement is a long complicated 
+expression and the parentheses may help to improve readability, but the 
+general rule is to avoid them unless there's a really good reason.
+
+so, don't write:
+	return(foo);
+	return(fn());
+	return ( 123456 );
+or similar. But do write:
+	return foo;
+	return fn();
+	return 123456;
+
+
+		Chapter 7: Centralized exiting of functions
 
 Albeit deprecated by some people, the equivalent of the goto statement is
 used frequently by compilers in form of the unconditional jump instruction.
@@ -220,7 +241,7 @@
 	return result;
 }
 
-		Chapter 7: Commenting
+		Chapter 8: Commenting
 
 Comments are good, but there is also a danger of over-commenting.  NEVER
 try to explain HOW your code works in a comment: it's much better to
@@ -237,7 +258,7 @@
 it.
 
 
-		Chapter 8: You've made a mess of it
+		Chapter 9: You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that "GNU emacs" automatically formats the C sources for
@@ -285,7 +306,7 @@
 remember: "indent" is not a fix for bad programming.
 
 
-		Chapter 9: Configuration-files
+		Chapter 10: Configuration-files
 
 For configuration options (arch/xxx/Kconfig, and all the Kconfig files),
 somewhat different indentation is used.
@@ -310,7 +331,7 @@
 experimental options should be denoted (EXPERIMENTAL).
 
 
-		Chapter 10: Data structures
+		Chapter 11: Data structures
 
 Data structures that have visibility outside the single-threaded
 environment they are created and destroyed in should always have
@@ -341,7 +362,7 @@
 have a reference count on it, you almost certainly have a bug.
 
 
-		Chapter 11: Macros, Enums, Inline functions and RTL
+		Chapter 12: Macros, Enums, Inline functions and RTL
 
 Names of macros defining constants and labels in enums are capitalized.
 
@@ -396,7 +417,7 @@
 covers RTL which is used frequently with assembly language in the kernel.
 
 
-		Chapter 12: Printing kernel messages
+		Chapter 13: Printing kernel messages
 
 Kernel developers like to be seen as literate. Do mind the spelling
 of kernel messages to make a good impression. Do not use crippled
@@ -407,7 +428,7 @@
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
-		Chapter 13: References
+		Chapter 14: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.



PS.
Andrew: I'm CC'ing you on this first mail since you are 2.6 maintainer, 
and if you NACK these patches I won't bother with more, but don't worry, I 
won't spam your inbox with all 30 , I trust you can pick them up from lkml 
if wanted.


