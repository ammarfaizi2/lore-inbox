Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbTCNJEV>; Fri, 14 Mar 2003 04:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263297AbTCNJEU>; Fri, 14 Mar 2003 04:04:20 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62726
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263296AbTCNJEJ>; Fri, 14 Mar 2003 04:04:09 -0500
Date: Fri, 14 Mar 2003 01:13:53 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "rain.wang" <rain.wang@mic.com.tw>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
In-Reply-To: <3E7192A2.CADEAE6D@mic.com.tw>
Message-ID: <Pine.LNX.4.10.10303140105210.9395-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rain,

The only way to deal with this is to treat the operations a failed and
punch them back out to block for clean up.  Now we failed the a command.
However, I think I need to set a default block hook during the reset
process for the drive, channel, hba ... depending on the magnitude of the
wrecking ball generated.  I need to offline Alan for this core dump.

The hang is in the clean ups after the reset.

I suspect the driver/hba is in DMA and drive is not.

Cheers,

Andre Hedrick
LAD Storage Consulting Group
------------------------------------
Pokemon (n), A Jamaican proctologist
------------------------------------

On Fri, 14 Mar 2003, rain.wang wrote:

> Alan Cox wrote:
> 
> > On Fri, 2003-03-07 at 06:04, rain.wang wrote:
> > > > Once I understand what the problems all are yes. The BUG() is good, it
> > > > confirms that what we are both seeing is the same thing - the reset is
> > > > managing to issue two commands to the controller at the same time.
> > >
> > > Hi,
> > >     thank you, Alan. I tested pre5-ac2 patch and that seems all ok.
> >
> > Thanks for the confirmation it is fixed
> 
> Hi Alan,
>     for 2.4.21-pre5-ac2 and -ac3 patch also.
>     there's still problem on reset. when I do 'hdparm -w /dev/hda' once
> after another, all seems ok.  but when I make a shell script and let
> 'hdparm -w' run in several times loop, system would always crashed
> at the second time and left oops messages:
>     kernel BUG at ide.c:1700!
>     ...
> so, if any bugs still locking there?
> 
> rain.w
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


