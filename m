Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWI3HEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWI3HEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWI3HEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:04:13 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:19296 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751074AbWI3HEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:04:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:Content-Transfer-Encoding;
  b=0/hNxWitRYVUc4oPQRBJJyrKW6WLH2mRr86m01imxUkwYJzag+fWS4aIr07LezOx8IxcJlN66lR1flj9QNEJoWpV/2gPKgiu0JrmgNC5SCEa1HQAbuNvbxUGLuQwnsu/FBkWzneBXGGQEVtPbFqWzgNbV2tXAAtss6rDxhEQXQ8=  ;
Date: Sat, 30 Sep 2006 09:04:06 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - possible recursive locking detected
Message-ID: <20060930070406.GA7090@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20060928014623.ccc9b885.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060928014623.ccc9b885.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 01:46:23AM -0700, Andrew Morton wrote:
Hi,

    .config is at http://tim.dnsalias.org/2.6.18-mm2.cfg.

Sep 30 08:38:17 zmei kernel: [  285.197902] 
Sep 30 08:38:19 zmei kernel: [  285.197905] =============================================
Sep 30 08:38:19 zmei kernel: [  285.204776] [ INFO: possible recursive locking detected ]
Sep 30 08:38:19 zmei kernel: [  285.210163] 2.6.18-mm2 #1
Sep 30 08:38:19 zmei kernel: [  285.212782] ---------------------------------------------
Sep 30 08:38:19 zmei kernel: [  285.218168] swapper/0 is trying to acquire lock:
Sep 30 08:38:19 zmei kernel: [  285.222777]  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
Sep 30 08:38:19 zmei kernel: [  285.229114] 
Sep 30 08:38:19 zmei kernel: [  285.229115] but task is already holding lock:
Sep 30 08:38:19 zmei kernel: [  285.234952]  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
Sep 30 08:38:19 zmei kernel: [  285.241290] 
Sep 30 08:38:19 zmei kernel: [  285.241291] other info that might help us debug this:
Sep 30 08:38:19 zmei kernel: [  285.247817] 4 locks held by swapper/0:
Sep 30 08:38:19 zmei kernel: [  285.251561]  #0:  (&tp->rx_lock){-+..}, at: [<c020f350>] rtl8139_poll+0x42/0x405
Sep 30 08:38:19 zmei kernel: [  285.259041]  #1:  (slock-AF_INET/1){-+..}, at: [<c02aa753>] tcp_v4_rcv+0x3fa/0x8eb
Sep 30 08:38:19 zmei kernel: [  285.266700]  #2:  (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c0278d83>] sock_def_readable+0x15/0x69
Sep 30 08:38:19 zmei kernel: [  285.276454]  #3:  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
Sep 30 08:38:19 zmei kernel: [  285.283241] 
Sep 30 08:38:19 zmei kernel: [  285.283242] stack backtrace:
Sep 30 08:38:19 zmei kernel: [  285.287688]  [<c0103b65>] dump_trace+0x64/0x1cd
Sep 30 08:38:19 zmei kernel: [  285.292243]  [<c0103ce0>] show_trace_log_lvl+0x12/0x25
Sep 30 08:38:19 zmei kernel: [  285.297405]  [<c010431c>] show_trace+0xd/0x10
Sep 30 08:38:19 zmei kernel: [  285.301780]  [<c01043e4>] dump_stack+0x19/0x1b
Sep 30 08:38:19 zmei kernel: [  285.306250]  [<c013022d>] __lock_acquire+0x750/0x96c
Sep 30 08:38:19 zmei kernel: [  285.311304]  [<c013098c>] lock_acquire+0x4b/0x6b
Sep 30 08:38:19 zmei kernel: [  285.316005]  [<c02ca474>] _spin_lock_irqsave+0x2c/0x3c
Sep 30 08:38:19 zmei kernel: [  285.321233]  [<c0112f70>] __wake_up+0x15/0x3b
Sep 30 08:38:19 zmei kernel: [  285.325638]  [<c0178dd4>] ep_poll_safewake+0x91/0xc3
Sep 30 08:38:19 zmei kernel: [  285.330760]  [<c0179c69>] ep_poll_callback+0x83/0x8e
Sep 30 08:38:19 zmei kernel: [  285.335888]  [<c01122e5>] __wake_up_common+0x2f/0x53
Sep 30 08:38:19 zmei kernel: [  285.340898]  [<c0112f83>] __wake_up+0x28/0x3b
Sep 30 08:38:19 zmei kernel: [  285.345312]  [<c0278da8>] sock_def_readable+0x3a/0x69
Sep 30 08:38:20 zmei kernel: [  285.350778]  [<c02a1892>] tcp_data_queue+0x50f/0xa53
Sep 30 08:38:20 zmei kernel: [  285.356232]  [<c02a34c3>] tcp_rcv_established+0x5aa/0x64f
Sep 30 08:38:20 zmei kernel: [  285.362077]  [<c02a86f6>] tcp_v4_do_rcv+0x26/0x2f2
Sep 30 08:38:20 zmei kernel: [  285.367322]  [<c02aabd4>] tcp_v4_rcv+0x87b/0x8eb
Sep 30 08:38:20 zmei kernel: [  285.372432]  [<c02928e3>] ip_local_deliver+0x19c/0x265
Sep 30 08:38:20 zmei kernel: [  285.378033]  [<c029270b>] ip_rcv+0x453/0x48f
Sep 30 08:38:20 zmei kernel: [  285.382769]  [<c027e51a>] netif_receive_skb+0x1a6/0x239
Sep 30 08:38:20 zmei kernel: [  285.388440]  [<c020f5a5>] rtl8139_poll+0x297/0x405
Sep 30 08:38:20 zmei kernel: [  285.393553]  [<c027ff20>] net_rx_action+0x76/0x109
Sep 30 08:38:20 zmei kernel: [  285.398782]  [<c011dad0>] __do_softirq+0x70/0xf0
Sep 30 08:38:20 zmei kernel: [  285.403459]  [<c011db89>] do_softirq+0x39/0x55
Sep 30 08:38:20 zmei kernel: [  285.407963]  [<c011dcd5>] irq_exit+0x49/0x56
Sep 30 08:38:20 zmei kernel: [  285.412295]  [<c010537f>] do_IRQ+0x8f/0x9c
Sep 30 08:38:20 zmei kernel: [  285.416408]  [<c01035e1>] common_interrupt+0x25/0x2c
Sep 30 08:38:20 zmei kernel: [  285.421393] DWARF2 unwinder stuck at common_interrupt+0x25/0x2c
Sep 30 08:38:20 zmei kernel: [  285.427298] 
Sep 30 08:38:20 zmei kernel: [  285.428786] Leftover inexact backtrace:
Sep 30 08:38:20 zmei kernel: [  285.428787] 
Sep 30 08:38:20 zmei kernel: [  285.434103]  [<c010168b>] cpu_idle+0x72/0x9b
Sep 30 08:38:20 zmei kernel: [  285.438383]  [<c010064e>] rest_init+0x37/0x39
Sep 30 08:38:20 zmei kernel: [  285.442742]  [<c043d73b>] start_kernel+0x356/0x35e
Sep 30 08:38:20 zmei kernel: [  285.447549]  [<00000000>] 0x0
Sep 30 08:38:20 zmei kernel: [  285.450541]  =======================

-- 
Regards/Gruß,
    Boris.

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
