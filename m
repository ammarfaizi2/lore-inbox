Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRABP1e>; Tue, 2 Jan 2001 10:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRABP1Z>; Tue, 2 Jan 2001 10:27:25 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:13584 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131104AbRABP1M>; Tue, 2 Jan 2001 10:27:12 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A51EAC8.24523718@yahoo.com>
Date: Tue, 02 Jan 2001 09:50:48 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Memory detection wrong on old 386 (2.4.x)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I booted up 2.4.0-prerel on an old 386sx (just to see what would
break) and  memory detection comes up almost 1MB short.

It is an old sx16 Olivetti (M300-05) with 5MB & a MDA card, and
it remaps some of the 640kB->1MB region to top of RAM.

2.2.18 reports:

Memory: 3988k/5408k available (760k kernel code, 
                 416k reserved, 216k data, 28k init)

which would indicate to me that it remaps 5408-5120=288kB.

But 2.4.0-prerel gives:

BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000000350000 @ 0000000000100000 (usable)
On node 0 totalpages: 1104
zone(0): 1104 pages.
zone(1): 0 pages.
zone(2): 0 pages.
[...]
Memory: 2804k/4416k available (892k kernel code, 
        1224k reserved, 42k data, 36k init, 0k highmem)

Booting same kernel with mem=5408k and everything is fine:

BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000000350000 @ 0000000000100000 (usable)
On node 0 totalpages: 1352
zone(0): 1352 pages.
zone(1): 0 pages.
zone(2): 0 pages.
[...]
Memory: 3780k/5408k available (892k kernel code, 
        1240k reserved, 42k data, 36k init, 0k highmem)

Output from /proc/driver/nvram (i.e. CMOS 0x15->0x18)
   DOS base memory: 640 kB
   Extended memory: 4416 kB (configured), 4416 kB (tested)

Not a big panic, as the machine is useless anyway, but I thought
I'd mention it regardless. 

<insert your favourite quote from Alan about BIOS writers here...>

Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
