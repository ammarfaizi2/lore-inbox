Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWCHJZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWCHJZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWCHJZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:25:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47300 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750982AbWCHJZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:25:41 -0500
Date: Wed, 8 Mar 2006 01:23:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3 oopses on modprobe p4_clockmod
Message-Id: <20060308012347.47538bf4.akpm@osdl.org>
In-Reply-To: <1141809107.7841.5.camel@homer>
References: <1141809107.7841.5.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> Greetings,
> 
> Subject says it all.  This oops is from 100% virgin mm3 source, no
> grubby fingerprints of mine, not even a smudge ;-)
> 
> PREEMPT SMP 
> last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:09.0/subsystem_device
> Modules linked in: p4_clockmod xt_pkttype ipt_LOG xt_limit speedstep_lib freq_table button snd_pcm_oss snd_mixer_oss battery snd_seq snd_seq_device ac edd tda9887 saa7134 ir_kbd_i2c snd_intel8x0 snd_ac97_codec snd_ac97_bus bt878 snd_pcm ohci1394 ieee1394 snd_timer prism54 snd soundcore snd_page_alloc i2c_i801 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom nls_iso8859_1 nls_cp437 nls_utf8 sd_mod fan thermal processor
> CPU:    1
> EIP:    0060:[<c1540de3>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16-rc5-mm3 #9) 
> EIP is at register_cpu_notifier+0x0/0x11
> eax: c14d0b50   ebx: 00000000   ecx: c15d5f40   edx: c15d5f40
> esi: f8a656c4   edi: f8ae9c64   ebp: f0da0e88   esp: f0da0e6c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 7812, threadinfo=f0da0000 task=f40a7000)
> Stack: <0>c12c9bb4 00000001 c13f3d93 c13f3da0 f8a656c4 f8a65780 f40a2800 f0da0e98 
>        f8cdb03a c102a025 f8a65780 f0da0fb4 c1035296 f8a657c8 c13f0cde f8a6578c 
>        000027fe 00000000 f8ae987c f0da0ed8 00000024 00000430 f8d08a80 f8a657c8 
> Call Trace:
>  <c1003e93> show_stack_log_lvl+0xa9/0xe3   <c100406d> show_registers+0x1a0/0x236
>  <c1004381> die+0x12f/0x2ae   <c101390f> do_page_fault+0x353/0x5fa
>  <c1003847> error_code+0x4f/0x54   <f8cdb03a> cpufreq_p4_init+0x3a/0x4e [p4_clockmod]
>  <c1035296> sys_init_module+0x115/0x1a1e   <c1002cdf> sysenter_past_esp+0x54/0x75
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 1b db 25 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

err, I think this was me breaking stuff.

You have CONFIG_HOTPLUG_CPU=n, yes?
