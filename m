Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274385AbRITJXc>; Thu, 20 Sep 2001 05:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274387AbRITJXX>; Thu, 20 Sep 2001 05:23:23 -0400
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:42485 "HELO
	mail.idoox.com") by vger.kernel.org with SMTP id <S274385AbRITJXS>;
	Thu, 20 Sep 2001 05:23:18 -0400
Date: Thu, 20 Sep 2001 11:23:42 +0200
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: =?iso-8859-2?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010920112342.A3253@pida.ulita.cz>
Reply-To: david@atrey.karlin.mff.cuni.cz
In-Reply-To: <20010920102616.A2753@pida.ulita.cz> <20010920111048.B17066@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010920111048.B17066@unthought.net>; from jakob@unthought.net on Thu, Sep 20, 2001 at 11:10:48AM +0200
X-Operating-System: Linux 2.2.19
Organization: IDOOX.COM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inlined.

On Thu, Sep 20, 2001, Jakob Østergaard wrote:
> On Thu, Sep 20, 2001 at 10:26:16AM +0200, David Hajek wrote:
> > Hi,
> > 
> > I have linux box with 70GB SW Raid1. This box runs for half
> > a year without problems but now I meet the high cpu load 
> > problems. I suspect that it can be caused by not enough 
> > free disk space on this md device. I see following:
> > 
> > 1 GB free  - load > 5
> > 5 GB free  - load < 1
> 
> RAID does not know about "free space" (that is a filesystem thing), so that
> would be either some strange interaction between the filesystem and lower
> layers, or a measurement error - I guess.
> 
> High fragmentation could lead to extra filesystem activity, but that's not
> really something the RAID can influence.

Why not? I do not say that it is cause be the RAID. It can be caused
by filesystem. Do you think that fsck helps to defrag filesystem?

> 
> Please check that your disks are using DMA (hdparm /dev/hdX). You should
> see something like:
> 
> [root@eagle /root]# hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)                <=========== INDICATES DMA
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 782/128/63, sectors = 6306048, start = 0
> 
> Without DMA you will see high CPU load from accessing the disks, regardless of
> free space.

I use SCSI disks for this raid. Here is the output:

[root@marvin /root]# hdparm /dev/sda

/dev/sda:
 readonly     =  0 (off)
 geometry     = 8924/255/63, sectors = 143374738, start = 0
[root@marvin /root]# hdparm -t /dev/sda

  /dev/sda:
   Timing buffered disk reads:  64 MB in  1.87 seconds = 34.22 MB/sec
[root@marvin /root]#   

I think disk speeds are ok - it works for really fine for half a year.

-- 
David Hajek
hajek@idoox.com                	     GSM: +420 604 352968
- You can't cheat the phone company.

