Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293027AbSCAP0x>; Fri, 1 Mar 2002 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293086AbSCAP0o>; Fri, 1 Mar 2002 10:26:44 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:21648 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S293027AbSCAP0b>; Fri, 1 Mar 2002 10:26:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Fri, 1 Mar 2002 16:26:27 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203011626.27719.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> mason@suse.com said:
> > So, a little testing with scsi_info shows my scsi drives do have
> > writeback cache on.  great.  What's interesting is they must be doing
> > additional work for ordered tags.  If they were treating the block as
> > written once in cache, using the tags should not change  performance
> > at all.  But, I can clearly show the tags changing performance, and
> > hear the drive write pattern change when tags are on. 

> I checked all mine and they're write through.  However, I inherited all my 
> drives from an enterprise vendor so this might not be that surprising.

How do you checked it?
Which scsi_info version?
Mine gave only the below info:

SunWave1 /home/nuetzel# scsi_info /dev/sda
SCSI_ID="0,0,0"
MODEL="IBM DDYS-T18350N"
FW_REV="S96H"
SunWave1 /home/nuetzel# scsi_info /dev/sdb
SCSI_ID="0,1,0"
MODEL="IBM DDRS-34560D"
FW_REV="DC1B"
SunWave1 /home/nuetzel# scsi_info /dev/sdc
SCSI_ID="0,2,0"
MODEL="IBM DDRS-34560W"
FW_REV="S71D"

But when I use "scsi-config" I get under "Cache Control Page":
Read cache enabled: Yes
Write cache enabled: No

I've tested it with setting this by hand some months ago, but the speed 
doesn't change in anyway (ReiserFS).

> I can surmise why ordered tags kill performance on your drive, since an 
> ordered tag is required to affect the ordering of the write to the medium,
> not the cache, it is probably implemented with an implicit cache flush.
>
> Anyway, the attached patch against 2.4.18 (and I know it's rather gross
> code)  will probe the cache type and try to set it to write through on boot.
>  See what this does to your performance ordinarily, and also to your
> tagged write barrier performance.

Will test it over the weekend on 2.4.19-pre1aa1 with all Reiserfs 
2.4.18.pending patches applied.

Regards,
	Dieter
