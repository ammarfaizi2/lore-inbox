Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNSXs>; Thu, 14 Dec 2000 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131968AbQLNSXi>; Thu, 14 Dec 2000 13:23:38 -0500
Received: from daVinci.scs.carleton.ca ([134.117.5.50]:10244 "EHLO
	scs.carleton.ca") by vger.kernel.org with ESMTP id <S129773AbQLNSX3>;
	Thu, 14 Dec 2000 13:23:29 -0500
Date: Thu, 14 Dec 2000 12:52:43 -0500
From: James Moody <jemoody@scs.carleton.ca>
To: linux-kernel@vger.kernel.org
Subject: sparc32 + 2.4.0-test12 == trouble
Message-ID: <20001214125243.A8435@sigma07.scs.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Apologies if this comes through twice, I waited a day after sending it
and didn't see it on the list, so I'm resending it.

I've compiled stock (not CVS) 2.4.0-test12 on my SparcStation 1+ (sun4c).
Random problems occur rather frequently when using this machine; they do
not show up at all running 2.2.18preSomething on the same machine. Is there
still more CVS code that needs to be merged before sparc32 is usable?

Examples of bad behaviour:

- swapoff hangs the machine. Always. No oops, no trace, no nothing.
Investigating this, it seems that even running swapon after the machine
has booted has the same effect; however, the swapon that runs during
startup appears to work okay. Strange. Thinking swap may be the problem,
I removed it, running only from main memory, and the following problems
still persisted:

- Running arbitrary commands non-deterministically results in segmentation
faults, file descriptor problems, and other random failures sometimes
but not always. Running twice consecutively is almost guaranteed to change
the location of the error in a long operation.

# cd /usr/src/linux ; make oldconfig
scripts/Configure: command_substitute: cannot duplicate pipe as fd 1: Bad file descriptor

# dpkg -i libc6_2.2-5.deb
...
Setting up libc6 (2.2-5) ...
/var/lib/dpkg/info/libc6.postinst: line 6:  2090 Bus error               ( init u; sleep 1 )

# cd /usr/src/linux ; make dep
...
/bin/sh ./check_asm.sh -data task tmp.i check_asm_data.c
/bin/sh ./check_asm.sh -data mm tmp.i check_asm_data.c
make[1]: *** [check_asm] Segmentation fault
make[1]: Leaving directory `/usr/src/linux-2.4.0-test12/arch/sparc/kernel'
make: *** [check_asm] Error 2

I have tried to strace a command that is broken, but have been unable to
do so due to Heisenberg; when I try to strace it, everything seems to work.

Other than that, the system seems to 'work'; it boots up okay, I can log 
in, etc.

Nothing out of the ordinary is printed in the system logs.

.config available upon request. The system is an up-to-date Debian woody
machine.

Some pertinent packages:

ii  mount          2.10q-1        Tools for mounting and manipulating filesyst
ii  libc6          2.2-5          GNU C Library: Shared libraries and Timezone
ii  gcc            2.95.2-20      The GNU C compiler.
ii  sysvinit       2.78-4         System-V like init.

# uname -a
Linux sparc-plus 2.4.0-test12 #1 Tue Dec 12 02:41:58 EST 2000 sparc unknown

If there's any relevant information I haven't included please let me know.

Thanks for any help,

james

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
