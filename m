Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272859AbRIMFmd>; Thu, 13 Sep 2001 01:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272861AbRIMFmX>; Thu, 13 Sep 2001 01:42:23 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:25098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S272859AbRIMFmT>;
	Thu, 13 Sep 2001 01:42:19 -0400
Message-ID: <3BA04514.D65EDF98@gmx.de>
Date: Thu, 13 Sep 2001 07:33:08 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> I found out I can boot it after little games with mars netware
> emulator. However I have problems booting anything else than
> freedos. Trying to boot zImage directly results in crc errors or in
> errors in compressed data. Too much failures and too repeatable
> (althrough ram seems flakey) for me to believe its hw.

I bet that's the same problem I had booting a zImage directly from an
El-Torito CD.  The problem was the autoprobing for the floppy type
performed by the boot loader.  It detected a 2.88 drive and issued
corresponding read requests (track x, 36 blocks; track x+1, 36 blocks;
...).  The bios performs these request, but it emulates a 1.44 disk so
the last 18 blocks of track x are actually the blocks from track x+1.
In my case I did not even got a crc error but an immediate reboot.

I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
et voila, it worked perfectly.

Ciao, ET.

PS: Maybe that's the same problem lilo has on some systems with the
linear option...
