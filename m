Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbTBELad>; Wed, 5 Feb 2003 06:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbTBELad>; Wed, 5 Feb 2003 06:30:33 -0500
Received: from mail.ithnet.com ([217.64.64.8]:42002 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267922AbTBELac>;
	Wed, 5 Feb 2003 06:30:32 -0500
Date: Wed, 5 Feb 2003 12:39:51 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030205123951.54207275.skraw@ithnet.com>
In-Reply-To: <1044443761.685.44.camel@zion.wanadoo.fr>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
	<20030205104845.17a0553c.skraw@ithnet.com>
	<1044443761.685.44.camel@zion.wanadoo.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Feb 2003 12:16:02 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Okay, I had to watch for it a bit longer and it turns out that the kernel
> > PDC driver has a problem in this shared interrupt setup. When loads get
> > high it seems to run into some timing problem which causes things like:
> > 
> > Feb  4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
> > Feb  4 01:02:22 admin kernel: 
> > Feb  4 01:02:22 admin kernel: PDC202XX: Primary channel reset.
> > Feb  4 01:02:22 admin kernel: ide2: reset: success
> > Feb  4 01:02:23 admin kernel: hde: status error: status=0x58 { DriveReady
> > SeekComplete DataRequest } Feb  4 01:02:23 admin kernel: 
> > Feb  4 01:02:23 admin kernel: hde: drive not ready for command
> > Feb  4 01:02:23 admin kernel: hde: status error: status=0x50 { DriveReady
> > SeekComplete } Feb  4 01:02:23 admin kernel: 
> > Feb  4 01:02:23 admin kernel: hde: no DRQ after issuing WRITE
> > Feb  4 01:02:23 admin kernel: hde: status timeout: status=0xd0 { Busy }
> > Feb  4 01:02:23 admin kernel: 
> 
> Hi Alan !
> 
> I'm trying to get some sense out of the above report as it seem to match
> a problem a user reported me as well. It's interesting because it's
> apparently running UP, so it's not the SMP race found by Ross. It's
> definitely a problem with shared interrupt though.

Hello Benjamin,

I have to give a short note on this one:
indeed is the system currently running with a single CPU, _but_ since it is a
dual-mb the kernel is already compiled for SMP. It is started with "nosmp"
option though. I wanted to mention this not knowing if it is important for the
codepath.

-- 
Regards,
Stephan
