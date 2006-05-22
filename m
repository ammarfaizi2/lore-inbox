Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWEVDnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWEVDnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWEVDnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:43:00 -0400
Received: from palrel10.hp.com ([156.153.255.245]:8934 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751119AbWEVDm7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:42:59 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 22 May 2006 03:37:59.0069 (UTC) FILETIME=[1EE38CD0:01C67D51]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: [LINUX-KERNEL] Problem loading any custom driver
Date: Sun, 21 May 2006 20:42:59 -0700
Message-ID: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5C@cacexc05.americas.cpqcorp.net>
In-Reply-To: <1147994711.14102.63.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LINUX-KERNEL] Problem loading any custom driver
Thread-Index: AcZ60mKyEVM/x0qlSXK+pxdTfKNR/gAADnxQ
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I need a help on understanding and possible resolution on a problem I have while trying to load driver(s) to a server running Linux_IA32_RH_EL4_Update3 either AS or WS
I have a few (actually four) device drivers for different type of devices.
These drivers compile and run fine on any 2.4.x kernels for both desktops/workstations and servers.
The same drivers run fine on desktops/workstations and on slected servers, like IA64 Itanium servers, AMD64 servers, however I can't make it run on IA32 servers.
I've noticed one common among all IA32 servers drivers won't run. All of them have dual processors motherboard with only one processor installed.
The actual problem is: the first kernel function call from the driver (I'm running "insmod drivername" that calls driver_init function) cause kernel to panic.
I believe the problem is either with kernel configuration/setup or with development environment configuration/setup.
Any help/ideas are greatly appretiated. Below are part of a source code and related part of /var/log/messages. Please let me know if more information needed

Regards,
Vladimir Libershteyn, CISSP
Atalla Security Products
Hewlett-Packard
-----------------------------------------

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
int init_module(void)
#else     // LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
int __init atf_init_module(void)
#endif    // LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
{
        int result;
        int i;

        /* If already registered, fail */
        if (major != 0)
        {
                printk(KERN_ERR "%s: device interface already registered on major number %d\n", MAJOR_DEVICE_NAME, major);
                return -EBUSY;
        }

        /* Register major, and accept a dynamic number */
        result = register_chrdev(major, MAJOR_DEVICE_NAME, &atf_fops);   /* This cause the kernel panic , In other driver kmalloc causing the same kernel panic */
        if (result < 0)
        {
                printk(KERN_ERR "%s: failed to register on major number %d\n", MAJOR_DEVICE_NAME, major);
                return result;
        }

-----------------------------------------------------------------------------


May 18 15:24:20 localhost kernel: Unable to handle kernel paging request at virtual address 83535657
May 18 15:24:20 localhost kernel:  printing eip:
May 18 15:24:20 localhost kernel: c0150bf5
May 18 15:24:20 localhost kernel: *pde = 00000000
May 18 15:24:20 localhost kernel: Oops: 0000 [#1]
May 18 15:24:20 localhost kernel: Modules linked in: atflorin(U) vfat fat nls_utf8 parport_pc lp parport autofs4 i2c_dev i2c_core sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables button battery ac md5 ipv6 e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod cpqarray sd_mod scsi_mod
May 18 15:24:20 localhost kernel: CPU:    0
May 18 15:24:20 localhost kernel: EIP:    0060:[<c0150bf5>]    Not tainted VLI
May 18 15:24:20 localhost kernel: EFLAGS: 00210046   (2.6.9-34.EL)
May 18 15:24:20 localhost kernel: EIP is at kmem_cache_alloc+0x27/0x4c
May 18 15:24:20 localhost kernel: eax: c89c7000   ebx: 00000000   ecx: c0360640   edx: 83535657
May 18 15:24:20 localhost kernel: esi: 00200246   edi: c89c7000   ebp: c494c000   esp: c494cf44
May 18 15:24:20 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 18 15:24:20 localhost kernel: Process insmod (pid: 3429, threadinfo=c494c000 task=c75eb970)
May 18 15:24:20 localhost kernel: Stack: c0360640 c88d0800 c0360600 c89c7016 c7ffbf60 000000d0 00000000 00000000
May 18 15:24:20 localhost kernel:        0000000b 00000000 00000013 00000000 0000000e 00000000 00000021 00000020
May 18 15:24:20 localhost kernel:        00000022 c89c5b90 c89c3575 c89bd000 00200246 c88d0800 c0360640 c88d0800
May 18 15:24:20 localhost kernel: Call Trace:
May 18 15:24:20 localhost kernel:  [<c89c7016>] atflorin_init_module+0x16/0x1bb [atflorin]
May 18 15:24:20 localhost kernel:  [<c013de72>] sys_init_module+0xe9/0x1d0
May 18 15:24:20 localhost kernel:  [<c0311443>] syscall_call+0x7/0xb
May 18 15:24:20 localhost kernel: Code: 5a 5b 09 00 57 f6 c2 10 89 c7 56 53 89 d3 74 16 31 c9 ba 0f 08 00 00 b8 cd 27 32 c0 e8 d5 d5 fc ff e8 ec ef 1b 00 9c 5e fa 8b 17 <8b> 02 85 c0 74 10 c7 42 0c 01 00 00 00 48 89 02 8b 44 82 10 eb
May 18 15:24:20 localhost kernel:  <0>Fatal exception: panic in 5 seconds

----------------------------------------------------------------------- 

