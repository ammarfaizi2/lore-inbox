Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274381AbRITJKm>; Thu, 20 Sep 2001 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274379AbRITJKd>; Thu, 20 Sep 2001 05:10:33 -0400
Received: from unthought.net ([212.97.129.24]:54404 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274377AbRITJKY>;
	Thu, 20 Sep 2001 05:10:24 -0400
Date: Thu, 20 Sep 2001 11:10:48 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: David Hajek <david@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010920111048.B17066@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	David Hajek <david@atrey.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010920102616.A2753@pida.ulita.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010920102616.A2753@pida.ulita.cz>; from david@atrey.karlin.mff.cuni.cz on Thu, Sep 20, 2001 at 10:26:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 10:26:16AM +0200, David Hajek wrote:
> Hi,
> 
> I have linux box with 70GB SW Raid1. This box runs for half
> a year without problems but now I meet the high cpu load 
> problems. I suspect that it can be caused by not enough 
> free disk space on this md device. I see following:
> 
> 1 GB free  - load > 5
> 5 GB free  - load < 1

RAID does not know about "free space" (that is a filesystem thing), so that
would be either some strange interaction between the filesystem and lower
layers, or a measurement error - I guess.

High fragmentation could lead to extra filesystem activity, but that's not
really something the RAID can influence.

> 
> I have to notice that this box is rather under heavy load
> (1 GB cvs tree, nfs homes etc.) My question is whether this 
> load can depend on available disk space because I do not
> see any suspect processes that can cause such a high load.
> 
> Kernel: 2.2.19
> Patches: lfs + md + ide
> RH6.2 + glibc-2.2.12

Please check that your disks are using DMA (hdparm /dev/hdX). You should
see something like:

[root@eagle /root]# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)                <=========== INDICATES DMA
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 782/128/63, sectors = 6306048, start = 0

Without DMA you will see high CPU load from accessing the disks, regardless of
free space.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
