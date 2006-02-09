Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBIUuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBIUuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBIUuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:50:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36742 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWBIUuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:50:08 -0500
Date: Thu, 9 Feb 2006 15:49:40 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060209204940.GC9576@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
	Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <200602080110.06736.ak@suse.de> <20060208030335.GC17665@redhat.com> <200602080855.06000.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080855.06000.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 08:55:05AM +0100, Andi Kleen wrote:
 > >  > Workaround is pci=nommconf btw
 > > I'm puzzled.  I'm still seeing this crash with latest -git which
 > > has this patch (I just double checked the source I built).
 > 
 > That's surprising. Can you addr2line the exactly address it's crashing on?

Still there in todays git snapshot.
http://people.redhat.com/davej/dsc00150.jpg is the top of the oops.

Full traceback is 
acpi_os_derive_pci_id_2
acpi_os_derive_pci_id
acpi_ev_pci_config_region_setup
acpi_os_acquire_object
acpi_ev_pci_config_region_setup
acpi_ev_address_space_dispatch
cache_alloc_debugcheck_after
acpi_ex_access_region
acpi_ex_field_datum_io
acpi_os_acquire_ojbect
acpi_ex_extract_from_field
acpi_ut_create_internal_object
acpi_ex_read_data_from_field
acpi_ex_resolve_node_to_value
acpi_ds_init_object_from_op
acpi_ex_resolve_to_value
acpi_ex_resolve_operands
acpi_ds_exec_end_op
acpi_ps_parse_loop
acpi_ps_parse_aml
acpi_ps_execute_pass
acpi_ps_execute_method
acpi_ns_evaluate_by_handle
acpi_ns_evaluate_realative
acpi_ut_evalute_object
acpi_ut_execute_STA
acpi_ut_release_mutex
acpi_ns_get_device_callback
vsscanf
acpi_os_wait_semaphore
acpi_ns_get_device_callback
acpi_ns_walk_namespace
acpi_get_devices
find_pci_rootbridge
acpi_get_pci_rootbridge_handle
pci_acpi_find_root_bridge
acpi_platform_notify
device_add
pci_create_bus
pci_scan_bus_parented
pci_acpi_scan_root
acpi_pci_root_add
acpi_bus_driver_init
acpi_add_single_object
acpi_bus_scan
acpi_scan_init
acpi_event_init
init


Here's pci_mm_cfg from that kernel..
d+0>:  push   %r15
0xffffffff802d6e36 <pci_mmcfg_read+2>:  push   %r14
0xffffffff802d6e38 <pci_mmcfg_read+4>:  push   %r13
0xffffffff802d6e3a <pci_mmcfg_read+6>:  push   %r12
0xffffffff802d6e3c <pci_mmcfg_read+8>:  push   %rbp
0xffffffff802d6e3d <pci_mmcfg_read+9>:  push   %rbx
0xffffffff802d6e3e <pci_mmcfg_read+10>: sub    $0x8,%rsp
0xffffffff802d6e42 <pci_mmcfg_read+14>: mov    %edi,%r15d
0xffffffff802d6e45 <pci_mmcfg_read+17>: mov    %esi,%r14d
0xffffffff802d6e48 <pci_mmcfg_read+20>: mov    %edx,%r12d
0xffffffff802d6e4b <pci_mmcfg_read+23>: mov    %ecx,%ebp
0xffffffff802d6e4d <pci_mmcfg_read+25>: mov    %r8d,%ebx
0xffffffff802d6e50 <pci_mmcfg_read+28>: mov    %r9,%r13
0xffffffff802d6e53 <pci_mmcfg_read+31>: test   %r9,%r9
0xffffffff802d6e56 <pci_mmcfg_read+34>: je     0xffffffff802d6e70 <pci_mmcfg_read+60>
0xffffffff802d6e58 <pci_mmcfg_read+36>: cmp    $0xff,%esi
0xffffffff802d6e5e <pci_mmcfg_read+42>: ja     0xffffffff802d6e70 <pci_mmcfg_read+60>
0xffffffff802d6e60 <pci_mmcfg_read+44>: cmp    $0xff,%edx
0xffffffff802d6e66 <pci_mmcfg_read+50>: ja     0xffffffff802d6e70 <pci_mmcfg_read+60>
0xffffffff802d6e68 <pci_mmcfg_read+52>: cmp    $0xfff,%ecx
0xffffffff802d6e6e <pci_mmcfg_read+58>: jle    0xffffffff802d6e77 <pci_mmcfg_read+67>
0xffffffff802d6e70 <pci_mmcfg_read+60>: mov    $0xffffffea,%eax
0xffffffff802d6e75 <pci_mmcfg_read+65>: jmp    0xffffffff802d6edf <pci_mmcfg_read+171>
0xffffffff802d6e77 <pci_mmcfg_read+67>: callq  0xffffffff802d6cf0 <pci_dev_base>
0xffffffff802d6e7c <pci_mmcfg_read+72>: mov    %rax,%rdx
0xffffffff802d6e7f <pci_mmcfg_read+75>: test   %rax,%rax
0xffffffff802d6e82 <pci_mmcfg_read+78>: jne    0xffffffff802d6ea5 <pci_mmcfg_read+113>
0xffffffff802d6e84 <pci_mmcfg_read+80>: mov    %r13,%r9
0xffffffff802d6e87 <pci_mmcfg_read+83>: mov    %ebx,%r8d
0xffffffff802d6e8a <pci_mmcfg_read+86>: mov    %ebp,%ecx
0xffffffff802d6e8c <pci_mmcfg_read+88>: mov    %r12d,%edx
0xffffffff802d6e8f <pci_mmcfg_read+91>: mov    %r14d,%esi
0xffffffff802d6e92 <pci_mmcfg_read+94>: mov    %r15d,%edi
0xffffffff802d6e95 <pci_mmcfg_read+97>: pop    %rbx
0xffffffff802d6e96 <pci_mmcfg_read+98>: pop    %rbx
0xffffffff802d6e97 <pci_mmcfg_read+99>: pop    %rbp
0xffffffff802d6e98 <pci_mmcfg_read+100>:        pop    %r12
0xffffffff802d6e9a <pci_mmcfg_read+102>:        pop    %r13
0xffffffff802d6e9c <pci_mmcfg_read+104>:        pop    %r14
0xffffffff802d6e9e <pci_mmcfg_read+106>:        pop    %r15
0xffffffff802d6ea0 <pci_mmcfg_read+108>:        jmpq   0xffffffff802d56a1 <pci_conf1_read>
0xffffffff802d6ea5 <pci_mmcfg_read+113>:        cmp    $0x2,%ebx
0xffffffff802d6ea8 <pci_mmcfg_read+116>:        je     0xffffffff802d6ec1 <pci_mmcfg_read+141>
0xffffffff802d6eaa <pci_mmcfg_read+118>:        cmp    $0x4,%ebx
0xffffffff802d6ead <pci_mmcfg_read+121>:        je     0xffffffff802d6ed0 <pci_mmcfg_read+156>
0xffffffff802d6eaf <pci_mmcfg_read+123>:        dec    %ebx
0xffffffff802d6eb1 <pci_mmcfg_read+125>:        jne    0xffffffff802d6edd <pci_mmcfg_read+169>
0xffffffff802d6eb3 <pci_mmcfg_read+127>:        movslq %ebp,%rax
0xffffffff802d6eb6 <pci_mmcfg_read+130>:        lea    (%rdx,%rax,1),%rax
0xffffffff802d6eba <pci_mmcfg_read+134>:        mov    (%rax),%al

  We blew up here ^^^

0xffffffff802d6ebc <pci_mmcfg_read+136>:        movzbl %al,%eax
0xffffffff802d6ebf <pci_mmcfg_read+139>:        jmp    0xffffffff802d6ed9 <pci_mmcfg_read+165>
0xffffffff802d6ec1 <pci_mmcfg_read+141>:        movslq %ebp,%rax
0xffffffff802d6ec4 <pci_mmcfg_read+144>:        lea    (%rdx,%rax,1),%rax
0xffffffff802d6ec8 <pci_mmcfg_read+148>:        mov    (%rax),%ax
0xffffffff802d6ecb <pci_mmcfg_read+151>:        movzwl %ax,%eax
0xffffffff802d6ece <pci_mmcfg_read+154>:        jmp    0xffffffff802d6ed9 <pci_mmcfg_read+165>
0xffffffff802d6ed0 <pci_mmcfg_read+156>:        movslq %ebp,%rax
0xffffffff802d6ed3 <pci_mmcfg_read+159>:        lea    (%rdx,%rax,1),%rax
0xffffffff802d6ed7 <pci_mmcfg_read+163>:        mov    (%rax),%eax
0xffffffff802d6ed9 <pci_mmcfg_read+165>:        mov    %eax,0x0(%r13)
0xffffffff802d6edd <pci_mmcfg_read+169>:        xor    %eax,%eax
0xffffffff802d6edf <pci_mmcfg_read+171>:        pop    %r11
0xffffffff802d6ee1 <pci_mmcfg_read+173>:        pop    %rbx
0xffffffff802d6ee2 <pci_mmcfg_read+174>:        pop    %rbp
0xffffffff802d6ee3 <pci_mmcfg_read+175>:        pop    %r12
0xffffffff802d6ee5 <pci_mmcfg_read+177>:        pop    %r13
0xffffffff802d6ee7 <pci_mmcfg_read+179>:        pop    %r14
0xffffffff802d6ee9 <pci_mmcfg_read+181>:        pop    %r15
0xffffffff802d6eeb <pci_mmcfg_read+183>:        retq

		Dave

