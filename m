Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131433AbQKBBdG>; Wed, 1 Nov 2000 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131804AbQKBBc4>; Wed, 1 Nov 2000 20:32:56 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:27588 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131433AbQKBBcj>; Wed, 1 Nov 2000 20:32:39 -0500
Message-Id: <4.2.0.58.20001101202452.00a79440@engr.de.psu.edu>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.0.58 
Date: Wed, 01 Nov 2000 20:32:35 -0500
To: linux-kernel@vger.kernel.org
From: Eric Reischer <emr@engr.de.psu.edu>
Subject: Issue compiling 2.4test10
Cc: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to cross-compile a 2.4 kernel for a PowerPC arch on an 
Intel machine, of which I have Debian 2.2 installed.  I have successfully 
compiled a 2.4test9 kernel, but I got the following error message the first 
time I compiled (it failed due to this):

powerpc-unknown-linux-gnu-ld -T arch/ppc/mm/mm.o <blah blah blah on same 
command for about 11 lines>
drivers/input/inputdrv.o: In function 'keybdev_event':
drivers/input/inputdrv.o(.text+0x16bc): undefined reference to 'emulate_raw'
drivers/input/inputdrv.o(.text+0x16bc): relocation truncated to fit: 
R_PPC_REL24 emulate_raw
make: *** [vmlinux] Error 1


Quoting Martin Costabel <costabel@wanadoo.fr>:

<snip>
The function emulate_raw is used without any ifs, but its definition
some lines earlier is enclosed in either
#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) ||
defined(__mips__)
or
#elif defined(CONFIG_ADB_KEYBOARD)
So in your case you would need to put CONFIG_ADB_KEYBOARD=y into your
.config file. Or change these weird #ifs.
The bitkeeper version of the file is somewhat better in that it uses only 
one set of conditionals,
#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) ||
defined (__mips__) || defined(CONFIG_PPC)
but the function is still used without any condition.
</snip>

 From what he tells me, this remains an issue in the test10 release.  I 
disabled the entire feature from within xconfig, recompiled, and it 
succeeded.  If you need any more info, let me know and I'll see what I can do.



----------
Eric Reischer                                   "You can't depend on your eyes
emr@engr.de.psu.edu                            if your imagination is out 
of focus."
emr@ccil.org                                                    -- Mark Twain

----------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
