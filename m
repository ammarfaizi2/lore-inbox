Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284609AbRLZRgB>; Wed, 26 Dec 2001 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284613AbRLZRfu>; Wed, 26 Dec 2001 12:35:50 -0500
Received: from bdsl.66.12.238.34.gte.net ([66.12.238.34]:19624 "EHLO
	mail.pdaverticals.com") by vger.kernel.org with ESMTP
	id <S284609AbRLZRfn>; Wed, 26 Dec 2001 12:35:43 -0500
Organization: Rude Dog Dot Org
To: linux-kernel@vger.kernel.org
Subject: Kernel crash with knfsd
From: Dave Carrigan <dave@rudedog.org>
Date: 26 Dec 2001 09:35:38 -0800
Message-ID: <87heqdanpx.fsf@pdaverticals.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I am not subscribed, so please CC any response to me)

I am having the following problem:

Sometimes, when my wife's laptop comes out of suspend mode, it causes my
nfs server to lock up hard -- I have to hit the reset button. Even after
I reset the server, it will just lock up again a few seconds after knfsd
starts, as long as the laptop is still on the net. If I suspend the
laptop, then start the server, it will start fine, and I can usually
unsuspend the laptop after that without problems. Up until yesterday,
there was never anything in the logs.

Yesterday, after the laptop unsuspended, the nfs service died. This time
however, the server itself didn't lock up, and this was in the kernel
log:

 Dec 25 14:51:35 pern kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 Dec 25 14:51:35 pern kernel:  printing eip:
 Dec 25 14:51:35 pern kernel: 00000000
 Dec 25 14:51:35 pern kernel: *pde = 00000000
 Dec 25 14:51:35 pern kernel: Oops: 0000
 Dec 25 14:51:35 pern kernel: CPU:    0
 Dec 25 14:51:35 pern kernel: EIP:    0010:[<00000000>]    Tainted: P 
 Dec 25 14:51:35 pern kernel: EFLAGS: 00010286
 Dec 25 14:51:35 pern kernel: eax: 00000000   ebx: cf3aad20   ecx: cf3aa8fc   edx: c033c800
 Dec 25 14:51:35 pern kernel: esi: cf3aa8a0   edi: cf3aad20   ebp: 11270000   esp: cc753e90
 Dec 25 14:51:35 pern kernel: ds: 0018   es: 0018   ss: 0018
 Dec 25 14:51:35 pern kernel: Process nfsd (pid: 668, stackpage=cc753000)
 Dec 25 14:51:35 pern kernel: Stack: c016c820 ccc61820 cf3aa8a0 cfcc05f0 cf3aad20 c016cc96 cf3aad20 cc796404 
 Dec 25 14:51:35 pern kernel:        00000002 cc647000 11270000 cfcc05f0 cf3aad20 c016cf98 cfcc0400 cc796414 
 Dec 25 14:51:35 pern kernel:        00000002 00000001 00000001 cc796404 cc796690 cc796404 0000000e c0113c4a 
 Dec 25 14:51:35 pern kernel: Call Trace: [nfsd_findparent+52/256] [find_fh_dentry+558/820] [fh_verify+508/988] [reschedule_idle+98/540] [nfsd_lookup+114/1016] 
 Dec 25 14:51:35 pern kernel:    [nfsd3_proc_lookup+212/224] [nfsd_dispatch+211/416] [svc_process+653/1240] [nfsd+503/808] [kernel_thread+40/56] 
 Dec 25 14:51:35 pern kernel: 
 Dec 25 14:51:35 pern kernel: Code:  Bad EIP value.

I couldn't restart nfsd and had to reboot the server, and of course it
locked up hard during reboot, and I had to suspend the laptop before I
could bring the server up.

The server is running 2.4.16 with XFS patches. The nfs-exported
directories are both xfs and rieserfs. The laptop runs kernel autofs,
and probably would have both of the server's xfs and reiserfs
filesystems mounted at suspend time, because Nautilus tends to keep some
filesystems permanently mounted.

The laptop is also running 2.4.16. Both systems are using the tulip.o
driver from 2.4.14, but the same problem was occurring when I had the
2.4.16 tulip driver on each system. 

I'm fairly certain that I saw this problem with 2.4.14 on the server as
well, but I don't recall for sure. The laptop's only been running linux
for a couple of weeks, so I can't say if this affected any older
kernels.

I will be happy to provide more information or do any special
troubleshooting for anyone who wants it.

-- 
Dave Carrigan (dave@rudedog.org)            | Yow! Just imagine you're
UNIX-Apache-Perl-Linux-Firewalls-LDAP-C-DNS | entering a state-of-the-art CAR
Seattle, WA, USA                            | WASH!!
http://www.rudedog.org/                     | 
