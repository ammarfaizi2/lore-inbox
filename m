Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDUONq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDUONq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDUONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:13:46 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:56584 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1750712AbWDUONp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:13:45 -0400
Date: Fri, 21 Apr 2006 16:13:42 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Suspend to RAM bug
Message-ID: <20060421141342.GF16147@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in recent kernel (latest tried 2.6.17-rc1-git5) if I do suspend to disk and then
suspend to ram, then system freezes. Using sysrq-P I found that it gets stuck
(endless loop) in ACPI code:

syscall_call
sys_write
vfs_write
sysfs_write_file
state_store
enter_state
acpi_sleep_prepare
acpi_enable_wakeup_device_prep
acpi_enter_sleep_state_prep
acpi_evaluate_object
acpi_ns_evaluate_by_name
acpi_ns_evaluate_by_handle
acpi_ps_execute_method
acpi_ps_execute_pass
acpi_ps_parse_aml
acpi_ps_parse_loop
------------------ (from this line functions change while repeating sysrq-P)
(acpi_ds_exec_end_op
acpi_ds_create_operands
acpi_ds_create_operand)

OR

(acpi_ds_result_stack_push)

OR 

(acpi_ds_exec_end_op
acpi_ex_resolve_operands
acpi_ex_resolve_to_value
acpi_ex_resolve_node_to_value
acpi_ex_read_data_from_field
acpi_ut_create_internal_object_dbg
acpi_ut_allocate_object_desc_dbg)

-- 
Luká¹ Hejtmánek
