Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129504AbRBKOeH>; Sun, 11 Feb 2001 09:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbRBKOd5>; Sun, 11 Feb 2001 09:33:57 -0500
Received: from 215.adsl0.noe.worldonline.dk ([213.237.9.215]:4142 "HELO
	home.tange.dk") by vger.kernel.org with SMTP id <S129504AbRBKOdn>;
	Sun, 11 Feb 2001 09:33:43 -0500
Date: Sun, 11 Feb 2001 15:33:22 +0100 (CET)
From: Ole Tange <tange@tange.dk>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: RAMDISK larger than 778000 KB halts system
In-Reply-To: <20010210222450.A7877@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0102111510280.1677-100000@tigger.tange.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Pavel Machek wrote:

> > [1.] One line summary of the problem:
> >      Running badblocks on a ramdisk larger than 778000 KB halts
> > system
> 
> Is it really bug?

That is simply a matter of definition. If the system does as you expect,
then you will probably not regard it as a bug.

I, however, am not in the habit of having Linux halt on me with no
explanation. So the system did something that I did not expect. So in my
opinion this _is_ a bug.

> You have 778000 KB of low ram, right? (That's the way himem patches
> work, IIRC).

dmesg says:

Linux version 2.4.1 (root@tigger.tange.dk) (gcc version 2.96 20000731 (Linux-Mandrake 7.3)) #11 Fri Feb 9 21:29:16 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000003fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000003fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000003fff0000 (ACPI NVS)
127MB HIGHMEM available.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
...
Memory: 1028484k/1048512k available (1253k kernel code, 19640k reserved, 470k data, 212k init, 131008k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)

I will expect that low ram can be calculated as: 1028484-131008=897476

> You have used all of it. You've run out of memory.
>
> It might be pretty non-trivial to fix this.

I am surprised if RAMdisks cannot utilize the himem. Where can I read
about what other restrictions exist on himem?

But if this is correct, then it would be a friendly gesture to tell the
user that he has hit a limit. E.g. by prohibiting usage of so much so the
system halts or at least logging why the system halted.


/Ole


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
