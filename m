Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQLDKGz>; Mon, 4 Dec 2000 05:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLDKGp>; Mon, 4 Dec 2000 05:06:45 -0500
Received: from dyn-213-36-64-176.ppp.libertysurf.fr ([213.36.64.176]:11780
	"EHLO socrate.mon-domaine") by vger.kernel.org with ESMTP
	id <S129514AbQLDKG2>; Mon, 4 Dec 2000 05:06:28 -0500
To: linux-kernel@vger.kernel.org
Cc: Marc Lefranc <mlefranc@libertysurf.fr>
Subject: 2.4.0-test12pre3 : kernel NULL pointer dereference
From: Marc Lefranc <mlefranc@libertysurf.fr>
Date: 04 Dec 2000 10:35:42 +0100
Message-ID: <p6rg0k45y1d.fsf@socrate.mon-domaine>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine : Red Hat 7.0 system on a K6-2@450, with vanilla
2.4.0-test12pre3 (except compiled with -O3 rather than -O2 (and yes,
with kgcc-egcs)), RH glibc 2.2 SRPM update recompiled with options -O3
-mcpu=k6.

After having recompiled the WindowMaker RPMS, I noticed something was
wrong when installation failed with a segmentation fault. After a
closer look, it turned out that it was /sbin/ldconfig (called in the
installation scripts) that was segfaulting with the following trace in
/var/log/messages :

Dec  4 09:39:51 socrate kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec  4 09:39:51 socrate kernel:  printing eip:
Dec  4 09:39:51 socrate kernel: c0147356
Dec  4 09:39:51 socrate kernel: *pde = 00000000
Dec  4 09:39:51 socrate kernel: Oops: 0000
Dec  4 09:39:51 socrate kernel: CPU:    0
Dec  4 09:39:51 socrate kernel: EIP:    0010:[d_lookup+102/252]
Dec  4 09:39:51 socrate kernel: EFLAGS: 00010217
Dec  4 09:39:51 socrate kernel: eax: c11ab6e8   ebx: ffffffe8   ecx: 0000001c   edx: c11a0000
Dec  4 09:39:51 socrate kernel: esi: 2f311bd2   edi: c5c7b7e0   ebp: 00000000   esp: c23a5f14
Dec  4 09:39:51 socrate kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 09:39:51 socrate kernel: Process ldconfig (pid: 10388, stackpage=c23a5000)
Dec  4 09:39:51 socrate kernel: Stack: c5c4fa20 00000000 c5c7b7e0 bfffe800 c11ab6e8 c32b0009 2f311bd2 00000010 
Dec  4 09:39:51 socrate kernel:        c013dfe1 c5c4fa20 c23a5f64 00000000 c32b0000 c32b0000 bfffe800 c23a4000 
Dec  4 09:39:51 socrate kernel:        c23a5f64 c23a4000 00000008 00000000 c32b0009 00000010 2f311bd2 c013e817 
Dec  4 09:39:51 socrate kernel: Call Trace: [path_walk+1717/2692] [__user_walk+199/228] [sys_lstat64+22/112] [system_call+51/64] 
Dec  4 09:39:51 socrate kernel: Code: 8b 6d 00 8b 74 24 18 39 73 48 75 72 8b 74 24 24 39 73 0c 75 

After that, every call to ldconfig was giving a segmentation fault. I
rebooted to 2.2.18pre17 and everything was back to normal. I then
rebooted to 2.4.0-test12pre3 and ldconfig seemed to work as usual.


Provided I didn't something dumb and there is a real problem, it will
be a pleasure if I can do anything to help diagnose this problem.

Marc

P.S. I have been truly impressed by the performance gain in switching
from 2.2.X to 2.4.0-test12pre3 ! Even more that when I first booted
2.0.0 and 2.2.0 :-) But I guess I will quickly adapt...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
