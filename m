Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNKtf>; Wed, 14 Feb 2001 05:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBNKt0>; Wed, 14 Feb 2001 05:49:26 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:54286 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S129055AbRBNKtT>; Wed, 14 Feb 2001 05:49:19 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF683955@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'neilb@cse.unsw.edu.au'" <neilb@cse.unsw.edu.au>,
        "'Andrew Morton'" <andrewm@uow.edu.au>
Subject: NFSD die with 2.4.1 (resend with ksymoops)
Date: Wed, 14 Feb 2001 11:49:06 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I have a machine with kernel 2.4.1 + acls patch. It exports some volume via
NFS (installed with RedHat 7.0 + custom 2.4.1 kernel). The underlying
filesystem is ext2. I tried with NFS v2 and v3 and without ACLs in the
kernel. results are the same.

The problem is that NFSD dies unexpectedly with a Oops (see below).
When booting, I have 8 NFSD processes, but suddenly, they all die. I can't
see why it happens, because the machine is a production one and I can't
reboot it too often. But when I reboot, all is fine for a moment. And
suddenly, the 8 NFSD die altogether... Last time, I rebooted the machine at
23h00 and NFSD died ~ 9h36 next day : 10h uptime!
When running lsmod, nfsd.o has 8 locks even after NFSD died, so it's
impossible to make a rmmod (the 8 NFSD processes don't give their ressources
back).
I tried to put NFSD in the kernel directly, without modules. Same thing.
Anyone have similar problems?
Thanks for any help on that topic

Bye
-jec
PS: I'm not in the list, so CC please.
PS2: Thanks to Andrew M. for his help :-)

Oops:
ksymoops 2.4.0 on i686 2.4.1-acls0.7.5-4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-acls0.7.5-4/ (default)
     -m /boot/System.map-2.4.1-acls0.7.5-4 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[acpi_exit+0/-1072693248]
EFLAGS: 00010286
eax: 00000000   ebx: c4f5c03c   ecx: c091d040   edx: c0173710
esi: c4f63424   edi: c4f5c03c   ebp: c4f5c03c   esp: c4f61f38
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 2690, stackpage=c4f61000)
Stack: c0173774 c091d040 00008000 c4f63000 c02f9220 c4f5c014 c4f63000
c091d040
       a1ffc014 c016bdbb c4f63000 c4f5c01c c4f63400 c4f63138 c02f9220
c4f63490
       c0273e38 c4f63000 c4f5c014 c4f60000 0034fdbb c7f68560 c4f60550
c4f63400
Call Trace: [nfssvc_encode_diropres+100/520] [nfsd_dispatch+275/360]
[svc_process+684/1348] [nfsd+401/760] [kernel_thread+35/48]
Code:  Bad EIP value.
Using defaults from ksymoops -t elf32-i386 -a i386

_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 



