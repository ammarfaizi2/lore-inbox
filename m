Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTIBQjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTIBQjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:39:24 -0400
Received: from mailhub2.uq.edu.au ([130.102.5.59]:17301 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S264023AbTIBQjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:39:05 -0400
Subject: [DEBUG] 2.6.0-test4 - sleeping function called from invalid context
From: Stuart Low <stuart@perlboy.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Serverpeak.com
Message-Id: <1062520736.2331.10.camel@poohbox.perlaholic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 02:38:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heya,

Compiled 2.6.0-test4 about 5 days ago. Dmesg has been popping up the
following:

- -snip- -
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c01426e5>] kmem_cache_alloc+0x65/0x70
 [<c0150ba1>] __get_vm_area+0x21/0x100
 [<c0150cb3>] get_vm_area+0x33/0x40
 [<c011ccd3>] __ioremap+0xb3/0x100
 [<c011cd49>] ioremap_nocache+0x29/0xc0
 [<e5be1e03>] os_map_kernel_space+0x56/0x5b [nvidia]
 [<e5bf43b7>] __nvsym00568+0x1f/0x2c [nvidia]
 [<e5bf64d6>] __nvsym00775+0x6e/0xe0 [nvidia]
 [<e5bf6566>] __nvsym00781+0x1e/0x190 [nvidia]
 [<c015fd71>] exact_lock+0x11/0x20
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015fd50>] exact_match+0x0/0x10
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c0142779>] __kmalloc+0x89/0x90
 [<e5be1643>] os_alloc_mem+0x53/0x82 [nvidia]
 [<e5bf44d4>] __nvsym00083+0x10/0x24 [nvidia]
 [<e5c9ccaf>] __nvsym03944+0x1af/0x2c0 [nvidia]
 [<e5d0451d>] __nvsym00780+0x11d/0x224 [nvidia]
 [<e5bf611c>] __nvsym00773+0x1c/0x5c [nvidia]
 [<e5bf6663>] __nvsym00781+0x11b/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015fd50>] exact_match+0x0/0x10
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
/dev/vmnet: open called by PID 2081 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 2080 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c01426e5>] kmem_cache_alloc+0x65/0x70
 [<c0150ba1>] __get_vm_area+0x21/0x100
 [<c0150cb3>] get_vm_area+0x33/0x40
 [<c011ccd3>] __ioremap+0xb3/0x100
 [<c011cd49>] ioremap_nocache+0x29/0xc0
 [<e5be1e03>] os_map_kernel_space+0x56/0x5b [nvidia]
 [<e5bf43b7>] __nvsym00568+0x1f/0x2c [nvidia]
 [<e5bf64d6>] __nvsym00775+0x6e/0xe0 [nvidia]
 [<e5bf6566>] __nvsym00781+0x1e/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c0142779>] __kmalloc+0x89/0x90
 [<e5be1643>] os_alloc_mem+0x53/0x82 [nvidia]
 [<e5bf44d4>] __nvsym00083+0x10/0x24 [nvidia]
 [<e5c9ccaf>] __nvsym03944+0x1af/0x2c0 [nvidia]
 [<e5d0451d>] __nvsym00780+0x11d/0x224 [nvidia]
 [<e5bf611c>] __nvsym00773+0x1c/0x5c [nvidia]
 [<e5bf6663>] __nvsym00781+0x11b/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Linux agpgart interface v0.100 (c) Dave Jones
0: NVRM: AGPGART: unable to retrieve symbol table
- -/snip- -

In addition to this, I've had some pretty scary crashes involving ext3.

It is something very similar to a bug reported in the 2.5.x series
kernels.

EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted
EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted
EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted

^^ Repeated at 1-second intervals.

I'd appreciate someone possibly explaining why this is happening, and,
even better, if it's fixable? Please CC me as I am not usually
subscribed to the Linux-Kernel mailing list.

Kind Regards,

Stuart Low

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Heya,

Compiled 2.6.0-test4 about 5 days ago. Dmesg has been popping up the
following:

- -snip- -
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c01426e5>] kmem_cache_alloc+0x65/0x70
 [<c0150ba1>] __get_vm_area+0x21/0x100
 [<c0150cb3>] get_vm_area+0x33/0x40
 [<c011ccd3>] __ioremap+0xb3/0x100
 [<c011cd49>] ioremap_nocache+0x29/0xc0
 [<e5be1e03>] os_map_kernel_space+0x56/0x5b [nvidia]
 [<e5bf43b7>] __nvsym00568+0x1f/0x2c [nvidia]
 [<e5bf64d6>] __nvsym00775+0x6e/0xe0 [nvidia]
 [<e5bf6566>] __nvsym00781+0x1e/0x190 [nvidia]
 [<c015fd71>] exact_lock+0x11/0x20
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015fd50>] exact_match+0x0/0x10
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c0142779>] __kmalloc+0x89/0x90
 [<e5be1643>] os_alloc_mem+0x53/0x82 [nvidia]
 [<e5bf44d4>] __nvsym00083+0x10/0x24 [nvidia]
 [<e5c9ccaf>] __nvsym03944+0x1af/0x2c0 [nvidia]
 [<e5d0451d>] __nvsym00780+0x11d/0x224 [nvidia]
 [<e5bf611c>] __nvsym00773+0x1c/0x5c [nvidia]
 [<e5bf6663>] __nvsym00781+0x11b/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015fd50>] exact_match+0x0/0x10
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
/dev/vmnet: open called by PID 2081 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 2080 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c01426e5>] kmem_cache_alloc+0x65/0x70
 [<c0150ba1>] __get_vm_area+0x21/0x100
 [<c0150cb3>] get_vm_area+0x33/0x40
 [<c011ccd3>] __ioremap+0xb3/0x100
 [<c011cd49>] ioremap_nocache+0x29/0xc0
 [<e5be1e03>] os_map_kernel_space+0x56/0x5b [nvidia]
 [<e5bf43b7>] __nvsym00568+0x1f/0x2c [nvidia]
 [<e5bf64d6>] __nvsym00775+0x6e/0xe0 [nvidia]
 [<e5bf6566>] __nvsym00781+0x1e/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Debug: sleeping function called from invalid context at mm/slab.c:1817
Call Trace:
 [<c011f41f>] __might_sleep+0x5f/0x80
 [<c0142779>] __kmalloc+0x89/0x90
 [<e5be1643>] os_alloc_mem+0x53/0x82 [nvidia]
 [<e5bf44d4>] __nvsym00083+0x10/0x24 [nvidia]
 [<e5c9ccaf>] __nvsym03944+0x1af/0x2c0 [nvidia]
 [<e5d0451d>] __nvsym00780+0x11d/0x224 [nvidia]
 [<e5bf611c>] __nvsym00773+0x1c/0x5c [nvidia]
 [<e5bf6663>] __nvsym00781+0x11b/0x190 [nvidia]
 [<e5bf7fec>] rm_init_adapter+0xc/0x10 [nvidia]
 [<e5bded07>] nv_kern_open+0xda/0x1e4 [nvidia]
 [<c015faa0>] chrdev_open+0xf0/0x220
 [<c01557bb>] dentry_open+0x14b/0x220
 [<c0155660>] filp_open+0x60/0x70
 [<c0155b03>] sys_open+0x53/0x90
 [<c010a2e9>] sysenter_past_esp+0x52/0x71
 
Linux agpgart interface v0.100 (c) Dave Jones
0: NVRM: AGPGART: unable to retrieve symbol table
- -/snip- -

In addition to this, I've had some pretty scary crashes involving ext3.

It is something very similar to a bug reported in the 2.5.x series
kernels.

EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted
EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted
EXT3-fs error (device /dev/hda3) in start_transaction: Journal has
aborted

^^ Repeated at 1-second intervals.

I'd appreciate someone possibly explaining why this is happening, and,
even better, if it's fixable? Please CC me as I am not usually
subscribed to the Linux-Kernel mailing list.

Kind Regards,

Stuart Low

