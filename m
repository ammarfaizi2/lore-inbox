Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTFCK22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTFCK22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:28:28 -0400
Received: from an.spylog.com ([194.67.35.50]:22544 "EHLO an.spylog.com")
	by vger.kernel.org with ESMTP id S264890AbTFCK20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:28:26 -0400
Date: Tue, 3 Jun 2003 14:41:58 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: mantel@suse.de, cramerj@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: bug report (linux-2.4.20-suse12 +e1000 +xeon +ht)
Message-ID: <20030603104158.GA21071@an.spylog.com>
Mail-Followup-To: Andrey Nekrasov <andy@spylog.ru>, mantel@suse.de,
	cramerj@intel.com, scott.feldman@intel.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Organization: SpyLOG ltd.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

 help me please :)

1. Problem:

  The big load (~30Mbit/sec real traffic + iptables with connection tracking) results to
  that the server does not respond some time. 

  And kernel write message:

...
Jun  3 07:46:22 router1 kernel: Neighbour table overflow.                                                                
Jun  3 07:46:22 router1 last message repeated 9 times                                                                    
Jun  3 07:49:59 router1 kernel:                                                                                          
Jun  3 07:49:59 router1 kernel: wait_on_irq, CPU 3:                                                                      
Jun  3 07:49:59 router1 kernel: irq:  0 [ 0 0 0 0 ]                                                                      
Jun  3 07:49:59 router1 kernel: bh:   1 [ 0 2 7 0 ]                                                                      
Jun  3 07:49:59 router1 kernel: Stack dumps:                                                                             
Jun  3 07:49:59 router1 kernel: CPU 0:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000            
Jun  3 07:49:59 router1 kernel:        00000000 15a13607 00000000 00000000 00000000 00000000 00000000 00000000           
Jun  3 07:49:59 router1 kernel:        000081a4 00000d94 3e8c2d80 3e8c1920 3cb99ad4 00000000 00010000 00000008           
Jun  3 07:49:59 router1 kernel: Call Trace:    [sock_wfree+0/64]                                                         
Jun  3 07:49:59 router1 kernel:                                                                                          
Jun  3 07:49:59 router1 kernel: CPU 1:80c00002 008000db 80008000 00800446 3c3cbc3c ec3c3c34 3c1c3c3c 4c1c3c3c            
Jun  3 07:49:59 router1 kernel:        00420000 0080007f 042e0000 008000d7 3c7c3c3c cc3c3c3c 3e3c383c 5c3c7c3c           
Jun  3 07:49:59 router1 kernel:        00220040 000000df 20044040 000000ff 3c7e3c3c 9c3c1c3c 3c3e3c38 5c3c3c36           
Jun  3 07:49:59 router1 kernel: Call Trace:    [alloc_skb+246/448] [e1000_xmit_frame+1077/1104] [__alloc_pages+234/824] [
Jun  3 07:49:59 router1 kernel:   [e1000_clean_rx_irq+1024/1036] [e1000_clean_rx_irq+1024/1036] [add_timer_randomness+204
Jun  3 07:49:59 router1 kernel:   [schedule_task+191/204] [handle_scancode+685/696] [scheduler_tick+1048/1104] [update_pr
Jun  3 07:49:59 router1 kernel:   [ip_conntrack_tuple_taken+72/148] [ip_nat_used_tuple+31/40] [tcp_unique_tuple+190/224] 
Jun  3 07:49:59 router1 kernel:   [ip_nat_cheat_check+38/64] [tcp_manip_pkt+99/124] [ip_nat_cheat_check+38/64] [manip_pkt
Jun  3 07:49:59 router1 kernel:   [qdisc_restart+24/596] [dev_queue_xmit+357/1096] [ip_finish_output2+199/280] [nf_hook_s
Jun  3 07:49:59 router1 kernel:   [ip_forward_finish+87/96] [nf_hook_slow+276/404] [ip_forward+503/608] [scheduler_tick+1
Jun  3 07:49:59 router1 kernel:   [smp_apic_timer_interrupt+243/284] [bh_action+215/220] [tasklet_hi_action+99/160] [ksof
Jun  3 07:49:59 router1 kernel:                                                                                          
Jun  3 07:49:59 router1 kernel: CPU 2:000666e8 e932e674 e02eb7a4 e932e6cc e932e6cc 00000000 00000000 00000000            
Jun  3 07:49:59 router1 kernel:        e932e674 e932e674 e932e674 e932e674 e932e674 00000002 00000000 c8e195bf           
Jun  3 07:49:59 router1 kernel:        00000000 00000000 00000000 00000000 00000003 00000004 00010000 040fa8c0           
Jun  3 07:49:59 router1 kernel: Call Trace:    [death_by_timeout+0/164] [fib_convert_rtentry+260/856] [destroy_conntrack+
Jun  3 07:49:59 router1 kernel:   [death_by_timeout+0/164] [destroy_conntrack+0/292] [nf_sockopt+240/280] [death_by_timeo
Jun  3 07:49:59 router1 kernel:   [destroy_conntrack+0/292] [death_by_timeout+0/164] [destroy_conntrack+0/292] [death_by_
Jun  3 07:49:59 router1 kernel:   [death_by_timeout+0/164] [fib_convert_rtentry+260/856] [destroy_conntrack+0/292] [death
Jun  3 07:49:59 router1 kernel:   [destroy_conntrack+0/292] [death_by_timeout+0/164] [destroy_conntrack+0/292] [death_by_
Jun  3 07:49:59 router1 last message repeated 2 times                                                                    
Jun  3 07:49:59 router1 kernel:   [destroy_conntrack+0/292] [death_by_timeout+0/164] [destroy_conntrack+0/292] [death_by_
Jun  3 07:49:59 router1 kernel:                                                                                          
Jun  3 07:49:59 router1 kernel: CPU 3:e161bf34 e03196dd 00000003 00000180 00000000 e161bf60 e0108d3d e03196f2            
Jun  3 07:49:59 router1 kernel:        e161bf94 e1b2b000 00000001 e161bf7c e01ff258 e161bf94 e161bf94 00000282           
Jun  3 07:49:59 router1 kernel:        e1b2b56c e1b2b16c e161bf9c e0121cac e1b2b000 e161a000 e161a65c ffffffff           
Jun  3 07:49:59 router1 kernel: Call Trace:    [__global_cli+189/296] [flush_to_ldisc+300/376] [__run_task_queue+172/188]
Jun  3 07:49:59 router1 kernel:   [arch_kernel_thread+40/56]                                                             
Jun  3 07:49:59 router1 kernel:

2. hardware

		- m/b "Intel Server Board SE7500WV2"
		- CPU 2x Intel(R) XEON(TM) CPU 1.80GHz + enable "Hyper Threading"
		- 512Mb ram

3. software:

		- Debian Woody 3.0
    - kernel Linux 2.4.20-SuSE.12
      network driver:
			Intel(R) PRO/1000 Network Driver - version 4.4.19-k2


thanks.
bye.
