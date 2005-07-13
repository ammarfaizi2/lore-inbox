Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVGMEzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVGMEzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 00:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVGMEzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 00:55:25 -0400
Received: from web32011.mail.mud.yahoo.com ([68.142.207.108]:2921 "HELO
	web32011.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262571AbVGMEzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 00:55:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=V1yPtcmJlSw55WmK2RBrKip+rYEMV918MRxaWQwyXPtspcuMnfVYEw67QdstZx/VWCUuT/ZhRYaI38fCfexmjiffEHh9mwwTUkf90Pt+xKRDhg+8Vjbii2NwRsvLi7d5smUGfiBa/2Ac5SwM2vEKJonZTWvQ7DNaCjAk20IXTec=  ;
Message-ID: <20050713045522.99423.qmail@web32011.mail.mud.yahoo.com>
Date: Tue, 12 Jul 2005 21:55:22 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>, david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050712130119.A30358@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
[snip]
> It works for me on my platforms here, and everyone
> else on x86. I even had a situation where I had
> NR_UARTS set to 64 but only one registered... which 
> also worked fine with no extraneous kernel messages.

But seems not functional on PowerPC platform. I used
a MPC8241 which has a DURT inside to try the git tree
8250.c and got the following result:

u-boot=> run kt
Please enter 'kernel-test':uImage-26-13
TFTP from server 192.168.57.200; our IP address is
192.168.57.243
Filename 'uImage-26-13'.
Load address: 0x1200000
Loading: ###########################################
        
####################################################
done
Bytes transferred = 858760 (d1a88 hex)
## Booting image at 01200000 ...
   Image Name:   Linux-2.6.13-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    858696 Bytes = 838.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff950000 ...
   Image Name:   Ramdisk ttyS1
   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
   Data Size:    1478758 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Loading Ramdisk to 03dde000, end 03f47066 ... OK
Linux version 2.6.13-rc1 (root@sam.shu.org) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-5
......
Built 1 zonelists
Kernel command line: console=ttyS1,115200
root=/dev/ram0 rw ramdisk_size=200000
ip=192.168.57.243:192.168.57.200:::8241:eth1
OpenPIC Version 1.2 (1 CPUs and 7 IRQ sources) at 
fdf40000
OpenPIC timer frequency is 100.000000 MHz
PID hash table entries: 512 (order: 9, 8192 bytes)
time_init: decrementer frequency = 25.000000 MHz
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 61268k available (1548k kernel code, 388k
data, 104k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
Freeing initrd memory: 1444k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of device
0000:00:00.0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 5) is a 16550A
ttyS1 at MMIO 0x0 (irq = 6) is a 16550A
serial8250 serial8250.0: unable to register port at
index 0 (IO0 MEMfdf04500 IRQ25): -22
serial8250 serial8250.0: unable to register port at
index 1 (IO0 MEMfdf04600 IRQ26): -22
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 200000K
size 1024 blocksize
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
......
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Device `eth0' not found.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 104k init
serial console detected.  Disabling virtual terminals.
### Application running ...

BusyBox v0.60.1 (2002.10.24-04:52+0000) Built-in 
shell (msh)
Enter 'help' for a list of built-in commands.

# cat /proc/interrupts
           CPU0
  6:         39   OpenPIC   Level     serial
BAD:          3

The whining is a little bit different from david's.
ttyS1 conosle was a workable one but ttyS1 didn't 
register right??? After applied David's patch, it 
became normal as before like 2.6.12-rc2 did. 

So my puzzle comes to know why ttyS1 cannot register
right even it works well.

TTA,

Sam

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
