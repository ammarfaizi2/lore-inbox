Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVFITtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVFITtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 15:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVFITtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 15:49:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9386 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262456AbVFITsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 15:48:52 -0400
Date: Thu, 9 Jun 2005 12:00:26 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com,
       herbert@gondor.apana.org.au
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
Message-ID: <20050609150026.GA7900@logos.cnet>
References: <20050511124640.GE8541@logos.cnet> <13943.1118147881@www19.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13943.1118147881@www19.gmx.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

On Tue, Jun 07, 2005 at 02:38:01PM +0200, Manfred Schwarb wrote:
> 
> 
> > 
> > Hi Manfred,
> > 
> > On Wed, May 11, 2005 at 10:15:02AM +0200, Manfred Schwarb wrote:
> > > Hi,
> > > with recent versions of the 2.4 kernel (Vanilla), I get an increasing
> > amount of do_IRQ stack overflows.
> > > This night, I got 3 of them.
> > > With 2.4.28 I got an overflow about twice a year, with 2.4.29 nearly
> > once a month and with
> > > 2.4.30 nearly every day 8-((
> > 
> > The system is getting dangerously close to an actual stack overflow, which
> > would 
> > crash the system. 
> > 
> > "do_IRQ: stack overflow: " indicates how many bytes are still available. 
> > 
> > The traces show huge networking execution paths.
> > 
> > It seems you are using some packet scheduler (CONFIG_NET_SCHED)? Pretty
> > much all 
> > traces show functions from sch_generic.c. Can you disable that for a test?
> > 
> 
> Sorry to bother you again, but the problem didn't vanish completely.
> This morning, I caught another one. I built a new kernel with 
> CONFIG_NET_SCHED=n as suggested, uptime is now 25 days, and the following
> is the first do_IRQ since then (ksymoops -i):
> 
> Jun  7 03:55:01 tp-meteodat7 kernel: f3238830 00000280 f49e7b80 00000000
> 00000042 cca1388e f4116980 f17aa000
> Jun  7 03:55:01 tp-meteodat7 kernel:        c010d948 00000042 f4116980
> 00000000 cca1388e f4116980 f17aa000 00000042
> Jun  7 03:55:01 tp-meteodat7 kernel:        00000018 f61d0018 ffffff14
> c023a039 00000010 00000246 ee5ea480 00000000
> Jun  7 03:55:01 tp-meteodat7 kernel: Call Trace:    [call_do_IRQ+5/13]
> [skb_copy_and_csum_dev+73/256]
> [nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445916/96]
> [qdisc_restart+114/432] [dev_queue_xmit+383/880]
> Jun  7 03:55:01 tp-meteodat7 kernel: Call Trace:    [<c010d948>]
> [<c023a039>] [<f90df5dc>] [<c0248402>] [<c023cc7f>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02561a8>] [<c02560f0>]
> [<c02560f0>] [<c024760e>] [<c02560f0>] [<c025492e>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02560f0>] [<c0256315>]
> [<c0256240>] [<c0256240>] [<c024760e>] [<c0256240>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0254d0d>] [<c0256240>]
> [<c026daf0>] [<c0267c99>] [<c026a6f4>] [<c0259370>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0259370>] [<c02661ca>]
> [<c026edaa>] [<c026f48e>] [<c025174f>] [<c02515f0>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c024760e>] [<c02515f0>]
> [<c0251790>] [<c02510df>] [<c02515f0>] [<c0251790>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0251969>] [<c0251790>]
> [<c024760e>] [<c0251790>] [<c02514b8>] [<c0251790>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c023d4d5>] [<c023d5a3>]
> [<c023d73a>] [<c01254c6>] [<c010b094>] [<c010d948>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c010a625>] [<c011ce8a>]
> [<c011cb14>] [<c011ca60>] [<f90f2697>] [<f90f27f9>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<f90f28ab>] [<f90f40c6>]
> [<f914f588>] [<f915053e>] [<f9151255>] [<f8b3a3c4>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b4bcf0>] [<f8b3a3c4>]
> [<f8b4d80f>] [<f8b3a3c4>] [<f8b3a3c4>] [<f8b4cc74>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b3a3c4>] [<f8b39e28>]
> [<f8b448c3>] [<f8b4f8c3>] [<f8b4667b>] [<f8b3a308>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b465ad>] [<f8b531fc>]
> [<c02387b6>] [<f90df5f4>] [<c02483af>] [<c023cc7f>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02561a8>] [<c02387b6>]
> [<f90df5f4>] [<c02387b6>] [<f90df5f4>] [<c02483af>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02560f0>] [<c02560f0>]
> [<c024760e>] [<c02560f0>] [<c025492e>] [<c02560f0>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0256315>] [<c0237f63>]
> [<c0259370>] [<c0259370>] [<c026618d>] [<c026edaa>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c026f48e>] [<c025174f>]
> [<c02515f0>] [<c024760e>] [<c02515f0>] [<c0251790>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02510df>] [<c02515f0>]
> [<c0251790>] [<c0251969>] [<c0251790>] [<c024760e>]
> Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0251790>] [<c013e624>]
> [<c01594d4>] [<c01598d9>] [<c0159bb4>] [<c0158905>]
> Warning (Oops_read): Code line not seen, dumping what data is available

Do you have the "do_IRQ stack overflow" output and the amount of bytes
left it informs? 

> Trace; c010d948 <call_do_IRQ+5/d>
> Trace; c023a039 <skb_copy_and_csum_dev+49/100>
> Trace; f90df5dc <[8139too]rtl8139_start_xmit+6c/180>
> Trace; c0248402 <qdisc_restart+72/1b0>
> Trace; c023cc7f <dev_queue_xmit+17f/370>
> Trace; c02561a8 <ip_finish_output2+b8/150>
> Trace; c02560f0 <ip_finish_output2+0/150>  
> Trace; c02560f0 <ip_finish_output2+0/150>

I can't explain the "ip_finish_output2+0" entries. Odd.

> Trace; c024760e <nf_hook_slow+1de/210>
> Trace; c02560f0 <ip_finish_output2+0/150>
> Trace; c025492e <ip_output+14e/1e0>
> Trace; c02560f0 <ip_finish_output2+0/150>
> Trace; c0256315 <ip_queue_xmit2+d5/29f>
> Trace; c0256240 <ip_queue_xmit2+0/29f>
> Trace; c0256240 <ip_queue_xmit2+0/29f>
> Trace; c024760e <nf_hook_slow+1de/210>
> Trace; c0256240 <ip_queue_xmit2+0/29f>
> Trace; c0254d0d <ip_queue_xmit+34d/600>
> Trace; c0256240 <ip_queue_xmit2+0/29f>
> Trace; c026daf0 <tcp_v4_send_check+a0/f0>
> Trace; c0267c99 <tcp_transmit_skb+3e9/700>
> Trace; c026a6f4 <tcp_send_ack+84/d0>
> Trace; c0259370 <tcp_rfree+0/20>
> Trace; c0259370 <tcp_rfree+0/20>
> Trace; c02661ca <tcp_rcv_established+7fa/a50>
> Trace; c026edaa <tcp_v4_do_rcv+13a/160>
> Trace; c026f48e <tcp_v4_rcv+6be/7a0>
> Trace; c025174f <ip_local_deliver_finish+15f/1a0>
> Trace; c02515f0 <ip_local_deliver_finish+0/1a0>
> Trace; c024760e <nf_hook_slow+1de/210>
> Trace; c02515f0 <ip_local_deliver_finish+0/1a0>
> Trace; c0251790 <ip_rcv_finish+0/268>
> Trace; c02510df <ip_local_deliver+18f/240>
> Trace; c02515f0 <ip_local_deliver_finish+0/1a0>
> Trace; c0251790 <ip_rcv_finish+0/268>
> Trace; c0251969 <ip_rcv_finish+1d9/268>
> Trace; c0251790 <ip_rcv_finish+0/268>
> Trace; c024760e <nf_hook_slow+1de/210>
> Trace; c0251790 <ip_rcv_finish+0/268>
> Trace; c02514b8 <ip_rcv+328/460>
> Trace; c0251790 <ip_rcv_finish+0/268>
> Trace; c023d4d5 <netif_receive_skb+1e5/220>
> Trace; c023d5a3 <process_backlog+93/130>
> Trace; c023d73a <net_rx_action+fa/170>
> Trace; c01254c6 <do_softirq+76/e0>
> Trace; c010b094 <do_IRQ+f4/130>
> Trace; c010d948 <call_do_IRQ+5/d>

I dont see any huge stack consumers on this callchain.

David, Herbert, any clues what might be going on here? 


