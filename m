Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbSLRVEw>; Wed, 18 Dec 2002 16:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267358AbSLRVEw>; Wed, 18 Dec 2002 16:04:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45329
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267357AbSLRVEv>; Wed, 18 Dec 2002 16:04:51 -0500
Date: Wed, 18 Dec 2002 13:10:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: "D.A.M. Revok" <marvin@synapse.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
In-Reply-To: <3E00BBC0.6020807@google.com>
Message-ID: <Pine.LNX.4.10.10212181308340.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, Ross Biro wrote:

> 
> There is a bug in the Promise driver that clears an important PIO bit 
> when switching into DMA mode.  When you do an hdparm -I, it issues a 
> drive command that attempts to transfer data in PIO mode, but since the 
> PIO mode timing registers are hosed, the machine locks up.  It's easy to 
> reproduce and applies to all drive commands that return data including 
> SMART commands.
> 
> The bit in particular is bit 4 of PCI config register 0x61+4*channel 
> number (PB bit 4 in Promise terms.)  I've got a very unclean fix that I 
> will attempt to clean up once I can put a few more important issues to bed.
> 
> For the time being, you can try to do a work around by putting the drive 
> into PIO mode with hdparm -X 12  before issuing any drive commands.
> 
>     Ross
> 
> D.A.M. Revok wrote:
> 
> >( that's a capital-aye in the hdparm line )
> >
> >not even the Magic SysReq key will work.
> >
> >also, don't
> >
> >"cd /proc/ide/hde ; cat identify"
> >
> >... same thing
> >drive-light comes on, but have to use the power-switch to get the machine 
> >back, ( lost stuff again, fuck )
> >
> >
> >proc says it's pdc202xx
> >
> >Promise Ultra series driver Ver 1.20.0.7 2002-05-23
> >Adapter: Ultra100 on M/B

And this is the drive hack job that Promise did to it in 2.4.19.
This is not my driver version and you need to nail Marcelo for this issue.
Wait, move to 2.4.20 and it may go away.  Better yet go back to 2.4.18 and
it should be clean.

Regards,


Andre Hedrick
LAD Storage Consulting Group

