Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286198AbRLJId0>; Mon, 10 Dec 2001 03:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286202AbRLJIdR>; Mon, 10 Dec 2001 03:33:17 -0500
Received: from [195.66.192.167] ([195.66.192.167]:4615 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286198AbRLJIdD>; Mon, 10 Dec 2001 03:33:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] fully preemptible kernel
Date: Mon, 10 Dec 2001 10:29:51 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, kpreempt-tech@lists.sourceforge.net
In-Reply-To: <1007930466.11789.2.camel@phantasy> <01121008545000.01013@manta> <1007967834.878.30.camel@phantasy>
In-Reply-To: <1007967834.878.30.camel@phantasy>
MIME-Version: 1.0
Message-Id: <01121010295102.01013@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 December 2001 05:03, Robert Love wrote:
> On Mon, 2001-12-10 at 05:54, vda wrote:
> > I reported a problem with preemptible 2.4.13 and Samba server (oops,
> > problems with creation of files from win clients).
> > Is this issue addressed?
>
> No, because I could not reproduce it.  Could you see if it occurs on the
> current kernel with the current patch?  If so, send me the relevant
> information.
>
> 	Robert Love

This is my report dating back to 2.4.10.
Since getting oops is not easy (actually, oops is rare, but buggy behavios 
described below is consistent) I don't have newer oops.
I have ksymoops compiled from sources and it does not work right
("Error (Oops_bfd_perror): set_section_contents Section has no contents").
Can you enlighten me why I'm getting ths message?
Or just send me working ksymoops binary, we can sort out this later.

Ok, I'll compile and install 2.4.17-pre6-pr now.

--------------------------------------------------------------------------
On first attempt to create/copy files from win box to linux samba server it 
says that "file/dir already exists" or that "connection terminated". File/dir 
is indeed exists, in case of a file it is of zero length. Subsequent copy with
overwrite succeeds.

It seems that smbd dies after it has created file/dir but before
reporting this fact to the client. New smbd gets spawned by inetd
then and it see that file/dir is already there.

It might be related to newer kernel.
I am willing to track it further.

Samba: 2.2.1a
Kernel: 2.4.10

Also I've got two oopses so far. One of them decoded below
(my first ksymoops, I don't know is it done right on not)

--------------------------------------------
ksymoops 2.4.3 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information....
<snip>

Unable to handle kernel paging request at virtual address 4008e6ed
*pde = 01100067
Oops: 0003
CPU:    0
EIP:    0010:[<c010655b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 4008e76d   ecx: 4008e6cd   edx: 0000e865
esi: 00000000   edi: 00000128   ebp: 4008e6c9   esp: c1c5bf74
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 213, stackpage=c1c5b000)
Stack: 5650faf0 c1c5a000 c029afd0 00000128 c01068d0 4008e6cd 4008e76d c1c5bf94
       c02a23b2 55c3c85e ec83e589 4000bcd9 40015f67 4000bcd9 40015f67 c1c5a000
       00000000 00000000 bfffea74 c0107603 00000000 bfffe6a3 00000001 00000000
Call Trace: [<c01068d0>] [<c0107603>]
Code: 89 51 20 31 c0 66 8b 53 0c 81 e2 ff ff 00 00 09 c6 89 51 1c
Error (Oops_bfd_perror): set_section_contents Section has no contents

>>EIP; c010655a <restore_sigcontext+3a/140>   <=====
Trace; c01068d0 <sys_rt_sigreturn+110/180>
Trace; c0107602 <system_call+32/40>

1 warning and 1 error issued.  Results may not be reliable.
--
vda
