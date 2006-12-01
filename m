Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759079AbWLAFOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759079AbWLAFOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759077AbWLAFOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:14:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49104 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1759079AbWLAFOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:14:31 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Willy Tarreau <w@1wt.eu>, Jakub Jelinek <jakub@redhat.com>,
       Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, ak@suse.de
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away 
In-reply-to: Your message of "Thu, 30 Nov 2006 21:05:51 -0800."
             <20061130210551.e5ca0f29.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Dec 2006 16:14:04 +1100
Message-ID: <22166.1164950044@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Thu, 30 Nov 2006 21:05:51 -0800) wrote:
>On Wed, 29 Nov 2006 21:14:10 +0100
>Willy Tarreau <w@1wt.eu> wrote:
>
>> Then why not simply check for gcc 4.1.0 in compiler.h and refuse to build
>> with 4.1.0 if it's known to produce bad code ?
>
>Think so.  I'll queue this and see how many howls it causes.
>
>--- a/init/main.c~gcc-4-1-0-is-bust
>+++ a/init/main.c
>@@ -75,6 +75,10 @@
> #error Sorry, your GCC is too old. It builds incorrect kernels.
> #endif
> 
>+#if __GNUC__ == 4 && __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ == 0
>+#error gcc-4.1.0 is known to miscompile the kernel.  Please use a different compiler version.
>+#endif
>+
> static int init(void *);
> 
> extern void init_IRQ(void);

SuSE's SLES10 ships with gcc 4.1.0.  There is nothing to stop a
distributor from backporting the bug fix from gcc 4.1.1 to 4.1.0, but
this patch would not allow the fixed compiler to build the kernel.

