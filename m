Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSG2Sbn>; Mon, 29 Jul 2002 14:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSG2Sbm>; Mon, 29 Jul 2002 14:31:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15114 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317462AbSG2Sbm>;
	Mon, 29 Jul 2002 14:31:42 -0400
Message-ID: <3D458A58.FB15D5D0@zip.com.au>
Date: Mon, 29 Jul 2002 11:32:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729102721.B23843@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> > - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.
> 
> Hmmmmmmm.  page_address() is already 5 loads (on ARM) if page->virtual
> isn't used.  I'm seriously considering changing page_address() to cover
> the 3 cases more efficiently:

Well, one would want to keep the WANT_PAGE_VIRTUAL thing anyway.

btw, the usage of page_address() will quite possibly drop sharply soon
anyway.  There's the patch floating about which permits atomic
kmaps to be held across copy_*_user.  If that is adopted, things
like the pagecache IO routines won't do page_address() any more.

Said patch speeds up pagecache IO by between 0% and probably 30%.
It's the mystery surrounding this variation which is holding things
up.

-
