Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291158AbSBLS3V>; Tue, 12 Feb 2002 13:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291152AbSBLS3C>; Tue, 12 Feb 2002 13:29:02 -0500
Received: from [63.231.122.81] ([63.231.122.81]:24127 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291158AbSBLS25>;
	Tue, 12 Feb 2002 13:28:57 -0500
Date: Tue, 12 Feb 2002 11:28:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212112803.P9826@lynx.turbolabs.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
	Jens Axboe <axboe@suse.de>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C693357.8000204@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 12, 2002 at 04:23:03PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2002  16:23 +0100, Martin Dalecki wrote:
> >The later (lv_disk_t) struct isn't used anywhere in the kernel -
> >probably defined for userspace only? That's weird! And also many other
> >structs in lvm.h are nowhere to be found used. Guess we could swipe them
> >out as well.
> >
> >The first lv_read_ahead (in lv_t) removed. And references to it as well.
>
> Yes I know the lvm coders where too deaf to separate user level 
> structure layout properly from on disk and kernel space by using just
> different header files for different purposes.  And then they tryed
> apparently to embarce anything they could think off, without really
> thinking hard about what should be there and what shouldn't. It was too 
> hard for them to have a sneak view on for example Solaris to recognize
> what's really needed.

> diff -ur linux-2.5.4/include/linux/lvm.h linux/include/linux/lvm.h
> --- linux-2.5.4/include/linux/lvm.h	Mon Feb 11 02:50:08 2002
> +++ linux/include/linux/lvm.h	Tue Feb 12 15:52:45 2002
> @@ -498,7 +498,6 @@
>  	uint lv_badblock;	/* for future use */
>  	uint lv_allocation;
>  	uint lv_io_timeout;	/* for future use */
> -	uint lv_read_ahead;
>  
>  	/* delta to version 1 starts here */
>         struct lv_v5 *lv_snapshot_org;

Yes, this is true, but since this struct is passed between the kernel
and user space you can't just delete it, or everyone using LVM has a
broken system and may not even be able to boot if they have root on
LVM.  Feel free to delete the code which actually uses this field, but
don't remove it from the struct unless you are willing to fix the user
space code also.

> But they promise perpetually once in a while that the next version will 
> be "coming real soon" and be wonderfull...  Perhaps someone should just
> stump over them and clean this mess up, with the disrespect those pseudo
> maintainers do deserve....

Well, I don't work on LVM anymore, but the general consensus is that the
current LVM code will die a slow death and be replaced by LVM2 and/or
EVMS.  So until that happens, don't screw up everyone using LVM.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

