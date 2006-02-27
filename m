Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWB0Gex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWB0Gex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWB0Gex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:34:53 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:33515 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751577AbWB0Gew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=meNKPfkLnyvNz7/v7xLYz/yTa/uGCXFccbHRcXFqLGftm8mi3jKSNb0w9jNNHb785tGkV9fQg5Qo1Y1t2Eq0LTX2pXgLmdF4eCg19QfuwlECuvQEXSvcNPcnGDoOiiRt1vf3vEIT6hi0IX0e5KhoZeO6VMZkjoY+B8T+YJ2zaOk=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
In-Reply-To: <20060226175745.42416125.akpm@osdl.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	 <20060226102152.69728696.akpm@osdl.org>
	 <1140988015.5178.15.camel@shogun.daga.dyndns.org>
	 <20060226133140.4cf05ea5.akpm@osdl.org>
	 <1140994821.5522.9.camel@shogun.daga.dyndns.org>
	 <20060226162040.cb72bc31.akpm@osdl.org>
	 <1141002112.17427.4.camel@shogun.daga.dyndns.org>
	 <20060226175745.42416125.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 22:34:47 -0800
Message-Id: <1141022087.5637.6.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 17:57 -0800, Andrew Morton wrote:
> Chris Largret <largret@gmail.com> wrote:
> >
> >  drivers/block/floppy.c:3245: error: too few arguments to function
> >  `__alloc_pages'
> 
> doh.
> 
> --- devel/include/asm-x86_64/floppy.h~b	2006-02-26 16:15:44.000000000 -0800
> +++ devel-akpm/include/asm-x86_64/floppy.h	2006-02-26 17:57:02.000000000 -0800

Earlier I said that there was a "Kernel BUG" and all processing stopped
right after the login prompt was displayed (but before I could type
anything). Now the kernel continues to work, but the messages are a
little disconcerting. Here is the version with a backtrace (from dmesg):


Bad page state in process 'swapper'
page:ffff810001539168 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff8100015391a0 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff8100015391d8 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff810001539210 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff810001539248 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff810001539280 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff8100015392b8 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}
Bad page state in process 'swapper'
page:ffff8100015392f0 flags:0x4000000000000400 mapping:0000000000000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace: <IRQ> <ffffffff8104f0cd>{bad_page+85}
<ffffffff8104f419>{__free_pages_ok+179}
       <ffffffff810500da>{__free_pages+49} <ffffffff8105015f>{free_pages
+131}
       <ffffffff8117db99>{_fd_dma_mem_free+43}
<ffffffff81182ca0>{floppy_release_irq_and_dma+243}
       <ffffffff811809fc>{set_dor+323}
<ffffffff81183d50>{motor_off_callback+0}
       <ffffffff81183d74>{motor_off_callback+36}
<ffffffff81034e97>{run_timer_softirq+366}
       <ffffffff810314e5>{__do_softirq+85}
<ffffffff8100bec6>{call_softirq+30}
       <ffffffff8100d92e>{do_softirq+51} <ffffffff8103162a>{irq_exit+72}
       <ffffffff810160b8>{smp_apic_timer_interrupt+75}
<ffffffff81008d0f>{default_idle+0}
       <ffffffff8100b820>{apic_timer_interrupt+132} <EOI>
<ffffffff81008d0f>{default_idle+0}
       <ffffffff81008d3e>{default_idle+47} <ffffffff81008f44>{cpu_idle
+103}
       <ffffffff814390a1>{start_secondary+1189}


--
Chris Largret <http://daga.dyndns.org>

