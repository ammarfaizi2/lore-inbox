Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUEQGyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUEQGyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUEQGyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 02:54:31 -0400
Received: from dialpool3-61.dial.tijd.com ([62.112.12.61]:19075 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264918AbUEQGy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 02:54:29 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Badness in remove_proc_entry  when 'rmmod battery'
Date: Mon, 17 May 2004 08:54:14 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405170854.14987.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This showed up in my logs today when rmmod'ing the battery module:

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017964a>] remove_proc_entry+0x10a/0x150
 [<e1a09a4d>] acpi_battery_remove_fs+0x1d/0x2d [battery]
 [<e1a09bc5>] acpi_battery_remove+0x32/0x41 [battery]
 [<c02674d5>] acpi_driver_detach+0x39/0x7c
 [<c0267589>] acpi_bus_unregister_driver+0x12/0x51
 [<e1a09bde>] acpi_battery_exit+0xa/0x1e [battery]
 [<c012bace>] sys_delete_module+0x13e/0x180
 [<c014063a>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017964a>] remove_proc_entry+0x10a/0x150
 [<e1a09a4d>] acpi_battery_remove_fs+0x1d/0x2d [battery]
 [<e1a09bc5>] acpi_battery_remove+0x32/0x41 [battery]
 [<c02674d5>] acpi_driver_detach+0x39/0x7c
 [<c0267589>] acpi_bus_unregister_driver+0x12/0x51
 [<e1a09bde>] acpi_battery_exit+0xa/0x1e [battery]
 [<c012bace>] sys_delete_module+0x13e/0x180
 [<c014063a>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Jan

-- 
Bennett's Laws of Horticulture:
	(1) Houses are for people to live in.
	(2) Gardens are for plants to live in.
	(3) There is no such thing as a houseplant.
