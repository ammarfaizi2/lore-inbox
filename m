Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRL3RAR>; Sun, 30 Dec 2001 12:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRL3Q75>; Sun, 30 Dec 2001 11:59:57 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:17147 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S279307AbRL3Q7z>;
	Sun, 30 Dec 2001 11:59:55 -0500
Message-ID: <3C2F47F2.BB7BFBDA@gmx.net>
Date: Sun, 30 Dec 2001 17:59:30 +0100
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: Oops: UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
In-Reply-To: <3C2F2948.DB59646A@gmx.net> <3C2F3455.6050209@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:

> I met something like this with the root fs while testing some
> 2.4.X-preX. An fsck -f from my rescue floppy was telling me 'clean' but
> the boot process hung with e2fsck exiting with an error digit.
>
> I forced mounting rw the root fs after disabling fsck, re-compile
> e2fsprogs, re-boot and it was OK.
>
> This is only a rescue approach. The disk corruption you met with
> 2.4.17/ext2 remains to address.
>

Here's something I can't remember EVER seeing before at bootup:
"---SNIP---
Partition check:
hda: {everything fine here}
hdb: [PTBL] [1108 255 63] hdb1 hdb2 <hdb5 hdb6 hdb7 hdb8> hdb3
---SNIP---"
The PTBL stuff and 1108 255 63 (CHS??) !!! Why?

I tried 'e2fsck -f /dev/hdb3' and it returned:
"Filesystem has unsupported Read-Only features while trying to open
/dev/hdb3.
The SuperBlock could not be read or does not describe a correct ext2
filesystem.
....If it /is/ ext2 then the Sb is corrupt, run 'e2fsck -b 8193 <device>'"

So I do 'e2fsck -b 8193 <device>' and it says: "Bad magic number in SB
while trying to open /dev/hdb3"

For /dev/hdb5 it says: "Couldn't /find/ ext2 SB...trying backup
blocks...Bad magic number in SB while trying to open /dev/hdb5."

Any more ideas?? I already heard from Lionel Bouton to hook up the device
on it's old system but that'll have to wait till after Jan. 2nd.
TIA,
-Mike


