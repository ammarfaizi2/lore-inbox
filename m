Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272048AbRIMUJM>; Thu, 13 Sep 2001 16:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272038AbRIMUJC>; Thu, 13 Sep 2001 16:09:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46084 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272020AbRIMUIv>; Thu, 13 Sep 2001 16:08:51 -0400
Message-ID: <3BA1124B.5020302@zytor.com>
Date: Thu, 13 Sep 2001 13:08:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010905
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz> <3BA0D2BA.8B972B51@gmx.de> <20010913215617.E6820@atrey.karlin.mff.cuni.cz> <3BA10FFA.1050204@zytor.com> <20010913220326.H6820@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>
>>Am I guessing correctly that this RPL thing is a floppy image emulator?
>>Then it probably becomes a matter of where that image lives (in memory, if
>>so where; or on the network and downloaded sector by sector.)  You may
>>want to try to make a SYSLINUX image and see if it works.
>>
> 
> Yep, it is floppy image emulator. People are telling me it is
> downloaded sector by sector. Do you have some "sure to boot" floppy
> image somewhere on ftp?
> 								Pavel


There is no such thing, but this is how you'd build a minimal SYSLINUX
floppy image (remove the -s for better performance but somewhat reduced
resistance to severe BIOS bugs):

	su
	dd if=/dev/zero of=floppy.img bs=1024 count=1440
	mkdosfs floppy.img
	syslinux -s floppy.img
	mount -o loop -t msdos floppy.img /mnt
	cp bzImage /mnt/linux
	umount /mnt
	sync


