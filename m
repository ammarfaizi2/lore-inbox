Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUHNBIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUHNBIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 21:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUHNBIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 21:08:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4839 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267850AbUHNBHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 21:07:18 -0400
Message-ID: <411D65B4.4030208@pobox.com>
Date: Fri, 13 Aug 2004 21:07:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.8-rc4-bk] NFS oops on x86-64
Content-Type: multipart/mixed;
 boundary="------------040200000304070506080405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040200000304070506080405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached...   oops in BK-latest NFS client on x86-64.  The oops is 
100% reproducible, and occurs immediately (as soon as I access any 
portion of the mounted NFS filesystem; the mount itself succeeds).

(ksymoops output, lspci, dmesg, and .config)


--------------040200000304070506080405
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Aug 13 20:56:20 bum kernel: Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP: 
Aug 13 20:56:20 bum kernel: <ffffffff801ba40d>{nfs3_request_init+13}
Aug 13 20:56:20 bum kernel: PML4 1f4ed067 PGD 1fb8b067 PMD 0 
Aug 13 20:56:20 bum kernel: Oops: 0002 [1] 
Aug 13 20:56:20 bum kernel: CPU 0 
Aug 13 20:56:20 bum kernel: Modules linked in: r8169 ext2 battery
Aug 13 20:56:20 bum kernel: Pid: 1411, comm: sshd Not tainted 2.6.8-rc4
Aug 13 20:56:20 bum kernel: RIP: 0010:[<ffffffff801ba40d>] <ffffffff801ba40d>{nfs3_request_init+13}
Aug 13 20:56:20 bum kernel: RSP: 0018:000001001e6e7988  EFLAGS: 00010246
Aug 13 20:56:20 bum kernel: RAX: 0000000000000000 RBX: 000001001d56fbc0 RCX: 0000000000000000
Aug 13 20:56:20 bum kernel: RDX: 0000000000000010 RSI: 000001001ed596c0 RDI: 000001001eb62890
Aug 13 20:56:20 bum kernel: RBP: 000001000166a638 R08: 00000100019fb000 R09: 00000100019fb010
Aug 13 20:56:20 bum kernel: R10: 00000100019f1b20 R11: 00000100019f1b30 R12: 000001000198aa00
Aug 13 20:56:20 bum kernel: R13: 0000000000000000 R14: 0000000000000265 R15: 000001001eb62890
Aug 13 20:56:21 bum kernel: FS:  0000002a955752c0(0000) GS:ffffffff80432800(0000) knlGS:0000000000000000
Aug 13 20:56:21 bum kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug 13 20:56:21 bum kernel: CR2: 0000000000000028 CR3: 0000000000101000 CR4: 00000000000006e0
Aug 13 20:56:21 bum kernel: Process sshd (pid: 1411, threadinfo 000001001e6e6000, task 000001001dbbe9c0)
Aug 13 20:56:21 bum kernel: Stack: 000001001d56fbc0 ffffffff801b2f61 0000000000000004 000001001ed596c0 
Aug 13 20:56:21 bum kernel:        0000000000000001 0000000000000000 000001001eb62890 000001000166a638 
Aug 13 20:56:21 bum kernel:        000001001eb62890 0000000000000265 
Aug 13 20:56:21 bum kernel: Call Trace:<ffffffff801b2f61>{nfs_create_request+225} <ffffffff801b5a71>{readpage_async_filler+129} 
Aug 13 20:56:21 bum kernel:        <ffffffff8014f38a>{read_cache_pages+202} <ffffffff801b59f0>{readpage_async_filler+0} 
Aug 13 20:56:21 bum kernel:        <ffffffff802f35d3>{rpc_release_client+67} <ffffffff802f8466>{rpc_release_task+310} 
Aug 13 20:56:21 bum kernel:        <ffffffff802f7e41>{__rpc_execute+945} <ffffffff8012e290>{autoremove_wake_function+0} 
Aug 13 20:56:21 bum kernel:        <ffffffff801b5bb5>{nfs_readpages+133} <ffffffff8014f48e>{read_pages+62} 
Aug 13 20:56:21 bum kernel:        <ffffffff8014c7cf>{buffered_rmqueue+335} <ffffffff8014cb11>{__alloc_pages+817} 
Aug 13 20:56:21 bum kernel:        <ffffffff8014f849>{do_page_cache_readahead+281} <ffffffff8014f9ee>{page_cache_readahead+366} 
Aug 13 20:56:21 bum kernel:        <ffffffff801490b7>{do_generic_mapping_read+279} <ffffffff80149450>{file_read_actor+0} 
Aug 13 20:56:21 bum kernel:        <ffffffff801496e7>{__generic_file_aio_read+407} <ffffffff80149741>{generic_file_aio_read+49} 
Aug 13 20:56:21 bum kernel:        <ffffffff801aeb72>{nfs_file_read+194} <ffffffff8016382d>{do_sync_read+125} 
Aug 13 20:56:21 bum kernel:        <ffffffff801586f2>{__vma_link+66} <ffffffff801593be>{do_mmap_pgoff+1326} 
Aug 13 20:56:21 bum kernel:        <ffffffff80163937>{vfs_read+199} <ffffffff80163bb3>{sys_read+83} 
Aug 13 20:56:21 bum kernel:        <ffffffff8011062a>{system_call+126} 
Aug 13 20:56:21 bum kernel: 
Aug 13 20:56:21 bum kernel: Code: ff 40 28 48 89 43 30 5b c3 66 66 66 90 66 66 90 66 66 90 48 
Aug 13 20:56:21 bum kernel: RIP <ffffffff801ba40d>{nfs3_request_init+13} RSP <000001001e6e7988>

--------------040200000304070506080405
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378 (SATA150 TX) (rev 02)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4400] (rev a2)

--------------040200000304070506080405
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

=system_u:object_r:file_t tclass=fifo_file
audit(1092445086.705:0): avc:  denied  { read write } for  pid=1 exe=/sbin/init name=initctl dev=sda2 ino=72393 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=fifo_file
audit(1092445087.243:0): avc:  denied  { getattr } for  pid=329 exe=/sbin/initlog path=/dev/log dev=sda2 ino=64975 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=sock_file
audit(1092445087.244:0): avc:  denied  { write } for  pid=329 exe=/sbin/initlog name=log dev=sda2 ino=64975 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=sock_file
audit(1092445087.269:0): avc:  denied  { syslog_console } for  pid=497 exe=/bin/dmesg scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=system
audit(1092445087.346:0): avc:  denied  { search } for  pid=501 exe=/sbin/sysctl name=net dev=proc ino=4026531940 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_net_t tclass=dir
audit(1092445087.346:0): avc:  denied  { write } for  pid=501 exe=/sbin/sysctl name=ip_forward dev=proc ino=4026531963 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_net_t tclass=file
audit(1092445087.346:0): avc:  denied  { getattr } for  pid=501 exe=/sbin/sysctl path=/proc/sys/net/ipv4/ip_forward dev=proc ino=4026531963 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_net_t tclass=file
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
audit(1092445089.900:0): avc:  denied  { getattr } for  pid=328 exe=/bin/bash path=/initrd/dev/root dev=ram0 ino=48 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=blk_file
audit(1092445090.017:0): avc:  denied  { read } for  pid=533 exe=/sbin/fsck name=root dev=ram0 ino=48 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=blk_file
audit(1092445090.017:0): avc:  denied  { ioctl } for  pid=533 exe=/sbin/fsck path=/initrd/dev/root dev=ram0 ino=48 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=blk_file
audit(1092445090.072:0): avc:  denied  { getattr } for  pid=534 exe=/sbin/fsck.ext2 path=/sys dev=sysfs ino=1 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysfs_t tclass=dir
audit(1092445090.072:0): avc:  denied  { write } for  pid=534 exe=/sbin/fsck.ext2 name=root dev=ram0 ino=48 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=blk_file
EXT3 FS on sda2, internal journal
audit(1092445109.505:0): avc:  denied  { unlink } for  pid=665 exe=/sbin/minilogd name=log dev=sda2 ino=64975 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=sock_file
audit(1092445109.505:0): avc:  denied  { create } for  pid=665 exe=/sbin/minilogd name=log scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=sock_file
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
audit(1092445109.615:0): avc:  denied  { create } for  pid=675 exe=/sbin/nash name=control scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=chr_file
audit(1092445109.639:0): avc:  denied  { check_context } for  pid=676 exe=/sbin/restorecon scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:security_t tclass=security
audit(1092445109.687:0): avc:  denied  { relabelfrom } for  pid=676 exe=/sbin/restorecon name=control dev=sda2 ino=81127 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=chr_file
audit(1092445109.687:0): avc:  denied  { relabelto } for  pid=676 exe=/sbin/restorecon name=control dev=sda2 ino=81127 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:lvm_control_t tclass=chr_file
audit(1092445109.688:0): avc:  denied  { getattr } for  pid=328 exe=/bin/bash path=/dev/mapper/control dev=sda2 ino=81127 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:lvm_control_t tclass=chr_file
audit(1092445109.863:0): avc:  denied  { getattr } for  pid=677 exe=/sbin/lvm.static path=/dev/pts dev=devpts ino=1 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=dir
audit(1092445109.863:0): avc:  denied  { read } for  pid=677 exe=/sbin/lvm.static dev=devpts ino=1 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=dir
audit(1092445109.997:0): avc:  denied  { read } for  pid=677 exe=/sbin/lvm.static name=block dev=sysfs ino=313 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysfs_t tclass=dir
audit(1092445109.997:0): avc:  denied  { read } for  pid=677 exe=/sbin/lvm.static name=dev dev=sysfs ino=1093 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysfs_t tclass=file
audit(1092445109.997:0): avc:  denied  { getattr } for  pid=677 exe=/sbin/lvm.static path=/sys/block/sdb/sdb1/dev dev=sysfs ino=1093 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysfs_t tclass=file
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1
audit(1092445110.299:0): avc:  denied  { relabelfrom } for  pid=680 exe=/sbin/restorecon name=mtab dev=sda2 ino=276017 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=file
audit(1092445110.299:0): avc:  denied  { relabelto } for  pid=680 exe=/sbin/restorecon name=mtab dev=sda2 ino=276017 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_runtime_t tclass=file
audit(1092445110.373:0): avc:  denied  { getattr } for  pid=328 exe=/bin/bash path=/proc/sys/kernel/modprobe dev=proc ino=4026531893 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_modprobe_t tclass=file
audit(1092445110.374:0): avc:  denied  { write } for  pid=688 exe=/sbin/sysctl name=modprobe dev=proc ino=4026531893 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_modprobe_t tclass=file
audit(1092445110.374:0): avc:  denied  { write } for  pid=689 exe=/sbin/sysctl name=hotplug dev=proc ino=4026531894 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_hotplug_t tclass=file
audit(1092445110.374:0): avc:  denied  { getattr } for  pid=689 exe=/sbin/sysctl path=/proc/sys/kernel/hotplug dev=proc ino=4026531894 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_hotplug_t tclass=file
SELinux: initialized (dev sda1, type ext2), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda5, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1092445252.524:0): avc:  denied  { setattr } for  pid=860 exe=/sbin/pam_console_apply name=dsp dev=sda2 ino=65008 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=chr_file
audit(1092445253.002:0): avc:  denied  { relabelfrom } for  pid=870 exe=/sbin/restorecon name=.ICE-unix dev=sda2 ino=259587 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=dir
audit(1092445253.002:0): avc:  denied  { relabelto } for  pid=870 exe=/sbin/restorecon name=.ICE-unix dev=sda2 ino=259587 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:xdm_xserver_tmp_t tclass=dir
audit(1092445253.427:0): avc:  denied  { syslog_read } for  pid=879 exe=/bin/dmesg scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=system
audit(1092445255.189:0): avc:  denied  { create } for  pid=929 exe=/sbin/iptables scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=rawip_socket
audit(1092445255.189:0): avc:  denied  { read } for  pid=929 exe=/sbin/iptables name=modprobe dev=proc ino=4026531893 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_modprobe_t tclass=file
ip_tables: (C) 2000-2002 Netfilter core team
audit(1092445255.335:0): avc:  denied  { create } for  pid=937 exe=/sbin/arping scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=packet_socket
audit(1092445255.335:0): avc:  denied  { ioctl } for  pid=937 exe=/sbin/arping path=socket:[7155] dev=sockfs ino=7155 scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=packet_socket
audit(1092445255.481:0): avc:  denied  { read } for  pid=969 exe=/sbin/sysctl name=hotplug dev=proc ino=4026531894 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_hotplug_t tclass=file
r8169 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
divert: allocating divert_blk for eth0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xffffff0000198f00, 00:0c:76:51:67:7c, IRQ 16
eth0: Auto-negotiation Enabled.
eth0: 1000Mbps Full-duplex operation.
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
audit(1092445261.319:0): avc:  denied  { setattr } for  pid=1166 exe=/sbin/syslogd name=log dev=sda2 ino=64975 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t tclass=sock_file
audit(1092445261.347:0): avc:  denied  { read } for  pid=1170 exe=/sbin/klogd name=kmsg dev=proc ino=4026531850 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:proc_kmsg_t tclass=file
audit(1092445261.347:0): avc:  denied  { syslog_mod } for  pid=1170 exe=/sbin/klogd scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=system
audit(1092445261.646:0): avc:  denied  { name_bind } for  pid=1189 exe=/sbin/portmap scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:portmap_port_t tclass=udp_socket
audit(1092445261.663:0): avc:  denied  { name_bind } for  pid=1189 exe=/sbin/portmap scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:portmap_port_t tclass=tcp_socket
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
audit(1092445264.446:0): avc:  denied  { search } for  pid=1269 exe=/usr/sbin/rpc.idmapd name=rpc dev=proc ino=4026532354 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:sysctl_rpc_t tclass=dir
audit(1092445264.446:0): avc:  denied  { search } for  pid=1269 exe=/usr/sbin/rpc.idmapd dev=rpc_pipefs ino=7756 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:rpc_pipefs_t tclass=dir
audit(1092445264.446:0): avc:  denied  { read } for  pid=1269 exe=/usr/sbin/rpc.idmapd name=nfs dev=rpc_pipefs ino=4 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:rpc_pipefs_t tclass=dir
audit(1092445264.446:0): avc:  denied  { getattr } for  pid=1269 exe=/usr/sbin/rpc.idmapd path=/var/lib/nfs/rpc_pipefs/nfs dev=rpc_pipefs ino=4 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:rpc_pipefs_t tclass=dir
SELinux: initialized (dev 0:f, type nfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff804614a0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
audit(1092445268.647:0): avc:  denied  { name_bind } for  pid=1339 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:ssh_port_t tclass=tcp_socket
audit(1092445268.803:0): avc:  denied  { name_bind } for  pid=1363 exe=/usr/sbin/ntpdate scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:ntp_port_t tclass=udp_socket
eth0: no IPv6 routers present
audit(1092445278.919:0): avc:  denied  { search } for  pid=1629 exe=/usr/sbin/sshd dev=0:f ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:nfs_t tclass=dir
audit(1092445278.922:0): avc:  denied  { getattr } for  pid=1629 exe=/usr/sbin/sshd path=/g/g/.ssh/authorized_keys dev=0:f ino=245778 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:nfs_t tclass=file
audit(1092445278.922:0): avc:  denied  { read } for  pid=1629 exe=/usr/sbin/sshd name=authorized_keys dev=0:f ino=245778 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:nfs_t tclass=file
audit(1092445278.923:0): avc:  denied  { getattr } for  pid=1629 exe=/usr/sbin/sshd path=/g dev=0:f ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:nfs_t tclass=dir
audit(1092445279.058:0): avc:  denied  { search } for  pid=1629 exe=/usr/sbin/sshd dev=devpts ino=1 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=dir
audit(1092445279.059:0): avc:  denied  { getattr } for  pid=1629 exe=/usr/sbin/sshd path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=chr_file
audit(1092445279.059:0): avc:  denied  { read write } for  pid=1629 exe=/usr/sbin/sshd name=0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=chr_file
audit(1092445279.059:0): avc:  denied  { ioctl } for  pid=1629 exe=/usr/sbin/sshd path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=chr_file
audit(1092445279.059:0): avc:  denied  { setattr } for  pid=1629 exe=/usr/sbin/sshd name=0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=chr_file
audit(1092445279.059:0): avc:  denied  { name_bind } for  pid=1631 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:xserver_port_t tclass=tcp_socket
audit(1092445279.060:0): avc:  denied  { compute_user } for  pid=1631 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:security_t tclass=security
audit(1092445279.060:0): avc:  denied  { compute_av } for  pid=1631 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:security_t tclass=security
audit(1092445279.092:0): avc:  denied  { compute_relabel } for  pid=1631 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:security_t tclass=security
audit(1092445279.092:0): avc:  denied  { relabelfrom } for  pid=1631 exe=/usr/sbin/sshd name=0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devpts_t tclass=chr_file
audit(1092445279.092:0): avc:  denied  { relabelto } for  pid=1631 exe=/usr/sbin/sshd name=0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=user_u:object_r:devpts_t tclass=chr_file
audit(1092445279.092:0): avc:  denied  { write } for  pid=1631 exe=/usr/sbin/sshd name=exec dev=proc ino=106889237 scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=file
audit(1092445279.092:0): avc:  denied  { setexec } for  pid=1631 exe=/usr/sbin/sshd scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:kernel_t tclass=process
audit(1092445279.097:0): avc:  denied  { getattr } for  pid=1631 exe=/usr/sbin/sshd path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=user_u:object_r:devpts_t tclass=chr_file
audit(1092445279.097:0): avc:  denied  { ioctl } for  pid=1632 exe=/usr/sbin/sshd path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=user_u:object_r:devpts_t tclass=chr_file
audit(1092445279.097:0): avc:  denied  { read write } for  pid=1632 exe=/usr/sbin/sshd name=0 dev=devpts ino=2 scontext=system_u:system_r:kernel_t tcontext=user_u:object_r:devpts_t tclass=chr_file
audit(1092445279.101:0): avc:  denied  { transition } for  pid=1633 exe=/usr/sbin/sshd path=/bin/bash dev=sda2 ino=503029 scontext=system_u:system_r:kernel_t tcontext=user_u:sysadm_r:sysadm_t tclass=process
audit(1092445279.104:0): avc:  denied  { siginh } for  pid=1633 exe=/bin/bash scontext=system_u:system_r:kernel_t tcontext=user_u:sysadm_r:sysadm_t tclass=process
audit(1092445279.104:0): avc:  denied  { rlimitinh } for  pid=1633 exe=/bin/bash scontext=system_u:system_r:kernel_t tcontext=user_u:sysadm_r:sysadm_t tclass=process
audit(1092445279.104:0): avc:  denied  { noatsecure } for  pid=1633 exe=/bin/bash scontext=system_u:system_r:kernel_t tcontext=user_u:sysadm_r:sysadm_t tclass=process

--------------040200000304070506080405
Content-Type: text/plain;
 name="config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.txt"

#
# Automatically generated make config: don't edit
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=16
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
CONFIG_SCSI_SATA_NV=m
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_SATA_VITESSE=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
CONFIG_MIDI_VIA82CXXX=y
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_DYNAMIC_MINORS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_HP8200e is not set
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# Firmware Drivers
#
CONFIG_EDD=y

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_CHECKING is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

--------------040200000304070506080405--
