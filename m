Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLASCF>; Fri, 1 Dec 2000 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbQLASBz>; Fri, 1 Dec 2000 13:01:55 -0500
Received: from [208.187.127.154] ([208.187.127.154]:47854 "EHLO
	DLT.linuxnetworx.com") by vger.kernel.org with ESMTP
	id <S129436AbQLASBp>; Fri, 1 Dec 2000 13:01:45 -0500
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: linux-kernel@vger.kernel.org, linuxbios@lanl.gov
Subject: Re: SCSI problem on aic7xxx on L440GX+ using LinuxBIOS
In-Reply-To: <Pine.LNX.4.21.0011302150410.21950-100000@mini.acl.lanl.gov>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 01 Dec 2000 10:25:36 -0700
In-Reply-To: Ronald G Minnich's message of "Thu, 30 Nov 2000 21:53:18 -0700 (MST)"
Message-ID: <m3zoigdpf3.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald G Minnich <rminnich@lanl.gov> writes:

> Eric, here is the ksymoops (end of message) from that earlier failure. I'm
> just wondering if anyone out there has seen anything like this. Also, if
> anyone sees anything odd about the scsi configuration that would help too.
> 
> Thanks in advance ...

Ron.  vger.rutgers.edu died a couple of months ago.
vger.kernel.org is the new machine, the linux kernel mailing list is on.
I'm forwarding this there.  I don't know how much help we can
get on a bug report against 2.4.0-test6 though.

Eric

> 
> ron
> On 30 Nov 2000, Eric W. Biederman wrote:
> 
> > Ronald G Minnich <rminnich@lanl.gov> writes:
> > 
> > > This is 2.4.0-test6, on an L440GX, running linuxbios. The node comes up
> > > and appears to run fine:
> > > --------
> > > (scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
> > > (scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
> > > (scsi0) Downloading sequencer code... 392 instructions downloaded
> > > (scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
> > > (scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
> > > (scsi1) Downloading sequencer code... 392 instructions downloaded
> > > scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
> > >        <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
> > > scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
> > >        <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
> > > scsi : 2 hosts.
> > > (scsi0:0:1:0) Synchronous at 40.0 Mbyte/sec, offset 31.
> > >   Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UCH0
> > >   Type:   Direct-Access                      ANSI SCSI revision: 03
> > > Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
> > >   Vendor: VA Linux  Model: Fullon 2x2        Rev: 1.01
> > >   Type:   Processor                          ANSI SCSI revision: 02
> > > scsi : detected 1 SCSI disk total.
> > > SCSI device sda: hdwr sector= 512 bytes. Sectors= 17938986 [8759 MB] [8.8
> > > GB]
> > > Partition check:
> > >  sda: sda1 sda2 sda3
> > > .
> > > .
> > > .
> > >                         Welcome to Red Hat Linux
> > >                 Press 'I' to enter interactive startup.
> > > Mounting proc filesystem [  OK  ]
> > > Configuring kernel parameters [  OK  ]
> > > hwclock: Can't open /dev/tty1, errno=19: No such device.
> > > Setting clock  (utc): Thu Nov 30 23:07:43 /etc/localtime 2000 [  OK  ]
> > > Loading default keymap/etc/rc.d/rc.sysinit: /dev/tty0: No such device
> > > [FAILED]
> > > Activating swap partitions [  OK  ]
> > > Setting hostname rpc4 [  OK  ]
> > > Checking root filesystem
> > > /dev/sda1 contains a file system with errors, check forced.
> > > /dev/sda1: Inode 84024 has illegal block(s).  [/sbin/fsck.ext2 -- /]
> > > fsck.ext2 -a /dev/sda1
> > > 
> > > 
> > > /dev/sda1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
> > >         (i.e., without -a or -p options)
> > > 
> > > -------
> > > 
> > >  But in the middle of an fsck ....
> > > 
> > > 
> > > Anyway, I'm wondering if anyone has seen anything like this at all on the
> > > aic7xxx driver. I also had a working L440GX that used IDE for /, and when
> > > i insmod aic7xxx.o I do see this same error. Any suggestions on this
> > > problem would be appreciated.
> > 
> > Hmm. This looks like a kernel bug, probably triggered by lack of
> > bios support.  Could you run the oops through ksymoops so we have a
> > clue what is wrong?  If we knew where the kernel was crashing perhaps
> > we could fix it. 
> > 
> 
> Sorry, here's the ksymoops
> 
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c012b234>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: c1410000   ebx: 00000002   ecx: 0012c8f2   edx: 08458b00
> esi: 00000008   edi: 00000801   ebp: 00000096   esp: cfb67d08
> ds: 0018   es: 0018   ss: 0018
> Process fsck.ext2 (pid: 49, stackpage=cfb67000)
> Stack: 00000021 00000000 cfb67e9c cfb67f20 00000801 0000107e c012fd73
> 00000801
>        0012c8f2 00000400 cfea9c00 ffffffea 00000000 00000400 25004400
> cbe56a20
>        0012c90d 00000000 00000801 00000000 00000001 cfb67e9c 4b234000
> 00000000
> Call Trace: [<c012fd73>] [<c01299c2>] [<c0129b5b>] [<c010ac4f>]
> Code: 39 4a 04 75 10 0f b7 42 08 3b 44 24 24 75 06 66 39 7a 0c 74
> 
> >>EIP; c012b234 <getblk+7c/124>   <=====
> Trace; c012fd73 <block_read+2df/540>
> Trace; c01299c2 <sys_lseek+5e/94>
> Trace; c0129b5b <sys_read+8b/a0>
> Trace; c010ac4f <system_call+33/38>
> Code;  c012b234 <getblk+7c/124>
> 00000000 <_EIP>:
> Code;  c012b234 <getblk+7c/124>   <=====
>    0:   39 4a 04                  cmp    %ecx,0x4(%edx)   <=====
> Code;  c012b237 <getblk+7f/124>
>    3:   75 10                     jne    15 <_EIP+0x15> c012b249
> <getblk+91/124>
> Code;  c012b239 <getblk+81/124>
>    5:   0f b7 42 08               movzwl 0x8(%edx),%eax
> Code;  c012b23d <getblk+85/124>
>    9:   3b 44 24 24               cmp    0x24(%esp,1),%eax
> Code;  c012b241 <getblk+89/124>
>    d:   75 06                     jne    15 <_EIP+0x15> c012b249
> <getblk+91/124>
> Code;  c012b243 <getblk+8b/124>
>    f:   66 39 7a 0c               cmp    %di,0xc(%edx)
> Code;  c012b247 <getblk+8f/124>
>   13:   74 00                     je     15 <_EIP+0x15> c012b249
> <getblk+91/124>
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000008
> *pde = 00000000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
