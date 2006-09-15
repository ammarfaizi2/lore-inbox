Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWIOTeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWIOTeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWIOTeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:34:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751497AbWIOTeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:34:18 -0400
Date: Fri, 15 Sep 2006 12:33:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Jarek Poplawski <jarkao2@o2.pl>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-Id: <20060915123340.fd01fec4.akpm@osdl.org>
In-Reply-To: <20060915152349.GA22233@redhat.com>
References: <20060913065010.GA2110@ff.dom.local>
	<20060914181754.bd963f6d.akpm@osdl.org>
	<20060915081123.GA2572@ff.dom.local>
	<20060915012302.d459c2dc.akpm@osdl.org>
	<20060915152349.GA22233@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 11:23:49 -0400
Dave Jones <davej@redhat.com> wrote:

> On Fri, Sep 15, 2006 at 01:23:02AM -0700, Andrew Morton wrote:
> 
>  > > > Thanks.   Andi has already queued a similar patch.
>  > > > 
>  > > > Andi, you might as well scoot that upstream, otherwise we'll get lots of
>  > > > emails about it.
>  > > ...
>  > > > > +#if 0xFF >= MAX_MP_BUSSES
>  > > > >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
>  > > I don't know how Andi has fixed it,
>  > Same thing.  (He has `#if MAX_MP_BUSSES < 256').
> 
> How can this be the right the right thing to do ?
> It should *never* be >=256. mach-summit/mach-generic need fixing
> to be 255, not this ridiculous band-aid.  Where did 260 come from anyway?
>  

commit f0bacaf5cec4e677a00b5ab06d95664d03a30f7a
Author: akpm <akpm>
Date:   Mon Apr 12 20:06:32 2004 +0000

    [PATCH] summmit: increase MAX_MP_BUSSES
    
    From: James Cleverdon <jamesclv@us.ibm.com>
    
    Bump up MAX_MP_BUSSES for summit/generic subarch to cope with big IBM x440
    systems.
    
    BKrev: 407af6c8l8rvwRmEU-JHTS98MurIZA

diff --git a/include/asm-i386/mach-generic/mach_mpspec.h b/include/asm-i386/mach-generic/mach_mpspec.h
index ef10cd2..fbb6a40 100644
--- a/include/asm-i386/mach-generic/mach_mpspec.h
+++ b/include/asm-i386/mach-generic/mach_mpspec.h
@@ -8,6 +8,8 @@ #define MAX_APICS 256
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Summit or generic (i.e. installer) kernels need lots of bus entries. */
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+#define MAX_MP_BUSSES 260
 
 #endif /* __ASM_MACH_MPSPEC_H */
diff --git a/include/asm-i386/mach-summit/mach_mpspec.h b/include/asm-i386/mach-summit/mach_mpspec.h
index ef10cd2..bc8f717 100644
--- a/include/asm-i386/mach-summit/mach_mpspec.h
+++ b/include/asm-i386/mach-summit/mach_mpspec.h
@@ -8,6 +8,7 @@ #define MAX_APICS 256
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+#define MAX_MP_BUSSES 260
 
 #endif /* __ASM_MACH_MPSPEC_H */

