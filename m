Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSABW0P>; Wed, 2 Jan 2002 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287102AbSABW0A>; Wed, 2 Jan 2002 17:26:00 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:35599 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S287045AbSABWYE>;
	Wed, 2 Jan 2002 17:24:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201022223.g02MNrF371382@saturn.cs.uml.edu>
Subject: Re: system.map
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 2 Jan 2002 17:23:53 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), timothy.covell@ashavan.org,
        adriankok2000@yahoo.com.hk (adrian kok), linux-kernel@vger.kernel.org
In-Reply-To: <10236.1010007095@ocs3.intra.ocs.com.au> from "Keith Owens" at Jan 03, 2002 08:31:35 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

>> That's not a nice place. Besides the fact that System.map is
>> neither library nor module, /lib/modules is less likely to
>> exist than /boot is. It's a wee bit slower too.
>
> /boot is a hangover from old i386 systems that could not boot past
> cylinder 1024 so you needed a special partition to hold the boot
> images.  That restriction does not exist on any system less than 5
> years old nor on most non-i386 machines, the requirement for a special
> /boot is obsolete on most machines.

Who said anything about being special? I have a Mac with kernels
in /boot. It boots via OpenFirmware loading yaboot from an HFS
partition, then yaboot reading the ext2 root partition.

I suppose a separate boot partition would be good if I were to
use a Reiserfs root partition. I might as well mount this boot
partition on /boot and put all my kernels there, instead of
mounting it on /lib/modules.

> System.map is not required for booting, it is only used after init
> starts, therefore it does not belong in /boot anyway.

It's not about modules either. :-) If you can ignore the
name, I can too. So "/boot" means "kernel stuff".

> IA64 requires boot files to be in /boot/efi which must be a VFAT style
> partition.  Trust me, you don't want anything in /boot/efi unless you
> have to.

VFAT isn't the fastest, and isn't multi-user, but who cares?
It works perfectly fine for System.map files.

Eh, what goes in /boot that couldn't be on the VFAT partition?
I'm thinking the VFAT partition ought to be mounted at /boot.

> If it makes you feel happier, think of /lib/modules as 'kernel specific
> data'.  Pity about the name but it is hard coded into too many programs
> to change it to /lib/kernel or /kernel.

I could agree to use /kernel/2.4.18-pre1/* for all the misc. stuff
and /kernel/2.4.18-pre1/modules/* for the modules. So you add this
to the search path for your stuff, and make the 2.5 install prefer
this location if it exists. Who else would care? Then after all the
distributions have 2.6.xx kernels, drop /lib/modules from the tools.
Killing /boot could wait a bit longer perhaps, or maybe not.

>>It's a wee bit slower too.
>
> ????

2 dirs:  / /boot
4 dirs:  / /lib /lib/modules /lib/modules/2.4.18-pre1

So an inode and at least one block for each. You lose even
if you figure that / and /lib would be cached already.

Plus /boot comes earlier in the "ps" search path, so you pay
the cost of looking in /boot anyway.
