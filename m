Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSBMQZp>; Wed, 13 Feb 2002 11:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBMQZf>; Wed, 13 Feb 2002 11:25:35 -0500
Received: from [63.231.122.81] ([63.231.122.81]:64861 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S287565AbSBMQZ2>;
	Wed, 13 Feb 2002 11:25:28 -0500
Date: Wed, 13 Feb 2002 09:24:35 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213092435.C25535@lynx.turbolabs.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
	Jens Axboe <axboe@suse.de>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com> <20020212112803.P9826@lynx.turbolabs.com> <3C6A5D99.1040102@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6A5D99.1040102@evision-ventures.com>; from dalecki@evision-ventures.com on Wed, Feb 13, 2002 at 01:35:37PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  13:35 +0100, Martin Dalecki wrote:
> Andreas Dilger wrote:
> 
> >On Feb 12, 2002  16:23 +0100, Martin Dalecki wrote:
> >>>The first lv_read_ahead (in lv_t) removed. And references to it as well.
> >
> >... this struct is passed between the kernel
> >and user space you can't just delete it, or everyone using LVM has a
> >broken system and may not even be able to boot if they have root on
> >LVM.  Feel free to delete the code which actually uses this field, but
> >don't remove it from the struct unless you are willing to fix the user
> >space code also.
>
> Please note that there are two structs there: One of them is tagged /* 
> core */ and another of them is tagged as beeing /* disk */. The driver
> does only touch the core version, which is supposedly only to be used
> by the driver itself. This is what I was complaining about in first
> place: Why is the driver's internal struct exposed there at all

Well, then you have no idea about how the current LVM code works.  The
way it does everything is to read the data from disk, convert endianness
and such, and then pass it to the kernel via IOCTL.  I have no comment
on whether this is a good or bad way to do it.  The point is that the
struct marked "core" which you are deleting this unused field from is
filled in from user-space, so you can't just change it when you want.

Rather than spending a lot of time breaking the kernel/user interface
and forcing everyone using LVM to update their user tools, just leave
this field in the struct.  Feel free to remove the actual code that
does the read-ahead if you want, but leave the lv_read_ahead field
in this struct alone.  The entire LVM code is going to be replaced
by either LVM2 (just entered beta) or EVMS (in beta for a while now).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

