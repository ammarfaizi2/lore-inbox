Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJIS7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJIS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUJIS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:59:25 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:28618 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S267303AbUJIS7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:59:05 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A647244@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc4  boot "Kernel panic: Attempted to kill init!" as
	 mounting on NFS (older) version 2 (on Red Hat File Server)  
Date: Sat, 9 Oct 2004 14:59:03 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


		Hi,

		 I am guessing that the kernel panic (see below) is caused
by NFS version incompatibility.
      I (think that I) prooved it by being able to "manually" mount by
specifying NFS version 2 after booting with RAMDISK -
		see that part of my email (some errors were thrown but the
mount was completed).

		 Should the kernel be configured to 
		allow to NFS mount root file system onto the NFS server,
which runs version 2 ? 

      I do not see the kernel option to configure NFS version 2 ...
      Here is what I have:
 
      CONFIG_NFS_FS=y
      # CONFIG_NFS_V3 is not set
      # CONFIG_NFS_V4 is not set
      # CONFIG_NFS_DIRECTIO is not set
      # CONFIG_NFSD is not set
      CONFIG_ROOT_NFS=y
      CONFIG_LOCKD=y

      Or is it a bug ? 
> 	 
		Thanks,
		Alex 
> 		 -----Original Message-----
> 		From: 	Povolotsky, Alexander  
> 		Sent:	Tuesday, September 28, 2004 4:21 PM
> 		To:	'linux-kernel@vger.kernel.org'
> 		Subject:	 Linux 2.6.8-rc4 "Kernel panic: Attempted to
> kill init!" - after replacing /fadsroot on the Linux NFSserver with the
> one from Arabella cdrom
> 
> 		Hi,
> 
> 		I have built (cross-compiled for ppc 82xx) Linux 2.6.8-rc4
> kernel and am trying to boot it on PQ2FADS-VR. 
> 
> 		I am getting: boot time  "Kernel panic: Attempted to kill
> init!"  on the remote Linux NFS server with 
		 Red Hat Linux release 9 (Shrike) Kernel 2.4.20-28.9 on an
i686, which runs "older" NFS version (version 2).


> 		Thanks,
> 		Best Regards,
> 		Povolotsky, Alexander
> 		*****************************  
> 		=> printenv
> 		bootdelay=5
> 		bootcmd=bootm 200000
> 		ethaddr=08:00:17:00:00:03
> 		serverip=192.168.0.3
> 		ipaddr=192.168.0.5
> 		baudrate=9600
> 		bootargs=root=/dev/nfs rw nfsroot=192.168.0.4:/fadsroot
> 		stdin=serial
> 		stdout=serial
> 		stderr=serial
> 
> 		Environment size: 210/262140 bytes
> 		=> tftpboot 200000 uimage
> 		Using FCC2 ETHERNET device
> 		TFTP from server 192.168.0.3; our IP address is 192.168.0.5
> 		Filename 'uimage'.
> 		Load address: 0x200000
> 		Loading:
> #################################################################
> 	
> #################################################################
> 		         #######################################
> 		done
> 		Bytes transferred = 864364 (d306c hex)
> 		=> bootm 200000
> 		## Booting image at 00200000 ...
> 		   Image Name:   Linux-2.6.8-rc4
> 		   Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
> 		   Data Size:    864300 Bytes = 844 kB
> 		   Load Address: 00000000
> 		   Entry Point:  00000000
> 		   Verifying Checksum ... OK
> 		   Uncompressing Kernel Image ... OK
> 		Linux version 2.6.8-rc4 (apovolot@USPITLAD104868) (gcc
> version 3.3.2) #5 Mon Aug
> 		 16 08:49:38 EDT 2004
> 		PQ2 ADS Port
> 		Built 1 zonelists
> 		Kernel command line: root=/dev/nfs rw
> nfsroot=192.168.0.4:/fadsroot nobats ip=19
> 		2.168.0.5
> 		PID hash table entries: 256 (order 8: 2048 bytes)
> 		Warning: real time clock seems stuck!
> 		Dentry cache hash table entries: 8192 (order: 3, 32768
> bytes)
> 		Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> 		Memory: 30432k available (1348k kernel code, 324k data, 272k
> init, 0k highmem)
> 		Calibrating delay loop... 131.07 BogoMIPS
> 		Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> 		NET: Registered protocol family 16
> 		PCI: Probing PCI hardware
> 		Generic RTC Driver v1.07
> 		Serial: CPM driver $Revision: 0.01 $
> 		ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
> 		RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
> blocksize
> 		loop: loaded (max 8 devices)
> 		eth0: FCC ENET Version 0.3, 08:00:17:40:00:03
> 		NET: Registered protocol family 2
> 		IP: routing cache hash table of 512 buckets, 4Kbytes
> 		TCP: Hash tables configured (established 2048 bind 4096)
> 		NET: Registered protocol family 1
> 		NET: Registered protocol family 17
> 		IP-Config: Guessing netmask 255.255.255.0
> 		IP-Config: Complete:
> 		      device=eth0, addr=192.168.0.5, mask=255.255.255.0,
> gw=255.255.255.255,
> 		     host=192.168.0.5, domain=, nis-domain=(none),
> 		     bootserver=255.255.255.255, rootserver=192.168.0.4,
> rootpath=
> 		Looking up port of RPC 100003/2 on 192.168.0.4
> 		Looking up port of RPC 100005/1 on 192.168.0.4
> 		VFS: Mounted root (nfs filesystem).
> 		Freeing unused kernel memory: 272k init
> 		Kernel panic: Attempted to kill init!
> 		 <0>Rebooting in 180 seconds..
> 
			*******
		To work around my original problem (see above) ,
		I am booting with ramdisk as root filesystem server and then
trying to manually mount the /fadsroot exported on the 
		above described Linux NFS server - I am getting errors ( but
mounting still works) ...

		Could anyone on this list determine (guess) what is the
reason for errors (see below) ?

		Thanks,
		Alex

		=> printenv
		bootdelay=5
		bootcmd=bootm 200000
		ethaddr=08:00:17:00:00:03
		serverip=192.168.0.3
		ipaddr=192.168.0.5
		baudrate=9600
		bootargs=root=/dev/nfs rw nfsroot=192.168.0.4:/fadsroot
		stdin=serial
		stdout=serial
		stderr=serial

		Environment size: 210/262140 bytes
		=> setenv bootargs root=/dev/ram rw
ip=192.168.0.5:255.255.255.0
		=> saveenv
		Saving Environment to Flash...
		.
		Un-Protected 1 sectors
		Erasing Flash...
		. done
		Erased 1 sectors
		Writing to Flash... done
		.
		Protected 1 sectors
		=> tftpboot 200000 uimage
		Using FCC2 ETHERNET device
		TFTP from server 192.168.0.3; our IP address is 192.168.0.5
		Filename 'uimage'.
		Load address: 0x200000
		Loading:
#################################################################
	
#################################################################
		         #######################################
		done
		Bytes transferred = 864364 (d306c hex)
		=> bootm 200000 FF800000
		## Booting image at 00200000 ...
		   Image Name:   Linux-2.6.8-rc4
		   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
		   Data Size:    864300 Bytes = 844 kB
		   Load Address: 00000000
		   Entry Point:  00000000
		   Verifying Checksum ... OK
		   Uncompressing Kernel Image ... OK
		## Loading RAMDisk Image at ff800000 ...
		   Image Name:   Simple Embedded Linux Framework
		   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
		   Data Size:    1400198 Bytes =  1.3 MB
		   Load Address: 00000000
		   Entry Point:  00000000
		   Verifying Checksum ... OK
		   Loading Ramdisk to 01a37000, end 01b8cd86 ... OK
		Linux version 2.6.8-rc4 (apovolot@USPITLAD104868) (gcc
version 3.3.2) #5 Mon Aug
		 16 08:49:38 EDT 2004
		PQ2 ADS Port
		Built 1 zonelists
		Kernel command line: root=/dev/ram rw
ip=192.168.0.5:255.255.255.0 nobats ip=192
		.168.0.5
		PID hash table entries: 256 (order 8: 2048 bytes)
		Warning: real time clock seems stuck!
		Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)
		Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
		Memory: 29064k available (1348k kernel code, 324k data, 272k
init, 0k highmem)
		Calibrating delay loop... 131.07 BogoMIPS
		Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
		checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd
		Freeing initrd memory: 1367k freed
		NET: Registered protocol family 16
		PCI: Probing PCI hardware
		Generic RTC Driver v1.07
		Serial: CPM driver $Revision: 0.01 $
		ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
		RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
blocksize
		loop: loaded (max 8 devices)
		eth0: FCC ENET Version 0.3, 08:00:17:40:00:03
		NET: Registered protocol family 2
		IP: routing cache hash table of 512 buckets, 4Kbytes
		TCP: Hash tables configured (established 2048 bind 4096)
		NET: Registered protocol family 1
		NET: Registered protocol family 17
		IP-Config: Guessing netmask 255.255.255.0
		IP-Config: Complete:
		      device=eth0, addr=192.168.0.5, mask=255.255.255.0,
gw=255.255.255.255,
		     host=192.168.0.5, domain=, nis-domain=(none),
		     bootserver=255.255.255.0, rootserver=255.255.255.0,
rootpath=
		RAMDISK: Compressed image found at block 0
		VFS: Mounted root (ext2 filesystem).
		Freeing unused kernel memory: 272k init
		serial console detected.  Disabling virtual terminals.


		BusyBox v0.60.1 (2002.10.24-02:29+0000) Built-in shell (msh)
		Enter 'help' for a list of built-in commands.

		# ### Application running ...

		# mount -o mountvers=2 192.168.0.4:/fadsroot /tmp
		nfs warning: mount version older than kernel

		portmap: server localhost not responding, timed out
		RPC: failed to contact portmap (errno -5).

		portmap: server localhost not responding, timed out
		RPC: failed to contact portmap (errno -5).
		lockd_up: makesock failed, error=-5
		### Application running ...
		portmap: server localhost not responding, timed out
		RPC: failed to contact portmap (errno -5).
		#
		#
		# cd tmp
		# ls
		XXX              gdbserver        mnt              sbin
		bin              hello            ncurses-5.4      sys
		boot             hello.c          opt              tmp
		cardmgr          home             pciutils-2.1.10  ttyp0
		cdrom            initrd           proc             usr
		dev              lib              ptyp0            var
		etc              lmbench-3.0-a4   root
		floppy           main.elf         runin
		#
> 		 
> 			 
> 
