Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVBZQD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVBZQD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVBZQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:03:59 -0500
Received: from exosec.net1.nerim.net ([62.212.114.195]:29463 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261226AbVBZQCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:02:16 -0500
Date: Sat, 26 Feb 2005 17:02:14 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.29-hf3
Message-ID: <20050226160214.GA3766@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just uploaded 2.4.29 hotfix 3 here :

  http://linux.exosec.net/kernel/2.4-hf/2.4.29-hf3/

Just merged some small fixes to stay up to date with -bk, nothing critical.
Changelog below.

Cheers,
Willy

--
Changelog From 2.4.29-hf2 to 2.4.29-hf3 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

+ net-oops-base_reachable_time-zero-1                        (Hideaki Yoshifuji)

  [NET]: Fix kernel oops if base_reachable_time is set to 0.

+ tunsetiff-needs-copy-back-after-ioctl-1                      (David S. Miller)

  [COMPAT]: TUNSETIFF needs to copy back data after ioctl.
  It is defined as a _IOW() which is erroneous, it should
  have been defined as _IORW() but that cannot be changed
  now without breaking all existing applications using this
  ioctl.

+ sparc32-smp-clear-psr_ef-on-fork-1                           (David S. Miller)

  [SPARC32]: Need to clear PSR_EF in psr of childregs on fork() on SMP.

+ netlink_remove-unhash-leaks-sockets-1                        (Patrick McHardy)

  netlink_remove() only unhashes sockets contained in the 
  first hash bucket.  This leads to leaking sockets and,
  over time, to bind conflicts which confuse iproute.

+ brlock-causes-deadlock-1                                     (David S. Miller)

  There were two versions of the big-reader lock implementation.
  
  1) One using per-cpu reader locks, and a singular write lock.
     Predominantly enabled on x86 and it's brothers.
  
  2) One using non-atomic per-cpu counter, and a single write lock.
     This is what all other platforms were using.
  
  #1 is unfortunately buggy.  brlocks were meant to provide a
  high performance implementation of rwlock_t locks when it
  is known that the lock is taken %99 of the time by readers
  and that writers are thus rare. (...)  

+ 32bit-sys_recvmsg-corruption-1                              (Stephen Rothwell)

  In the presence of threads, there is a possibility of the kernel being
  fooled by the 32 bit sys_recvmsg control data into copying more than it
  should into the kernel and corrupting kernel data structures. (...)
  This patch just does some more length checking. This bug was actually
  being hit by BIND running at a customer site.  It is very hard to hit,
  but (obviously) possible.

+ sparc64-32bit-compat-bugs-1                                  (David S. Miller)

  Fix 32bit compat layer bugs in sys_ipc() and sys_rt_sigtimedwait().
  1) sys_ipc() compat wrappers need to verify length before allocating
     kernel data and performing copies.
  2) sys_rt_sigtimedwait() had one schedule_timeout() too many.
  
- sparc-membar-extra-semi-colons-1                               (Willy Tarreau)
- sparc64-membar-extra-semi-colons-1                             (Willy Tarreau)

  This was my quick build fix. Now David has sent the clean stuff.

+ sparc-smb_macros-extra-semicolons-1                          (David S. Miller)

  [SPARC]: Fix bogus trailing semicolon in smb_*() macros.
  Backported from 2.6.x

+ sparc-nop-extra-semicolons-1                                 (David S. Miller)

  [SPARC]: nop() macro has bogus trailing semicolon 
  Noticed by Bob Breuer.

+ sparc64-membar-extra-semicolons-2                            (David S. Miller)

  [SPARC64]: Fix trailing semicolon in membar macros.

