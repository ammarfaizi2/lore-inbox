Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTKXH7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTKXH7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 02:59:23 -0500
Received: from zero.aec.at ([193.170.194.10]:65028 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263633AbTKXH7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 02:59:22 -0500
Date: Mon, 24 Nov 2003 08:59:19 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: deadlock in group_send_sig_info
Message-ID: <20031124075919.GA29874@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had my ipsec daemon deadlock on me in 2.6.0test9/x86-64.
It became unkillable. Apparently it deadlocked while sending
a signal:

pluto         T 0000010002417450    16 20769  20656 20841               (NOTLB)
ffffffff80499dc8 0000010034a3ed70 ffffffff80499e08 0000010034a3ed70 
        0000010002426400 ffffffff8013247d 0000000000000002 000001003fa72000 
        0000000000000001 ffffffff8025ff78 
Call Trace:<IRQ> <ffffffff8013247d>{show_state+93} <ffffffff8025ff78>{k_spec+56} 
        <ffffffff80260ac5>{kbd_keycode+693} <ffffffff80260b10>{kbd_event+32} 
        <ffffffff802c1809>{input_event+905} <ffffffff802c3ccf>{atkbd_interrupt+719} 
        <ffffffff802c6f6b>{serio_interrupt+27} <ffffffff802c77cc>{i8042_interrupt+300} 
        <ffffffffa006d473>{:pppoe:pppoe_rcv_core+163} <ffffffff8013d64c>{update_wall_time+12} 
        <ffffffffa006d071>{:pppoe:__get_item+17} <ffffffff8012f5de>{recalc_task_prio+382} 
        <ffffffff801104ef>{reschedule_interrupt+99} <ffffffff8013d64c>{update_wall_time+12} 
        <ffffffff8013d9c1>{do_timer+49} <ffffffff80116113>{timer_interrupt+515} 
        <ffffffff8011281f>{handle_IRQ_event+47} <ffffffff80112a62>{do_IRQ+194} 
        <ffffffff80110385>{ret_from_intr+0}  <EOI> <ffffffff80181797>{do_select+855} 
        <ffffffff8013f4d2>{group_send_sig_info+1074} <ffffffff8013f6a2>{kill_proc_info+66} 
        <ffffffff801418ac>{sys_kill+76} <ffffffff80124299>{sys32_kill+9} 
        <ffffffff801211fe>{ia32_do_syscall+30} 

I unfortunately don't have the vmlinux for this kernel anymore
and cannot decode it further.

-Andi
