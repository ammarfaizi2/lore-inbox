Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276883AbRJQOPb>; Wed, 17 Oct 2001 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276906AbRJQOPX>; Wed, 17 Oct 2001 10:15:23 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:58894 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S276877AbRJQOPG>; Wed, 17 Oct 2001 10:15:06 -0400
Date: Wed, 17 Oct 2001 15:15:34 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: kaos@ocs.com.au, rgooch@atnf.csiro.au
Subject: Re: GPLONLY kernel symbols???
Message-ID: <20011017151534.B91069@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office> <30375.1003285059@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30375.1003285059@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 12:17:39PM +1000, Keith Owens wrote:

> If a symbol has been exported with EXPORT_SYMBOL_GPL then it appears as
> unresolved for modules that do not have a GPL compatible MODULE_LICENCE
> string.  So when a module without a GPL compatible MODULE_LICENCE gets
> an unresolved symbol, I print that message as a hint to the user.  I
> thought the response was obvious, but looks like I need to expand the
> hint text even further.

How is the name mangled in the _GPL case ? Can't this be detected explicitly ?

richard, since ac seems OK with it ...

thanks
john

--- faq.html	Thu Oct 11 18:42:44 2001
+++ faqnew.html	Wed Oct 17 15:22:17 2001
@@ -513,6 +513,10 @@
 and Alan Cox's -ac series of patches?</A>
 </LI>
 
+<LI>
+<A HREF="#s1-22">What does it mean for a module to be tainted ?</A>
+</LI>
+
 </OL>
 
 <H4>
@@ -1794,6 +1798,37 @@
 
 </UL>
 
+<LI>
+<A NAME="s1-22"></A><B>What does it mean for a module to be tainted?</B>
+</LI>
+
+<UL>
+<LI>
+Some vendors distribute binary modules (i.e. modules without available
+source code under a free software license).
+As the source is not freely available, any bugs uncovered whilst such
+modules are loaded cannot be investigated by the kernel hackers. All
+problems discovered whilst such a module is loaded must be reported
+to the vendor of that module, <I>not</I> the Linux kernel hackers and
+the linux-kernel mailing list. The tainting scheme is used to identify
+bug reports from kernels with binary modules loaded: such kernels are
+marked as "tainted" by means of the <TT>MODULE_LICENSE</TT> tag. If a
+module is loaded that does not specify an approved license, the kernel
+is marked as tainted. The canonical list of approved license strings
+is in <TT>linux/include/module.h</TT>.<BR>
+"oops" reports marked as tainted are of no use to the kernel developers
+and will be ignored. A warning is output when such a module is loaded.
+Note that you may come across module source that is under a compatible
+license, but does not have a suitable <TT>MODULE_LICENSE</TT> tag. If you
+see a warning from <TT>modprobe</TT> or <TT>insmod</TT> for a module
+under a compatible license, please report this bug to the maintainers of
+the module, so that they can add the necessary tag.
+<P><FONT COLOR="#0000FF">(KO)</FONT> If a symbol has been exported with 
+EXPORT_SYMBOL_GPL then it appears as unresolved for modules that do not 
+have a GPL compatible MODULE_LICENSE string, and prints a warning.
+</LI>
+</UL>
+ 
 </OL>
 
 <H2>

-- 
"There are two kinds of fool. One says, 'This is old, and therefore good.' And
one says, 'This is new, and therefore better'."
	- John Brunner
