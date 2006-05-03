Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWECTii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWECTii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWECTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:38:38 -0400
Received: from xenotime.net ([66.160.160.81]:10689 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750761AbWECTih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:38:37 -0400
Date: Wed, 3 May 2006 12:41:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, js@linuxtv.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Message-Id: <20060503124100.9b50aa12.rdunlap@xenotime.net>
In-Reply-To: <1146612136.19101.47.camel@pmac.infradead.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	<1146503166.2885.137.camel@hades.cambridge.redhat.com>
	<20060502003755.GA26327@linuxtv.org>
	<1146576495.14059.45.camel@pmac.infradead.org>
	<20060502142050.GC27798@linuxtv.org>
	<1146580308.17934.19.camel@pmac.infradead.org>
	<20060502101113.17c75a05.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
	<1146595853.19101.38.camel@pmac.infradead.org>
	<Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
	<1146612136.19101.47.camel@pmac.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2006 00:22:16 +0100 David Woodhouse wrote:

> On Tue, 2006-05-02 at 12:07 -0700, Linus Torvalds wrote:
> > And that wasn't what I objected to. 
> > 
> > What I objected to was that other part, which said that "uint32_t" was 
> > somehow more standard.
> 
> It didn't say "more standard". It referred to "the standard C99 types".
> 
> It's heading off the question "why object to ifdefs but permit _these_
> gratuitous ones?" which would otherwise be asked.
> 
> It's a document which is _describing_ the Linux coding style. To refer
> to u32 et al as 'standard' would be self-referential. Describe them as
> 'the Linux standard types' in other documents by all means, but it
> doesn't make much sense to do so in Documentation/CodingStyle.

All references to "standard types" now say "standard C99 types".
However, Linus still objects to the C99 integer typedefs AFAICT.
Are we at an impasse?
It would be a really Good Idea to have something about typedefs
in Doc/CodingStyle.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Add a chapter on typedefs, based on an email from Linus
to lkml on Feb. 3, 2006:
(Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup)
with added lkml feedback, esp. David Woodhouse.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/CodingStyle |  100 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 88 insertions(+), 12 deletions(-)

--- linux-2617-rc3.orig/Documentation/CodingStyle
+++ linux-2617-rc3/Documentation/CodingStyle
@@ -155,7 +155,83 @@ problem, which is called the function-gr
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
+     u8/u16/u32 are perfectly fine typedefs, although they fit into
+     category (d) better than here.
+
+     NOTE! Again - there needs to be a _reason_ for this. If something is
+     "unsigned long", then there's no reason to do
+
+	typedef unsigned long myflags_t;
+
+     but if there is a clear reason for why it under certain circumstances
+     might be an "unsigned int" and under other configurations might be
+     "unsigned long", then by all means go ahead and use a typedef.
+
+ (c) when you use sparse to literally create a _new_ type for
+     type-checking.
+
+ (d) New types which are identical to standard C99 types, in certain
+     exceptional circumstances.
+
+     Although it would only take a short amount of time for the eyes and
+     brain to become accustomed to the standard C99 types like 'uint32_t',
+     some people object to their use anyway.
+
+     Therefore, the Linux-specific 'u8/u16/u32/u64' types and their
+     signed equivalents which are identical to standard C99 types are
+     permitted -- although they are not mandatory in new code of your
+     own.
+
+     When editing existing code which already uses one or the other set
+     of types, you should conform to the existing choices in that code.
+
+ (e) Types safe for use in userspace.
+
+     In certain structures which are visible to userspace, we cannot
+     require C99 types and cannot use the 'u32' form above. Thus, we
+     use __u32 and similar types in all structures which are shared
+     with userspace.
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
@@ -183,7 +259,7 @@ and it gets confused.  You know you're b
 to understand what you did 2 weeks from now.
 
 
-		Chapter 6: Centralized exiting of functions
+		Chapter 7: Centralized exiting of functions
 
 Albeit deprecated by some people, the equivalent of the goto statement is
 used frequently by compilers in form of the unconditional jump instruction.
@@ -220,7 +296,7 @@ out:
 	return result;
 }
 
-		Chapter 7: Commenting
+		Chapter 8: Commenting
 
 Comments are good, but there is also a danger of over-commenting.  NEVER
 try to explain HOW your code works in a comment: it's much better to
@@ -240,7 +316,7 @@ When commenting the kernel API functions
 See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
 for details.
 
-		Chapter 8: You've made a mess of it
+		Chapter 9: You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that "GNU emacs" automatically formats the C sources for
@@ -288,7 +364,7 @@ re-formatting you may want to take a loo
 remember: "indent" is not a fix for bad programming.
 
 
-		Chapter 9: Configuration-files
+		Chapter 10: Configuration-files
 
 For configuration options (arch/xxx/Kconfig, and all the Kconfig files),
 somewhat different indentation is used.
@@ -313,7 +389,7 @@ support for file-systems, for instance) 
 experimental options should be denoted (EXPERIMENTAL).
 
 
-		Chapter 10: Data structures
+		Chapter 11: Data structures
 
 Data structures that have visibility outside the single-threaded
 environment they are created and destroyed in should always have
@@ -344,7 +420,7 @@ Remember: if another thread can find you
 have a reference count on it, you almost certainly have a bug.
 
 
-		Chapter 11: Macros, Enums and RTL
+		Chapter 12: Macros, Enums and RTL
 
 Names of macros defining constants and labels in enums are capitalized.
 
@@ -399,7 +475,7 @@ The cpp manual deals with macros exhaust
 covers RTL which is used frequently with assembly language in the kernel.
 
 
-		Chapter 12: Printing kernel messages
+		Chapter 13: Printing kernel messages
 
 Kernel developers like to be seen as literate. Do mind the spelling
 of kernel messages to make a good impression. Do not use crippled
@@ -410,7 +486,7 @@ Kernel messages do not have to be termin
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
-		Chapter 13: Allocating memory
+		Chapter 14: Allocating memory
 
 The kernel provides the following general purpose memory allocators:
 kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
@@ -429,7 +505,7 @@ from void pointer to any other pointer t
 language.
 
 
-		Chapter 14: The inline disease
+		Chapter 15: The inline disease
 
 There appears to be a common misperception that gcc has a magic "make me
 faster" speedup option called "inline". While the use of inlines can be
@@ -457,7 +533,7 @@ something it would have done anyway.
 
 
 
-		Chapter 15: References
+		Appendix I: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.
@@ -481,4 +557,4 @@ Kernel CodingStyle, by greg@kroah.com at
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
 
 --
-Last updated on 30 December 2005 by a community effort on LKML.
+Last updated on 30 April 2006.
