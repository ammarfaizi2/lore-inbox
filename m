Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVD1WU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVD1WU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVD1WU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:20:59 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:26273 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262290AbVD1WUs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:20:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XPTglAmYoiR6UrnxllZvn9Df6aNwFfgmCgwUp39Ahm597GiV3NLlvwPwapDJcNYulDcIo2goR7Dm/aC+f4eJyjBnVJBQHWic2erAkyCnf3VjsBCNCmSfCBE8/oxlA7QGCizZ9zFIReLJmAwZcqBSFCWiJfD1d1mhtBVw9JSGWr8=
Message-ID: <58cb370e050428152073cb81a@mail.gmail.com>
Date: Fri, 29 Apr 2005 00:20:48 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE problems with rmmod ide-cd
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1114725062.18809.226.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114706653.18330.212.camel@localhost.localdomain>
	 <20050428172541.GN1876@suse.de>
	 <58cb370e05042813466915eebb@mail.gmail.com>
	 <1114725062.18809.226.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-04-28 at 21:46, Bartlomiej Zolnierkiewicz wrote:
> > > The problem you are thinking of was also an ATAPI cache flush command,
> > > so I'm not so sure I would call it harmless... I haven't changed
> > > anything in there recently, Bart?
> >
> > I don't remember changing anything there recently.
> > Alan, please give more details of the issue.
> 
> Torvalds tree - head
> 
> Hardware is as follows
>         Promise IDE controller on ide0/1 - no drives
>         VIA IDE controller on ide2/3 - hdd is a DVD-ROM
>         and hdg is a disk.
> 
> hdd: TOSHIBA DVD-ROM SD-M1212
> 
> I had some code logging the commands issued and I did rmmod ide-cd. At
> that point it sent a cache flush to the drive which then errorred it.
> 
> The actual log entry is
> 
> hdd: packet command error
> Gives status=0x51, error=0x50
> 
> Dumping the error in detail its
> 
> Error;Illegal Request (Sense 0x05)
> Invalid command operation code (0x20, 0x00)
> The failed "Flush cache" packet command was
> "35 00 00 00 00 00 ... 00"
 
I would suggest auditing MRW support in cdrom.c. 
IDE layer itself never sends GPCMD_FLUSH_CACHE.
