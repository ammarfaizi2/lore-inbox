Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTDYBLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDYBLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:11:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16650 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262219AbTDYBLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:11:10 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fix SWSUSP & !SWAP
Date: 24 Apr 2003 18:22:54 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8a2le$p88$1@cesium.transmeta.com>
References: <1051182797.2250.10.camel@laptop-linux> <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be>
By author:    Geert Uytterhoeven <geert@linux-m68k.org>
In newsgroup: linux.dev.kernel
>
> On Thu, 24 Apr 2003, Nigel Cunningham wrote:
> > On Thu, 2003-04-24 at 21:46, Andrew Morton wrote:
> > > > > Sorry, I still don't get it.  Go through the steps for me:
> > > > > 
> > > > > 1) suspend writes pages to disk
> > > > > 
> > > > > 2) machine is shutdown
> > > > > 
> > > > > 3) restart, journal replay
> > 
> > Corruption comes here. The journal reply tidies things up that shouldn't
> > be tidied up. They shouldn't be tidied up because once we reload the
> > image, things should be in the same state as prior to suspend. If replay
> > frees a block (thinking it wasn't properly linked or something similar),
> > it introduces corruption.
> 
> This has nothing to do with using a swapfile.
> 
> But if you resume from swsusp, you don't really `mount' all file systems. They
> are implicitly mounted because they were mounted before the suspend operation.
> 

Shouldn't we be syncing them all before the suspend anyway, to
minimize corruption in case the user chooses to mount the filesystem
*without* resuming (think a dual-boot configuration.)  This would be
another application for the "supersync" operation that was discussed
at OLS 2002 -- a need for an operation which not only flushes all
blocks to disk but also forces the journal to be replayed and
truncated.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
