Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRKEOMz>; Mon, 5 Nov 2001 09:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKEOMp>; Mon, 5 Nov 2001 09:12:45 -0500
Received: from [195.66.192.167] ([195.66.192.167]:32011 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281156AbRKEOMg>; Mon, 5 Nov 2001 09:12:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ryan Hayle <hackel@walkingfish.com>, linux-kernel@vger.kernel.org
Subject: Re: Poor IDE performance with VIA MVP3
Date: Mon, 5 Nov 2001 16:12:00 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011105005033.A10060@isis.visi.com>
In-Reply-To: <20011105005033.A10060@isis.visi.com>
MIME-Version: 1.0
Message-Id: <01110516120000.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 06:50, Ryan Hayle wrote:
> I have a VIA MVP3 (VT82C586B) controller on my motherboard, and am
> experiencing extremely poor performance with a Maxtor 20G
> (52049U4) drive.  It is an UDMA66-capable drive, but I'm only attempting
> to use UDMA33 (with an 80-pin cable, as recommended).
>
> The drive is detected and works just fine, with no errors reported,
> however the acces is painfully slow.  hdparm -t varries from 970 K/sec to
> 2.5 M/sec. (See below)

Are you saying that hdparm -T -t is yielding wildly varying results?
Looks similar to failing hd symptoms or bug in IDE layer causing retries
after error/timeout. What's in the logs?

> The drive is attached by itself to the first IDE channel.  On the second I
> have a Maxtor 6.8G (90680D4) and a CDROM.  hdparm -t on the second drive
> typically gives 8-9 M/sec.  I manually set this drive with hdparm -X34
> (mdma2), otherwise it generates errors.
>
> I have tried Linux 2.2.19, 2.4.12, and now 2.4.13, and all exhibit this
> same behavior.  I was originally running with a 40-pin cable, and switched
> it to the 80 to see if it might help, but it had no effect.  As some
> background information, I was originally running linux off of the second
> 6G drive, and opted to move it onto the 20G because it got better
> performance.  Once I did this, however, the drive started performing
> slowly like this, regardless of whether I'm booting to it or the 6G
> drive.
>
> Does this sound like it's just a hardware problem?  Has anyone experienced
> anything similar to this?  Any advice would be greatly apreciated.

Well, I had problems with drives refusing to do [u]dma.
On my home machine I found out that compiling kernel with support for VIA 
chipset allowed udma to work ok (hdparm -T -t = ~20mb/s). Without that 
support, my hd was stuck in pio, ~6mb/s.
--
vda
