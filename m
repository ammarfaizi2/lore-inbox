Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbULUX6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbULUX6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULUX6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:58:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:5783 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261906AbULUX4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:56:10 -0500
Date: Wed, 22 Dec 2004 00:56:06 +0100 (MET)
From: "Manfred Schwarb" <manfred99@gmx.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       trond.myklebust@fys.uio.no
MIME-Version: 1.0
References: <20041221164610.GC3596@logos.cnet>
Subject: Re: 2.4.29-pre2 Oops at find_inode/reiserfs_find_actor
X-Priority: 3 (Normal)
X-Authenticated: #17170890
Message-ID: <1742.1103673366@www47.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> CCing the ReiserFS devel list because they might have some clue.
> 
> On Mon, Dec 20, 2004 at 11:28:52PM +0100, Manfred Schwarb wrote:
> 
> > Hi,
> > yesterday, I got at the start of a rsync backup over nfs
> > an Oops in find_inode/reiserfs_find_actor.
> > Some googling revealed that this seems to be an 
> > inode list corruption, but how can this happen?
> > There seem to be quite some reports about similar problems,
> > so doing rsync over nfs-mounted partitions might be a bad idea?
> 
> No, it should work.
> 
> > Is there anything I can do? Any help is appreciated.
> > 
> > This machine is an athlon i386 with vanilla 2.4.29-pre2.
> > Below you may find the ksymoopsified Oops:
> > 
> > 
> > Dec 19 21:00:01  kernel: Unable to handle kernel NULL pointer
> dereference at
> > virtual address 00000028
> > Dec 19 21:00:01  kernel: c0153b09
> > Dec 19 21:00:01  kernel: *pde = 1d678067
> > Dec 19 21:00:01  kernel: Oops: 0000
> > Dec 19 21:00:01  kernel: CPU:    0
> > Dec 19 21:00:01  kernel: EIP:    0010:[find_inode+25/112]    Not tainted
> > Dec 19 21:00:01  kernel: EIP:    0010:[<c0153b09>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > Dec 19 21:00:01  kernel: EFLAGS: 00213213
> > Dec 19 21:00:01  kernel: eax: e0b3c9e0   ebx: 00000000   ecx: 0000000f  
> > edx: dff80000
> > Dec 19 21:00:01  kernel: esi: 00000000   edi: dffa2a58   ebp: 000000fa  
> > esp: d7f05d60
> > Dec 19 21:00:01  kernel: ds: 0018   es: 0018   ss: 0018
> > Dec 19 21:00:01  kernel: Process nfsd (pid: 2372, stackpage=d7f05000)
> > Dec 19 21:00:01  kernel: Stack: 0efe42ff 00000000 00000002 d7f05de4
> dffa2a58
> > 000000fa da2f6000 c0153f4e
> > Dec 19 21:00:01  kernel:        da2f6000 000000fa dffa2a58 e0b3c9e0
> d7f05db8
> > d7f05de4 d7f05e48 d7f05db8
> > Dec 19 21:00:01  kernel:        da2f6000 e0b3ca60 da2f6000 000000fa
> e0b3c9e0
> > d7f05db8 00000011 d7f05de4
> > Dec 19 21:00:01  kernel: Call Trace:    [iget4_locked+94/272]
> >
>
[keybdev:__insmod_keybdev_O/lib/modules/2.4.29-pre2/kernel/drivers/i+4288752096/96]
> >
>
[keybdev:__insmod_keybdev_O/lib/modules/2.4.29-pre2/kernel/drivers/i+4288752224/96]
> >
>
[keybdev:__insmod_keybdev_O/lib/modules/2.4.29-pre2/kernel/drivers/i+4288752096/96]
> >
>
[keybdev:__insmod_keybdev_O/lib/modules/2.4.29-pre2/kernel/drivers/i+4288731921/96]
> > Dec 19 21:00:01  kernel: Call Trace:    [<c0153f4e>] [<e0b3c9e0>]
> > [<e0b3ca60>] [<e0b3c9e0>] [<e0b37b11>]
> > Dec 19 21:00:01  kernel:   [<c0151d1c>] [<c01491cf>] [<c0149279>]
> > [<e118fd71>] [<e1196d39>] [<e119de8c>]
> > Dec 19 21:00:01  kernel:   [<e118c68d>] [<c027ab3e>] [<e119de8c>]
> > [<e119d758>] [<e119d778>] [<e118c3cb>]
> > Dec 19 21:00:01  kernel:   [<c010729b>] [<e118c210>]
> > Dec 19 21:00:01  kernel: Code: 39 6b 28 89 de 75 f1 8b 44 24 20 39 83 a0
> 00
> > 00 00 75 e5 8b
> > 
> > 
> > >>EIP; c0153b09 <find_inode+19/70>   <=====
> > 
> > >>eax; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > >>edx; dff80000 <_end+1fbfd7f4/20792854>
> > >>edi; dffa2a58 <_end+1fc2024c/20792854>
> > >>esp; d7f05d60 <_end+17b83554/20792854>
> > 
> > Trace; c0153f4e <iget4_locked+5e/110>
> > Trace; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > Trace; e0b3ca60 <[reiserfs]reiserfs_iget+40/c0>
> > Trace; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > Trace; e0b37b11 <[reiserfs]reiserfs_lookup+101/120>
> > Trace; c0151d1c <d_alloc+1c/1d0>
> > Trace; c01491cf <lookup_hash+9f/d0>
> > Trace; c0149279 <lookup_one_len+79/90>
> > Trace; e118fd71 <[nfsd]nfsd_lookup+d1/490>
> > Trace; e1196d39 <[nfsd]nfsd3_proc_lookup+a9/140>
> > Trace; e119de8c <[nfsd]nfsd_procedures3+6c/320>
> > Trace; e118c68d <[nfsd]nfsd_dispatch+14d/220>
> > Trace; c027ab3e <svc_process+3de/590>
> > Trace; e119de8c <[nfsd]nfsd_procedures3+6c/320>
> > Trace; e119d758 <[nfsd]nfsd_version3+0/10>
> > Trace; e119d778 <[nfsd]nfsd_program+0/28>
> > Trace; e118c3cb <[nfsd]nfsd+1bb/330>
> > Trace; c010729b <arch_kernel_thread+2b/40>
> > Trace; e118c210 <[nfsd]nfsd+0/330>
> > 
> > Code;  c0153b09 <find_inode+19/70>
> > 00000000 <_EIP>:
> > Code;  c0153b09 <find_inode+19/70>   <=====
> >    0:   39 6b 28                  cmp    %ebp,0x28(%ebx)   <=====
> > Code;  c0153b0c <find_inode+1c/70>
> >    3:   89 de                     mov    %ebx,%esi
> > Code;  c0153b0e <find_inode+1e/70>
> >    5:   75 f1                     jne    fffffff8 <_EIP+0xfffffff8>
> > Code;  c0153b10 <find_inode+20/70>
> >    7:   8b 44 24 20               mov    0x20(%esp,1),%eax
> > Code;  c0153b14 <find_inode+24/70>
> >    b:   39 83 a0 00 00 00         cmp    %eax,0xa0(%ebx)
> > Code;  c0153b1a <find_inode+2a/70>
> >   11:   75 e5                     jne    fffffff8 <_EIP+0xfffffff8>
> > Code;  c0153b1c <find_inode+2c/70>
> >   13:   8b 00                     mov    (%eax),%eax
> 
> This is indeed corruption - an inode in this hash bucket has "->next" as 
> NULL, so find_inode goes boom.
> 
> Something is leaving this hash bucket list corrupt. 
> 
> Have you ever seen this crash before ? Can you reproduce it? 
> 

No, not at all. This machine was running for 10 months with 2.4.xx 
kernels without any problems. Since this oops, I tried to reproduce
the particular situation (rsync over nfs, and some additional load),
put I had no success in crashing the box:
I mirrored the box (ca. 1 million files) 5 times, no problem.
 

> The only inode corruption case that was reliable was from Chris Caputo
> and we end up agreeing that it was most likely a hardware issue, because
> it was
> hard to reproduce and strange in several ways. Can you point me at 
> the "quite some similar reports" you have found, please ?
> 

Just my first impression, a closer look showed that most of the
cases group around 2.4.1[789] because of lacking reiserfs_find_actor.
Sorry for the overstatement.

A recent oops report shows some similarity, using a 2.6.7 kernel:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109278828905885&w=2


Hardware issue: you mean memory? Last winter I ran memtest86
during a weekend, everything was fine. At the moment I can't
take this box offline for a longer period to test again, so I 
tend to belive memory is ok, and knock on wood...




-- 
Psssst! Mit GMX Handyrechnung senken: http://www.gmx.net/de/go/mail
100 FreeSMS/Monat (GMX TopMail), 50 (GMX ProMail), 10 (GMX FreeMail)
