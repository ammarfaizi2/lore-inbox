Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBOMU7>; Fri, 15 Feb 2002 07:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288149AbSBOMUu>; Fri, 15 Feb 2002 07:20:50 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:49669 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288086AbSBOMUn>; Fri, 15 Feb 2002 07:20:43 -0500
Date: Fri, 15 Feb 2002 13:20:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020215132030.A5096@suse.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6CC19C.3040608@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 15, 2002 at 09:06:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:06:52AM +0100, Martin Dalecki wrote:

> It seems bigger as it is at first glance, however if you start to read 
> it at ide.h, the rest should
> be, well,  obivous...
> 
> Anyway please let me explain some bits: the end_request() function familiy
> (not the global one, but the IDE specific ones), did bear a permuted 
> parameter ordering.
> After fixing this it turned out that at all places the huk parameter 
> wasn't the
> hwgroup, but just the drive in question itself. I have changed this to
> be more sane, which allowed to remove many unneccessary code duplication,
> or rather obfuscation, in between the __ide_end_request() and 
> ide_end_request() functions.
> This simplification is actually the "spreading" part of the game.

Yes, this is very nice.

> In a next step rather as much as possible should be moved from beeing 
> hooked on
> the disk to be hooked on the request itself - which seems more natural 
> and would make
> the overall code treamlined with other similar driver mid-layers (SCSI 
> comes to mind).
> 
> In a third step one should take care to remove the excessive usage of 
> single linked
> lists inside the ide driver, where possible and make it be handled the 
> same way like
> in SCSI and elsewere in the kernel... The overall perspecive is to make 
> as much as possible
> common between all block device handlers no matter whatever SCSI/IDE/I2O 
> or FW or iSCSI.
> 
> I have taken as much care as possible to not break anything. In esp. it 
> all has ben tested
> in life on my home system with L120 (aka ide-floppy), an CD-RW, and two 
> disks.
> The only blind fly is ide-tape... but the patch can be easly verifyed 
> for correctness by reading
> through it.
> 
> PS. I have killed deliberately some one-shoot functions as well, since 
> those where only
> obscuring the overall code structure even more....

And these steps also sound very good to me.

-- 
Vojtech Pavlik
SuSE Labs
