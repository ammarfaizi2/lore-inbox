Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTIPOEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTIPOEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:04:53 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:40206 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261929AbTIPOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:04:45 -0400
Date: Tue, 16 Sep 2003 11:04:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Sebastian Piecha <spi@gmxpro.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: oops in 2.4.23pre1, Promise-ide, samba
In-Reply-To: <3F644006.22303.31C480A@localhost>
Message-ID: <Pine.LNX.4.44.0309161101150.1636-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Does the oops (panic) backtrace look the same on other kernels?

On Sun, 14 Sep 2003, Sebastian Piecha wrote:

> Hello, 
> 
> several times I got an OOPS. Here's a description of what has 
> happened. Any  help would be appreciated. Please CC me on all further 
> mail traffic.  
> 
> ###############################################################
> 
> 1) one line summary:
> When moving data (more than 4GB) from a Windows XP Client to a samba 
> share or checking data stored on the samba share (Powerquest 
> DriveImage images, 56 files, each ~700MB of size, checking with the 
> Powerquest Image Explorer) the kernel panics with an OOPS. Linux  has 
> to be resetted hard. When accessing the data via NFS no OOPS is 
> occurring.
> 
> The error occured on kernel 2.4.20 with samba 2.2.7a and 2.2.8a. Now 
> I tried kernel 2.4.23pre1 with samba 2.2.8a and again the error 
> occurred.
> 
> I already posted the kernel 2.4.20 problem. The subjects were 
> "PROBLEM: Powerquest Drive Image let the kernel panic" and "PROBLEM: 
> kernel panic when accessing data via samba".

> 
> ###############################################################
> 
> 2) full description:
> 
> I'm using Samba to distribute some shares to Windows clients. One of 
> the shares is an Image-directory where I'm storing PQDI Images of 
> Windows clients. One of the created images is about 40GB of size and 
> is split up to 56  files each of same size. When verifying this image 
> from a Win XP client, PQDI  stops with an error (error 1811, "Could 
> not read from image file") and the Linux kernel panics. Verifying 
> this image from DOS (with MS network client) is done without any 
> error. Also verifying smaller images is done without any error. 
> Verifying this Image via NFS is also done without an error. Another 
> PQDI version (7.0) also reports an error and the Linux Kernel  
> panics. Copying more than 4 GB to the samba share also lets the 
> kernel panic with an OOPS. Copying data locally from the Linux 
> console is done without an error.
> 
> In the beginning I thought that the Promise controller is the source 
> of problem, now I'm not sure. Maybe it's samba or the combination of 
> samba and a Promise controller.
> 
> The share is lying in a directory on a Reiser filesystem: 
> 
> share Images 
> ReiserFS 
> LVM (on /dev/md0 only, 120GB) 
> RAID1 /dev/md0 (120GB) 
> /dev/hda1 + /dev/hde1 (one primary partition of 120GB on each drive)
> /dev/hda + /dev/hde (each 120GB) IDE UDMA133-controller 
> 
> As IDE-controller I first used a Promise FastTrak TX2000 (which 
> supports "hardware"-RAID). I tried the binary Promise-driver 
> (1.03.0.1) and the source  code-driver (1.02.0.25), both without 
> success. All time the OOPS occurred.  Then I replaced the controller 
> and both Samsung SP1203N-hard drives (each  120GB) against a Promise 
> UltraTrak 133 TX2 and two Maxtor drives  (6Y120P0, each 1 20GB) and 
> installed a Linux native software-RAID without  any Promise-driver. 
> But again the OOPS occurred. Of course I updated the Promise-firmware 
> to the latest level.  
> 
> To eliminate the RAID and LVM-drivers as the source of problem I 
> installed just a Reiser FS on one 120GB-primary partition on one of 
> both Maxtor disks  (after removing the drive from the RAID). But 
> again the Linux kernel panicked. Trying ext3 instead of reiserfs 
> didn't help. As I do not have enough space on my scsi-disks I can't 
> verify this big image from a scsi-disk.
> 
> Sometimes the Linux kernel panic occurs immediately some minutes 
> after starting the verify, sometimes it happens after reading half of 
> all image files. Samba doesn't report any error. I also tried a 
> different PCI-slot for the Promise- adapter without any success. Next 
> thing would be to try a different IDE-controller...
> 
> ###############################################################
> 
> 3) keywords:
> Suse Linux 8.20, kernel 2.4.23pre1, Promise Ultra 133 TX2, samba 
> 2.28a
> 
> ###############################################################
> 
> 4) /proc/version:
> Linux version 2.4.23pre1-usbtest (2.4.23pre1@USB-test.suse.de) (gcc 
> version 3.2.2) #1 Wed Aug 27 19:43:12 UTC 2003
> 
> ###############################################################
> 
> 5) OOPS-message:
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0219cd7>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: c40866a0   ebx: 00200000   ecx: c40866a0   edx: 00200000
> esi: cec57360   edi: fffffff9   ebp: 00000046   esp: c0303f2c
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c0303000)
> Stack: cec57360 c0219d6e cec57360 cec57360 cec57360 c0219dab cec57360 
> cec57360
>        c0219efc cec57360 cf49cb20 c021e173 cec57360 00000003 c032c568 
> c0120629
>        c032c568 00000006 0000000e c0303f98 d3e02e40 c010a091 c0106f40 
> c0302000
> Call Trace:    [<c0219d6e>] [<c0219dab>] [<c0219efc>] [<c021e173>] 
> [<c0120629>]
>   [<c010a091>] [<c0106f40>] [<c010c4e8>] [<c0106f40>] [<c0106f64>] 
> [<c0106fd2>]
>   [<c0105000>]
> Code: 8b 1b 8b 42 74 48 74 0a ff 4a 74 0f 94 c0 84 c0 74 07 52 e8
> 
> 
> >>EIP; c0219cd7 <skb_drop_fraglist+17/40>   <=====
> 
> >>eax; c40866a0 <_end+3cf81fc/14e64bbc>
> >>ecx; c40866a0 <_end+3cf81fc/14e64bbc>
> >>esi; cec57360 <_end+e8c8ebc/14e64bbc>
> >>esp; c0303f2c <init_task_union+1f2c/2000>
> 
> Trace; c0219d6e <skb_release_data+4e/80>
> Trace; c0219dab <kfree_skbmem+b/70>
> Trace; c0219efc <__kfree_skb+ec/150>
> Trace; c021e173 <net_tx_action+33/a0>
> Trace; c0120629 <do_softirq+99/a0>
> Trace; c010a091 <do_IRQ+a1/b0>
> Trace; c0106f40 <default_idle+0/30>
> Trace; c010c4e8 <call_do_IRQ+5/d>
> Trace; c0106f40 <default_idle+0/30>
> Trace; c0106f64 <default_idle+24/30>
> Trace; c0106fd2 <cpu_idle+42/60>
> Trace; c0105000 <_stext+0/0>
> 
> Code;  c0219cd7 <skb_drop_fraglist+17/40>
> 00000000 <_EIP>:
> Code;  c0219cd7 <skb_drop_fraglist+17/40>   <=====
>    0:   8b 1b                     mov    (%ebx),%ebx   <=====
> Code;  c0219cd9 <skb_drop_fraglist+19/40>
>    2:   8b 42 74                  mov    0x74(%edx),%eax
> Code;  c0219cdc <skb_drop_fraglist+1c/40>
>    5:   48                        dec    %eax
> Code;  c0219cdd <skb_drop_fraglist+1d/40>
>    6:   74 0a                     je     12 <_EIP+0x12>
> Code;  c0219cdf <skb_drop_fraglist+1f/40>
>    8:   ff 4a 74                  decl   0x74(%edx)
> Code;  c0219ce2 <skb_drop_fraglist+22/40>
>    b:   0f 94 c0                  sete   %al
> Code;  c0219ce5 <skb_drop_fraglist+25/40>
>    e:   84 c0                     test   %al,%al
> Code;  c0219ce7 <skb_drop_fraglist+27/40>
>   10:   74 07                     je     19 <_EIP+0x19>
> Code;  c0219ce9 <skb_drop_fraglist+29/40>
>   12:   52                        push   %edx
> Code;  c0219cea <skb_drop_fraglist+2a/40>
>   13:   e8 00 00 00 00            call   18 <_EIP+0x18>
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 

