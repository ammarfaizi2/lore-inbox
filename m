Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRCLM2B>; Mon, 12 Mar 2001 07:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRCLM1l>; Mon, 12 Mar 2001 07:27:41 -0500
Received: from mumm.ibr.cs.tu-bs.de ([134.169.34.190]:46798 "EHLO
	mumm.ibr.cs.tu-bs.de") by vger.kernel.org with ESMTP
	id <S129828AbRCLM1f>; Mon, 12 Mar 2001 07:27:35 -0500
Date: Mon, 12 Mar 2001 13:26:51 +0100
Message-Id: <200103121226.NAA09602@kelts.ibr.cs.tu-bs.de>
From: Joerg Diederich <dieder@ibr.cs.tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with mtrr and Cyrix 6x86MX: no mtrr for...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I switched to Linux 2.4 recently and ran into the following problem:

When starting XFree 4.0.2, I get error messages like

'no mtrr for 0xe0000000,0x400000' (or sth similar, I am not currently
at the machine with the Cyrix).

Digging deeper, I found the following, non XFree-related problem:

When I do 
'echo "base=0xe0000000 size=0x400000 type=write-combining" > /proc/mtrr' 

as said in linux/Documentation/mtrr.txt in order to enable mtrr's for
my graphics board, a 'cat /proc/mtrr' tells me, that the size is 8MB.

If I do
'echo "base=0xe0000000 size=0x200000 type=write-combining" > /proc/mtrr' 

the behaviour becomes even stranger:

When I do it the first time, again the size is 8MB (according to
/proc/mtrr). When I delete the entry again (with 'echo delete...'),
and repeat the above 'echo "base...', then the size is 4MB and there
are no error messages when I start Xfree (which increases the 'count'
in /proc/mtrr to 2).

Probably it might be of interest, that the '8MB size' entry in
/proc/mtrr is always in reg=6, whereas the 4MB size entry is in reg=2.

My question is now, if this behavior is correct (since I do not know
at all, what the mtrr stuff does except for that it speeds up my
system. That's why I want to use it :-) or if it is an already known
bug.

If it is an unknown bug, I can give more information if someone tells
me which one (exact /proc/mtrr output, /proc/cpuinfo etc, I didn't
want to attach all the stuff in case this issue is known already)

I am using the 2.4.2 kernel from SuSe, but I think this is not related
to the SuSe-kernel... (However, I can check it with vanilla 2.4.2 or
any patched version).


Regards,

/J"org
