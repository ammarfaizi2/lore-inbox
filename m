Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBOEwk>; Wed, 14 Feb 2001 23:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRBOEwT>; Wed, 14 Feb 2001 23:52:19 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:9484 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129084AbRBOEwL>; Wed, 14 Feb 2001 23:52:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
Date: Thu, 15 Feb 2001 14:01:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14987.18073.894988.290718@notabene.cse.unsw.edu.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andrew Morton'" <andrewm@uow.edu.au>
Subject: Re: NFSD die with 2.4.1 (resend with ksymoops)
In-Reply-To: message from Jean-Eric Cuendet on Wednesday February 14
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF683955@mailsrv.linkvest.ch>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 14, Jean-Eric.Cuendet@linkvest.com wrote:
> 
> Hi all,
> I have a machine with kernel 2.4.1 + acls patch. It exports some volume via
> NFS (installed with RedHat 7.0 + custom 2.4.1 kernel). The underlying
> filesystem is ext2. I tried with NFS v2 and v3 and without ACLs in the
> kernel. results are the same.
....
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[acpi_exit+0/-1072693248]
> EFLAGS: 00010286
> eax: 00000000   ebx: c4f5c03c   ecx: c091d040   edx: c0173710
> esi: c4f63424   edi: c4f5c03c   ebp: c4f5c03c   esp: c4f61f38
> ds: 0018   es: 0018   ss: 0018
> Process nfsd (pid: 2690, stackpage=c4f61000)
> Stack: c0173774 c091d040 00008000 c4f63000 c02f9220 c4f5c014 c4f63000
> c091d040
>        a1ffc014 c016bdbb c4f63000 c4f5c01c c4f63400 c4f63138 c02f9220
> c4f63490
>        c0273e38 c4f63000 c4f5c014 c4f60000 0034fdbb c7f68560 c4f60550
> c4f63400
> Call Trace: [nfssvc_encode_diropres+100/520] [nfsd_dispatch+275/360]
> [svc_process+684/1348] [nfsd+401/760] [kernel_thread+35/48]
> Code:  Bad EIP value.
> Using defaults from ksymoops -t elf32-i386 -a i386

This trace seems to make sense, except that nfssvc_encode_diropres
doesn't seem to make any subroutine calls at offset 100 as seems to be
implied. 

Could you run

 echo disassemble nfssvc_encode_diropres | gdb -batch -x /dev/stdin vmlinux

giving it the vmlinux that was running when this oops was produced? and
also tell me exactly what patches you have ontop of 2.4.1 and where to
find them.

NeilBrown
