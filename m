Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbRE1K3E>; Mon, 28 May 2001 06:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263027AbRE1K2y>; Mon, 28 May 2001 06:28:54 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:47698 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263026AbRE1K2o>; Mon, 28 May 2001 06:28:44 -0400
Date: Mon, 28 May 2001 13:28:31 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: initrd oops with 2.4.5ac2: Tthe other oops remains (one fixed)
Message-ID: <20010528132831.Q11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi> <20010528001220.M11981@niksula.cs.hut.fi> <20010528102551.N11981@niksula.cs.hut.fi> <20010528180254.380908d8.masaruk@gol.com> <20010528130507.P11981@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528130507.P11981@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Mon, May 28, 2001 at 01:05:07PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 01:05:07PM +0300, you [Ville Herva] claimed:
> On Mon, May 28, 2001 at 06:02:54PM +0900, you [Masaru Kawashima] claimed:
> > On Mon, 28 May 2001 10:25:51 +0300
> > Ville Herva <vherva@mail.niksula.cs.hut.fi> wrote:
> > > The oops call trace seems to be the same as in 
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2
> > > 
> > > Any ideas?
> > 
> > Did you try the patch posted by Go Taniguchi <go@turbolinux.co.jp>?
> > Following is the copy of his message and the patch itself.
> > 
> > --- linux/fs/block_dev.c.orig	Mon May 28 12:40:12 2001
> > +++ linux/fs/block_dev.c	Mon May 28 12:40:12 2001
> > @@ -602,6 +602,7 @@
> >  	if (!bdev->bd_op->ioctl)
> >  		return -EINVAL;
> >  	inode_fake.i_rdev=rdev;
> > +	inode_fake.i_bdev=bdev;
> >  	init_waitqueue_head(&inode_fake.i_wait);
> >  	set_fs(KERNEL_DS);
> >  	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);
> 
> Yes, I actually spotted the patch on l-k just a while ago and tried it.
> 
> It does fix the initrd case; I haven't tried the grub case, but I suspect it
> still remains. Will try that as well asap.

The other OOPS (http://v.iki.fi/~vherva/tmp/bootlog.grub and
http://v.iki.fi/~vherva/tmp/ksymoops-grub) still remains: 

>>EIP; c014259a <find_inode+1a/50>   <=====
Trace; c0142995 <iget4+45/d0>
Trace; c012a492 <__alloc_pages+62/230>
Trace; c0145c60 <proc_get_inode+40/100>
Trace; c0145d4c <proc_read_super+2c/b0>
Trace; c01343e2 <read_super+62/b0>
Trace; c01348ff <kern_mount+4f/b0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c0100197 <L6+0/2>
Code;  c014259a <find_inode+1a/50>
00000000 <_EIP>:
Code;  c014259a <find_inode+1a/50>   <=====
   0:   39 7e 20                  cmp    %edi,0x20(%esi)   <=====
Code;  c014259d <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c0142590
<find_inode+10/50>
Code;  c014259f <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425a3 <find_inode+23/50>
   9:   39 86 90 00 00 00         cmp    %eax,0x90(%esi)
Code;  c01425a9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c0142590
<find_inode+10/50>
Code;  c01425ab <find_inode+2b/50>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx


2.4.2-2 (redhat) is fine; 2.4.4 vanilla oopses after probing PCI hardware
(so it goes little further than 2.4.5ac2), and 2.4.5ac2 oopses after making
page-cache hash table.

 
-- v --

v@iki.fi
