Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757409AbWK1WAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbWK1WAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbWK1WAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:00:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:10630 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1757409AbWK1WAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:00:08 -0500
Date: Tue, 28 Nov 2006 16:59:35 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
Message-ID: <20061128215935.GA3738@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061128020246.47e481eb.akpm@osdl.org> <a44ae5cd0611281322re4041dfha12a11e8f9486bf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0611281322re4041dfha12a11e8f9486bf6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 01:22:34PM -0800, Miles Lane wrote:
> I decided to try building a relocatable kernel.  I don't know if this
> is why I got so many section mismatch errors.
> 
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:boot_params from .text between '_text' (at offset
> 0xc0100036) and 'checkCPUtype'

Hi Miles,

Yes these warnings appear if CONFIG_RELOCATABLE is enabled. Actually, 
there is already code present in the kernel which seem to be accessing
some text in init.text sections. Because CONFIG_RELOCATABLE compiles
the vmlinux with --emit-relocs options, these warnings become visible
using MODPOST.

So basically, these problems like accessing .init.data:boot_params
from .text section already exist. Enabling CONFIG_RELOCATABLE, just makes
them visible in the form of warnings.

I will see how many of these I can get rid of.

Thanks
Vivek

> WARNING: vmlinux - Section mismatch: reference to
> .init.data:boot_params from .text between '_text' (at offset
> 0xc0100044) and 'checkCPUtype'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:init_pg_tables_end from .text between '_text' (at offset
> 0xc01000a6) and 'checkCPUtype'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc01000d5) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc01000df) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc01000fe) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc010010f) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc0100115) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc010011b) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc0100121) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc0100137) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc0100141) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc010014a) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'checkCPUtype' (at offset
> 0xc0100150) and 'is486'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'check_x87' (at offset
> 0xc01001b4) and 'setup_pda'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:new_cpu_data from .text between 'check_x87' (at offset
> 0xc01001d2) and 'setup_pda'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:start_kernel from .text between 'is386' (at offset
> 0xc01001ae) and 'check_x87'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:spawn_ksoftirqd from .text between 'init' (at offset
> 0xc0100397) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:spawn_softlockup_task from .text between 'init' (at offset
> 0xc010039c) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:APIC_init_uniprocessor from .text between 'init' (at offset
> 0xc01003a1) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:sched_init_smp from .text between 'init' (at offset
> 0xc01003a6) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:populate_rootfs from .text between 'init' (at offset
> 0xc01003ab) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:usermodehelper_init from .text between 'init' (at offset
> 0xc01003b5) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:driver_init from .text between 'init' (at offset
> 0xc01003ba) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:sysctl_init from .text between 'init' (at offset
> 0xc01003bf) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between 'init' (at offset 0xc01003d4) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between 'init' (at offset 0xc0100412) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:prepare_namespace from .text between 'init' (at offset
> 0xc01004ea) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:machine_specific_memory_setup from .text between
> 'init_new_context' (at offset 0xc0106c90) and 'i8259A_suspend'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup'
> (at offset 0xc010c056) and '__acpi_map_table'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup'
> (at offset 0xc010c07b) and '__acpi_map_table'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:mp_override_legacy_irq from .text between
> 'acpi_sci_ioapic_setup' (at offset 0xc010c095) and '__acpi_map_table'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:acpi_sci_override_gsi from .text between
> 'acpi_sci_ioapic_setup' (at offset 0xc010c09b) and '__acpi_map_table'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:num_processors from .text between 'MP_processor_info' (at
> offset 0xc010e881) and 'mp_register_lapic'
> WARNING: vmlinux - Section mismatch: reference to .init.data:maxcpus
> from .text between 'MP_processor_info' (at offset 0xc010e89b) and
> 'mp_register_lapic'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:num_processors from .text between 'MP_processor_info' (at
> offset 0xc010e8c8) and 'mp_register_lapic'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:__init_begin from .text between 'free_initmem' (at offset
> 0xc0113396) and 'mark_rodata_ro'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from
> .text between 'online_page' (at offset 0xc0113486) and '__set_fixmap'
> WARNING: vmlinux - Section mismatch: reference to .init.text:init_idle
> from .text between 'fork_idle' (at offset 0xc01188b8) and
> 'get_task_mm'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:_sinittext from .text between 'core_kernel_text' (at offset
> 0xc0128ced) and 'kernel_text_address'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:_einittext from .text between 'core_kernel_text' (at offset
> 0xc0128cf6) and 'kernel_text_address'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:lockdep_init from .text between 'lockdep_init_map' (at
> offset 0xc0130437) and 'save_trace'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:lockdep_init from .text between 'lockdep_reset_lock' (at
> offset 0xc0131c4d) and 'print_circular_bug_header'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:lockdep_init from .text between '__lock_acquire' (at offset
> 0xc0131fa0) and 'lock_release_non_nested'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:_sinittext from .text between 'get_symbol_pos' (at offset
> 0xc01397e5) and 'reset_iter'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:_einittext from .text between 'get_symbol_pos' (at offset
> 0xc01397ec) and 'reset_iter'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:initkmem_list3 from .text between 'set_up_list3s' (at
> offset 0xc016373c) and 'poison_obj'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:__alloc_bootmem from .text between 'vgacon_startup' (at
> offset 0xc020b5e2) and 'vgacon_switch'
> WARNING: vmlinux - Section mismatch: reference to
> .init.data:logo_linux_clut224 from .text between 'fb_find_logo' (at
> offset 0xc020b968) and 'cfb_fillrect'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:uart_parse_options from .text between
> 'serial8250_console_setup' (at offset 0xc0246b77) and
> 'serial8250_request_rsa_resource'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:uart_set_options from .text between
> 'serial8250_console_setup' (at offset 0xc0246b97) and
> 'serial8250_request_rsa_resource'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from
> .text between 'iret_exc' (at offset 0xc0321977) and '_etext'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .data between 'this_cpu' (at offset 0xc03abb10) and 'cpuinfo_op'
> WARNING: vmlinux - Section mismatch: reference to
> .init.text:start_kernel from .paravirtprobe between
> '__start_paravirtprobe' (at offset 0xc0437488) and
> '__stop_paravirtprobe'
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
