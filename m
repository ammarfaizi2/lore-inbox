Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJFVST>; Sun, 6 Oct 2002 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJFVSS>; Sun, 6 Oct 2002 17:18:18 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:60566
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262198AbSJFVSQ>; Sun, 6 Oct 2002 17:18:16 -0400
Date: Sun, 6 Oct 2002 17:11:50 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Patrick Mochel <mochel@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: sleeping in illegal context: driverfs_remove_file
Message-ID: <Pine.LNX.4.44.0210061709260.20917-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,
	Don't know if you have this one;

The system is going down for reboot NOW!
flushing ide devices: hda hdc 
Shutting down devices         
hcd-pci.c: remove: 00:07.2, state 3
usb.c: USB disconnect on device 1  
Debug: sleeping function called from illegal context at 
/raid/build/source/linux-2.5.40/include/asm/semaphore.h:119
c2cf5de8 c018b454 c0421880 00000077 c145b850 c04aae60 c14b1dcc c024c993                                   
       c145b8f4 c043e1a3 c145b850 c14b1dc4 c14b1dc4 c0216908 c145b850 c04aae60 
       c14b1e2c bffffd98 c0186422 00000003 c14c2a00 c145b800 bffffd98 c0301ed9 
Call Trace:                                                                    
 [<c018b454>]driverfs_remove_file+0x24/0x90
 [<c024c993>]device_remove_file+0x23/0x40  
 [<c0216908>]pci_pool_destroy+0x1d8/0x200
 [<c0186422>]remove_proc_entry+0xa2/0x2b0
 [<c0301ed9>]hcd_buffer_destroy+0x19/0x30
 [<c0302ac8>]usb_hcd_pci_remove+0x68/0x160
 [<c0217484>]pci_device_remove+0x24/0x30  
 [<c024b273>]device_shutdown+0x193/0x1a3
 [<c0131740>]sys_reboot+0x150/0x260     
 [<c0146180>]free_block+0x60/0xb0  
 [<c0147513>]kmem_cache_free_one+0xe3/0x1f0
 [<c0146180>]free_block+0x60/0xb0          
 [<c01476cf>]__kmem_cache_free+0xaf/0xea
 [<c016f1cb>]dput+0x1b/0x170            
 [<c0158f7b>]__fput+0x12b/0x160
 [<c0156910>]filp_close+0xa0/0xc0
 [<c01569b5>]sys_close+0x85/0xc0 
 [<c01097a7>]syscall_call+0x7/0xb
                                 
psmouse.c: Lost synchronization, throwing 1 bytes away.
hcd.c: USB bus 1 deregistered                          
Restarting system.

gdb) list *driverfs_remove_file+0x24
0xc018b454 is in driverfs_remove_file 
(/raid/build/source/linux-2.5.40/include/asm/semaphore.h:119).
114     static inline void down(struct semaphore * sem)
115     {
116     #if WAITQUEUE_DEBUG
117             CHECK_MAGIC(sem->__magic);
118     #endif
119             might_sleep();
120             __asm__ __volatile__(
121                     "# atomic down operation\n\t"
122                     LOCK "decl %0\n\t"     /* --sem->count */
123                     "js 2f\n"

-- 
function.linuxpower.ca

