Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVGBAHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGBAHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 20:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGBAHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 20:07:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10253 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261661AbVGBAGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 20:06:54 -0400
Date: Sat, 2 Jul 2005 02:06:50 +0200
From: Willy TARREAU <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.31-hf1
Message-ID: <20050702000650.GB15460@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

after a quiet month, it's time to release another set of hotfixes for 2.4.
Although 2.4.31 is out, about 1 third of the downloads are for 2.4.29, so
I still produce updates for this kernel.

The new versions are :
  - 2.4.29-hf11
  - 2.4.30-hf4
  - 2.4.31-hf1

Main changes are various security fixes on sparc64 and x86_64, two fixes
related to bluetooth, and one bug affecting netlink sockets hashing.

All those can be fetched as tarballs, full patches and incremental patches
from there :

   http://linux.exosec.net/kernel/2.4-hf/

I've built only 2.4.31-hf1 to ensure that I was not posting pure crap, but
I bet that within a few hours, Grant Coady will have posted full build
reports there :

   http://scatter.mine.nu/linux-2.4-hotfix/

Please consult the changelog at the end of this mail for more information.
As usual, if anything goes wrong, do not hesitate to bother me.

Have fun,
willy

--

Changelog From 2.4.31 to 2.4.31-hf1 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.31-sparc64-solaris-emu-check-cmsg-len-1                 (David S. Miller)

  [SPARC64]: Fix cmsg length checks in Solaris emulation layer.

+ 2.4.31-x86_64-ia64-32bit-execve-overflow-1                       (Andi Kleen)

  [PATCH] Fix buffer overflow in x86-64/ia64 32bit execve
  Fix buffer overflow in x86-64/ia64 32bit execve. Originally noted
  by Ilja van Sprundel. I fixed it for both x86-64 and IA64. Other
  architectures are not affected.

+ 2.4.31-x86_64-ptrace-check-canonical-addr-1                      (Andi Kleen)

  [PATCH] Check for canonical addresses in ptrace
  Check for canonical addresses in ptrace. This works around a AMD
  bug that allows to hang the CPU by passing illegal addresses.

+ 2.4.31-x86_64-fix-ptrace-check-for-seg-regs-1                    (Andi Kleen)

  [PATCH] Fix canonical checking for segment registers in ptrace
  Fix canonical checking for segment registers in ptrace. This avoids a
  local DOS where a process could oops the kernel by passing bogus values
  to ptrace. Some versions of UML did this. Found by Alexander Nyberg

+ 2.4.31-x86_64-disable-exception-stack-1                          (Andi Kleen)

  [PATCH] x86_64: Disable exception stack for stack faults
  Just drop the exception stack for stack segment faults. This will
  make some oops triple fault now, but that's better than allowing
  user triggerable oops.  Found from RedHat QA using crashme

+ 2.4.31-bluetooth-hci_usb-race-hangs-kernel-1                (Marcel Holtmann)

  [PATCH] Fix introduced in 2.4.27pre2 for bluetooth hci_usb race
  causes kernel hang.
  > I have noticed a problem with a race condition fix introduced in
  > 2.4.27-pre2 that causes the kernel to hang when disconnecting a
  > Bluetooth USB dongle or doing 'hciconfig hci0 down'. No message is
  > printed, the kernel just doesn't respond anymore.

  if this works then we should do the same change in the bfusb driver. A
  patch that fixes both drivers is attached.

+ 2.4.31-netlink-socket-hashing-bugs-1                        (David S. Miller)

  [NETLINK]: Fix two socket hashing bugs.
  netlink_release() should only decrement the hash entry count if the
  socket was actually hashed. netlink_autobind() needs to propagate
  the error return from netlink_insert(). Otherwise, callers will not
  see the error as they should and thus try to operate on a socket
  with a zero pid, which is very bad. Thanks to Jakub Jelinek for
  providing backtraces, and Herbert Xu for debugging patches to help
  track this down.
  
+ 2.4.31-no-32bit-moves-on-seg-regs-1                                (H. J. Lu)

  [PATCH] newer i386/x86_64 assemblers prohibit instructions for moving
  between a seg register and a 32bit location. The new i386/x86_64
  assemblers no longer accept instructions for moving between a segment
  register and a 32bit memory location.

+ 2.4.30-serial-null-dereference-1.diff                         (Julien Tinnes)

  Potential null pointer dereference in serial driver.

END.

