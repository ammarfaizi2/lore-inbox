Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTBPGpv>; Sun, 16 Feb 2003 01:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTBPGpv>; Sun, 16 Feb 2003 01:45:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:33219 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265898AbTBPGpu>;
	Sun, 16 Feb 2003 01:45:50 -0500
Date: Sat, 15 Feb 2003 22:56:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, tim@physik3.uni-rostock.de
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-Id: <20030215225618.538f4c70.akpm@digeo.com>
In-Reply-To: <p73znowybo5.fsf@amdsimf.suse.de>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de.suse.lists.linux.kernel>
	<20030216020808.GF9833@krispykreme.suse.lists.linux.kernel>
	<p73znowybo5.fsf@amdsimf.suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 06:55:34.0138 (UTC) FILETIME=[671345A0:01C2D588]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Anton Blanchard <anton@samba.org> writes:
> 
> > Hi,
> > 
> > > +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))
> > 
> > In order to make 64bit arches wrap too, you might want to use -1UL here.
> > Not that jiffies should wrap on a 64bit machine...
> 
> Seems somewhat pointless.
> 
> (2^64-1) / (1000 * 3600 * 24 * 365)
>         ~584942417.35507203243911719939
> 
> I doubt any system ever will have an uptime of > 584 million years
> (assuming HZ=1000) and if jiffies wrap will be the least of their
> problems.
> 

But the point of this patch is to catch jiffy wrap bugs in generic code as
well as in platform-specific code.

Doing it for 64-bit platforms as well will give us just that bit more testing
coverage, and has no cost.  (Well, 8 more bytes of kernel image...)

