Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWEAAmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEAAmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 20:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEAAmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 20:42:04 -0400
Received: from xenotime.net ([66.160.160.81]:44983 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750704AbWEAAmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 20:42:02 -0400
Date: Sun, 30 Apr 2006 17:44:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] CodingStyle: add typedefs chapter
Message-Id: <20060430174426.a21b4614.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add a chapter on typedefs, copied from an email from Linus
to lkml on Feb. 3, 2006.
(Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/CodingStyle |   77 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 65 insertions(+), 12 deletions(-)

--- linux-2617-rc3.orig/Documentation/CodingStyle
+++ linux-2617-rc3/Documentation/CodingStyle
@@ -155,7 +155,60 @@ problem, which is called the function-gr
 See next chapter.
 
 
-		Chapter 5: Functions
+		Chapter 5: Typedefs
+
+Please don't use things like "vps_t".
+
+It's a _mistake_ to use typedef for structures and pointers. When you see a
+
+	vps_t a;
+
+in the source, what does it mean?
+
+In contrast, if it says
+
+	struct virtual_container *a;
+
+you can actually tell what "a" is.
+
+Lots of people think that typedefs "help readability". Not so. They are
+useful only for:
+
+ (a) totally opaque objects (where the typedef is actively used to _hide_
+     what the object is).
+
+     Example: "pte_t" etc. opaque objects that you can only access using
+     the proper accessor functions.
+
+     NOTE! Opaqueness and "accessor functions" are not good in themselves.
+     The reason we have them for things like pte_t etc. is that there
+     really is absolutely _zero_ portably accessible information there.
+
+ (b) Clear integer types, where the abstraction _helps_ avoid confusion
+     whether it is "int" or "long".
+
+     u8/u16/u32 are perfectly fine typedefs.
+
+     NOTE! Again - there needs to be a _reason_ for this. If something is
+     "unsigned long", then there's no reason to do
+
+	typedef long myflags_t;
+
+     but if there is a clear reason for why it under certain circumstances
+     might be an "unsigned int" and under other configurations might be
+     "unsigned long", then by all means go ahead and use a typedef.
+
+ (c) when you use sparse to literally create a _new_ type for
+     type-checking.
+
+Maybe there are other cases too, but the rule should basically be to NEVER
+EVER use a typedef unless you can clearly match one of those rules.
+
+In general, a pointer, or a struct that has elements that can reasonably
+be directly accessed should _never_ be a typedef.
+
+
+		Chapter 6: Functions
 
 Functions should be short and sweet, and do just one thing.  They should
 fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
@@ -183,7 +236,7 @@ and it gets confused.  You know you're b
 to understand what you did 2 weeks from now.
 
 
-		Chapter 6: Centralized exiting of functions
+		Chapter 7: Centralized exiting of functions
 
 Albeit deprecated by some people, the equivalent of the goto statement is
 used frequently by compilers in form of the unconditional jump instruction.
@@ -220,7 +273,7 @@ out:
 	return result;
 }
 
-		Chapter 7: Commenting
+		Chapter 8: Commenting
 
 Comments are good, but there is also a danger of over-commenting.  NEVER
 try to explain HOW your code works in a comment: it's much better to
@@ -240,7 +293,7 @@ When commenting the kernel API functions
 See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
 for details.
 
-		Chapter 8: You've made a mess of it
+		Chapter 9: You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that "GNU emacs" automatically formats the C sources for
@@ -288,7 +341,7 @@ re-formatting you may want to take a loo
 remember: "indent" is not a fix for bad programming.
 
 
-		Chapter 9: Configuration-files
+		Chapter 10: Configuration-files
 
 For configuration options (arch/xxx/Kconfig, and all the Kconfig files),
 somewhat different indentation is used.
@@ -313,7 +366,7 @@ support for file-systems, for instance) 
 experimental options should be denoted (EXPERIMENTAL).
 
 
-		Chapter 10: Data structures
+		Chapter 11: Data structures
 
 Data structures that have visibility outside the single-threaded
 environment they are created and destroyed in should always have
@@ -344,7 +397,7 @@ Remember: if another thread can find you
 have a reference count on it, you almost certainly have a bug.
 
 
-		Chapter 11: Macros, Enums and RTL
+		Chapter 12: Macros, Enums and RTL
 
 Names of macros defining constants and labels in enums are capitalized.
 
@@ -399,7 +452,7 @@ The cpp manual deals with macros exhaust
 covers RTL which is used frequently with assembly language in the kernel.
 
 
-		Chapter 12: Printing kernel messages
+		Chapter 13: Printing kernel messages
 
 Kernel developers like to be seen as literate. Do mind the spelling
 of kernel messages to make a good impression. Do not use crippled
@@ -410,7 +463,7 @@ Kernel messages do not have to be termin
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
-		Chapter 13: Allocating memory
+		Chapter 14: Allocating memory
 
 The kernel provides the following general purpose memory allocators:
 kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
@@ -429,7 +482,7 @@ from void pointer to any other pointer t
 language.
 
 
-		Chapter 14: The inline disease
+		Chapter 15: The inline disease
 
 There appears to be a common misperception that gcc has a magic "make me
 faster" speedup option called "inline". While the use of inlines can be
@@ -457,7 +510,7 @@ something it would have done anyway.
 
 
 
-		Chapter 15: References
+		Appendix I: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.
@@ -481,4 +534,4 @@ Kernel CodingStyle, by greg@kroah.com at
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
 
 --
-Last updated on 30 December 2005 by a community effort on LKML.
+Last updated on 30 April 2006.


---
