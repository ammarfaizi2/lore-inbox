Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317594AbSFIKzr>; Sun, 9 Jun 2002 06:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317595AbSFIKzq>; Sun, 9 Jun 2002 06:55:46 -0400
Received: from maila.telia.com ([194.22.194.231]:29914 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S317594AbSFIKzn>;
	Sun, 9 Jun 2002 06:55:43 -0400
To: Tobias Diedrich <ranma@gmx.at>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, mochel <mochel@osdl.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3CFB4DDC.30704@oracle.com> <m2bsaomj1j.fsf@ppro.localdomain>
	<20020609091711.GA32671@router.ranmachan.dyndns.org>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Jun 2002 12:55:37 +0200
Message-ID: <m2r8jgd8ly.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Diedrich <ranma@gmx.at> writes:

> Peter Osterlund wrote:
> > Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> > 
> > > In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
> > >   in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:
> > 
> > Same problem here. My network card isn't seen either by the kernel in
> > 2.5.20. If it's still broken in 2.5.21, maybe I'll try to fix it.
> 
> This oneliner fixes it for me, but I don't know if that's the right fix:

Thanks, it fixes my problem too. (This patch is still needed in
2.5.21.) However, in 2.5.21 I get an oops at shutdown in
device_detach. This happens both with and without your patch:

flushing ide devices: hda <1>Unable to handle kernel NULL pointer dereference a4
c017ae03
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c017ae03>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02f6d24   ebx: c3784000   ecx: 00000000   edx: 00000000
esi: c02f6d0c   edi: c0290180   ebp: 00000000   esp: c3785e50
ds: 0018   es: 0018   ss: 0018
Stack: c02f6d0c c02f6bb4 00000001 c017b17d c02f6d0c c02f6bb0 c01b030c c02f6d0c 
       c02f6bb0 c01a9a26 c02f6bb0 c028fcbc 00000000 00000001 bffffcc8 c011e27c 
       c028fcbc 00000001 00000000 00000001 c3784000 fee1dead c011e64e c02d8b88 
Call Trace: [<c017b17d>] [<c01b030c>] [<c01a9a26>] [<c011e27c>] [<c011e64e>] 
   [<c01241ec>] [<c020e776>] [<c0208f57>] [<c0138f7b>] [<c014ac2e>] [<c02067a4> 
   [<c01490ec>] [<c01380ea>] [<c0136bc0>] [<c0136c31>] [<c0106ee7>] 
Code: 89 4a 04 89 11 89 46 18 89 40 04 8b 43 10 48 89 43 10 8b 43 

>>EIP; c017ae03 <device_detach+53/a0>   <=====
Trace; c017b17d <put_device+6d/a0>
Trace; c01b030c <idedisk_cleanup+1c/60>
Trace; c01a9a26 <ata_sys_notify+a6/e0>
Trace; c011e27c <notifier_call_chain+1c/40>
Trace; c011e64e <sys_reboot+fe/2a0>
Trace; c01241ec <handle_mm_fault+6c/120>
Trace; c020e776 <dev_change_flags+106/110>
Trace; c0208f57 <sk_free+37/40>
Trace; c0138f7b <invalidate_inode_buffers+b/70>
Trace; c014ac2e <clear_inode+e/b0>
Trace; c02067a4 <sock_destroy_inode+14/20>
Trace; c01490ec <dput+1c/1a0>
Trace; c01380ea <fput+ea/110>
Trace; c0136bc0 <filp_close+a0/b0>
Trace; c0136c31 <sys_close+61/90>
Trace; c0106ee7 <syscall_call+7/b>
Code;  c017ae03 <device_detach+53/a0>
00000000 <_EIP>:
Code;  c017ae03 <device_detach+53/a0>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c017ae06 <device_detach+56/a0>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c017ae08 <device_detach+58/a0>
   5:   89 46 18                  mov    %eax,0x18(%esi)
Code;  c017ae0b <device_detach+5b/a0>
   8:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c017ae0e <device_detach+5e/a0>
   b:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c017ae11 <device_detach+61/a0>
   e:   48                        dec    %eax
Code;  c017ae12 <device_detach+62/a0>
   f:   89 43 10                  mov    %eax,0x10(%ebx)
Code;  c017ae15 <device_detach+65/a0>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
