Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759092AbWLAF2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092AbWLAF2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759093AbWLAF2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:28:16 -0500
Received: from 1wt.eu ([62.212.114.60]:11013 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1759091AbWLAF2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:28:15 -0500
Date: Fri, 1 Dec 2006 06:26:53 +0100
From: Willy Tarreau <w@1wt.eu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, ak@suse.de
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Message-ID: <20061201052653.GB11835@1wt.eu>
References: <20061130210551.e5ca0f29.akpm@osdl.org> <22166.1164950044@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22166.1164950044@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 04:14:04PM +1100, Keith Owens wrote:
> Andrew Morton (on Thu, 30 Nov 2006 21:05:51 -0800) wrote:
> >On Wed, 29 Nov 2006 21:14:10 +0100
> >Willy Tarreau <w@1wt.eu> wrote:
> >
> >> Then why not simply check for gcc 4.1.0 in compiler.h and refuse to build
> >> with 4.1.0 if it's known to produce bad code ?
> >
> >Think so.  I'll queue this and see how many howls it causes.
> >
> >--- a/init/main.c~gcc-4-1-0-is-bust
> >+++ a/init/main.c
> >@@ -75,6 +75,10 @@
> > #error Sorry, your GCC is too old. It builds incorrect kernels.
> > #endif
> > 
> >+#if __GNUC__ == 4 && __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ == 0
> >+#error gcc-4.1.0 is known to miscompile the kernel.  Please use a different compiler version.
> >+#endif
> >+
> > static int init(void *);
> > 
> > extern void init_IRQ(void);
> 
> SuSE's SLES10 ships with gcc 4.1.0.  There is nothing to stop a
> distributor from backporting the bug fix from gcc 4.1.1 to 4.1.0, but
> this patch would not allow the fixed compiler to build the kernel.

Then maybe replace #error with #warning ? It's too dangerous to let people
build their kernel with a known broken compiler without being informed.

I think this shows the limit of backports to known broken versions.
Providing a full update to 4.1.1 would certainly be cleaner for all
customers than backporting 4.1.1 to 4.1.0 and calling it 4.1.0.

Another solution would be to be able to check gcc for known bugs in the
makefile, just like we check it for specific options. But I don't know
how we can check gcc for bad code, especially in cross-compile environments
:-/

Willy

