Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTKEKYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTKEKXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:23:55 -0500
Received: from ns.suse.de ([195.135.220.2]:17564 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262790AbTKEKXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:23:41 -0500
Date: Wed, 5 Nov 2003 11:22:38 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105102238.GJ1477@suse.de>
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA8CEF1.1050200@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> Jens Axboe wrote:
> >On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> >>>
> >>>
> >>>>Jens Axboe wrote:
> >>>>
> >>>>
> >>>>>On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>Jens Axboe wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>On Mon, Nov 03 2003, Prakash K. Cheemplavam wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>Hi,
> >>>>>>>>
> >>>>>>>>well I am using k3b0.10.1 and either choosing cdrdao or cdrecord in 
> >>>>>>
> >>>>>>DAO mode to burn the cd ends up in non-bit identical copies, wheres 
> >>>>>>ion TAO (atleast with my 10x CD-RW I tested) the copy succeded. I 
> >>>>>>tried several times, and always got this issue.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>>bash-2.05b$ md5sum livecd-2.6_10-23-2003.iso
> >>>>>>>>f73f3a74239dfe94b322b85fd14a306e livecd-2.6_10-23-2003.iso
> >>>>>>>>
> >>>>>>>>TAO:
> >>>>>>>>bash-2.05b$ md5sum /dev/cdroms/cdrom1
> >>>>>>>>f73f3a74239dfe94b322b85fd14a306e /dev/cdroms/cdrom1
> >>>>>>>>
> >>>>>>>>DAO:
> >>>>>>>>bash-2.05b$ md5sum /dev/cdroms/cdrom1
> >>>>>>>>09e7e2a51af4c64685831513fbac18c2 /dev/cdroms/cdrom1
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>Could you please try and cmp the two images, finding out how big the
> >>>>>>>corrupted chunks are and what kind of data they contain?
> >>>>>>
> >>>>>>
> >>>>>>After some further investigation I found out, that the data is NOT 
> >>>>>>corrupted, but in a way truncated in DAO mode: When I read out the 
> >>>>>>image 
> >>>>>
> >>>>>>from the CD-RW drive, about 5kbyte are missing at the end (and doing 
> >>>>>
> >>>>>
> >>>>>>several burn, it is always the same amount). Strange enough if I read 
> >>>>>>the DAO burnt disk out by my DVD-ROM, the image can be read out 
> >>>>>>completely! Can you understand this behaviour? I don't think it is a 
> >>>>>>problem of my burner, but rather of the atapi driver?
> >>>>>
> >>>>>
> >>>>>Is actual data missing at the end? If yes, I'd say this looks a lot 
> >>>>>more
> >>>>>like a cdrecord problem.
> >>>>
> >>>>Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM 
> >>>>restores the full image (md5sum matches), but the CD-RW does not.
> >>>
> >>>
> >>>You need to use the pad option to record.
> >>
> >>Uhm, could you be more specific? I just use the k3b frontend to burn, 
> >>and in the cdrdao manual I couldn't find something useful to it.
> >
> >
> >it's a cdrecord option, I've never used k3b so cannot comment on how to
> >make it enable that.
> 
> Hmm, I'll take a look, but I don't really think it is a problem of the 
> recording programme, otherwise how could my reader read it out completely?

It isn't a problem of the recorder program. But some drives wont read
the very end of a disc unless there are some pad blocks at the end.
Thus, you should always use the cdrecord pad option.

> 
> >>SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
> >>stutters slighty when burning (in atapi mode). I am now using as 
> >>sheduler. Shoudl I try deadline or do you this it is something else? 
> >>Should I open a new topic?
> >
> >
> >k3b is probably still going through ide-scsi which you must not. It
> >would be interesting if you could try without ide-scsi and use cdrecord
> >manually (maybe someone more knowledgable on k3b can common on whether
> >they support 2.6 or not). 2.6 will be a lot faster than 2.4.
> 
> No, it uses atapi as a) it claims to be compatible with it and b) I have 

SG_IO or CDROM_SEND_PACKET? The latter should never have been merged in
cdrecord, and you should never use it. If it is using SG_IO, I'm very
interested in knowing more. vmstat 1 while doing the burn would be
interesting, just for 10 seconds where you see the problem.

> neither activated scsi nor scsi-emulation in the kernel, so it most 

Great

> probably is a new issue. Furthermore my hd reading (I once contacted you 
> because of that) didn't improve with the new kernel, though some 
> bugfixes in this directions are mentioned by Andrew Morton.

Don't remember, sorry :)

-- 
Jens Axboe

