Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWH2NA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWH2NA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWH2NA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:00:56 -0400
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:59009 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964915AbWH2NAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:00:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=KnIn1EQkRCMWTy6b/5m60iCavj9WK51BIF4BZ8k/RfhGpyaSrqNot/NrUlq670b0GqqiPZsXWcQb7OQ+iCph+3j7BzSsrydb6AQqDxty7jY01nzHxNximGrpJ77SIfEgSIjXoaKiDrjuR1IFShw44nBYXaH63Jai5CC1dfgal68=  ;
Date: Tue, 29 Aug 2006 15:00:51 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060829130050.GA12773@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20060820013121.GA18401@fieldses.org> <20060829110109.GA10944@gollum.tnic> <44F43C67.76E4.0078.0@novell.com> <200608291316.22327.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608291316.22327.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 01:16:22PM +0200, Andi Kleen wrote:
> 
> > 
> > Without a hex dump of stack contents there's very little I can do.
> 
> Borislav, if you can reproduce the crash please boot with kstack=2048 and send output
> of that.
Yeah, 
    that's a no-go, same output:

<snip>

Aug 29 14:34:08 zmei kernel: [   34.329932] Kernel command line: root=/dev/hda1 vga=0 console=ttyS0,115200 console=tty0 kstack=2048

...

Aug 29 14:45:09 zmei kernel: [  689.179264] 
Aug 29 14:45:10 zmei kernel: [  689.179267] =============================================
Aug 29 14:45:10 zmei kernel: [  689.186226] [ INFO: possible recursive locking detected ]
Aug 29 14:45:10 zmei kernel: [  689.191654] ---------------------------------------------
Aug 29 14:45:10 zmei kernel: [  689.197076] swapper/0 is trying to acquire lock:
Aug 29 14:45:10 zmei kernel: [  689.201720]  (&q->lock){++..}, at: [<c01126d5>] __wake_up+0x15/0x3b
Aug 29 14:45:10 zmei kernel: [  689.208222] 
Aug 29 14:45:10 zmei kernel: [  689.208223] but task is already holding lock:
Aug 29 14:45:10 zmei kernel: [  689.214136]  (&q->lock){++..}, at: [<c01126d5>] __wake_up+0x15/0x3b
Aug 29 14:45:10 zmei kernel: [  689.220629] 
Aug 29 14:45:10 zmei kernel: [  689.220631] other info that might help us debug this:
Aug 29 14:45:10 zmei kernel: [  689.227235] 4 locks held by swapper/0:
Aug 29 14:45:10 zmei kernel: [  689.231013]  #0:  (&tp->rx_lock){-+..}, at: [<c0208de1>] rtl8139_poll+0x42/0x405
Aug 29 14:45:10 zmei kernel: [  689.238691]  #1:  (slock-AF_INET/1){-+..}, at: [<c02a1d91>] tcp_v4_rcv+0x40c/0x8b3
Aug 29 14:45:10 zmei kernel: [  689.246594]  #2:  (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c0271969>] sock_def_readable+0x15/0x69
Aug 29 14:45:10 zmei kernel: [  689.256572]  #3:  (&q->lock){++..}, at: [<c01126d5>] __wake_up+0x15/0x3b
Aug 29 14:45:10 zmei kernel: [  689.263549] 
Aug 29 14:45:10 zmei kernel: [  689.263550] stack backtrace:
Aug 29 14:45:10 zmei kernel: [  689.268086]  [<c0103ba6>] show_trace_log_lvl+0x58/0x152
Aug 29 14:45:10 zmei kernel: [  689.273401]  [<c0104234>] show_trace+0xd/0x10
Aug 29 14:45:10 zmei kernel: [  689.277854]  [<c01042fc>] dump_stack+0x19/0x1b
Aug 29 14:45:10 zmei kernel: [  689.282393]  [<c012eb73>] __lock_acquire+0x74b/0x967
Aug 29 14:45:10 zmei kernel: [  689.287516]  [<c012f2d2>] lock_acquire+0x4b/0x6d
Aug 29 14:45:10 zmei kernel: [  689.292289]  [<c02b8981>] _spin_lock_irqsave+0x2c/0x3c
Aug 29 14:45:10 zmei kernel: [  689.297587]  [<c01126d5>] __wake_up+0x15/0x3b
Aug 29 14:45:10 zmei kernel: [  689.302068]  [<c01752f0>] ep_poll_safewake+0x91/0xc3
Aug 29 14:45:10 zmei kernel: [  689.307278]  [<c0175c7f>] ep_poll_callback+0x83/0x8d
Aug 29 14:45:10 zmei kernel: [  689.312482]  [<c0111a6d>] __wake_up_common+0x2f/0x53
Aug 29 14:45:10 zmei kernel: [  689.317568]  [<c01126e8>] __wake_up+0x28/0x3b
Aug 29 14:45:10 zmei kernel: [  689.322048]  [<c027198e>] sock_def_readable+0x3a/0x69
Aug 29 14:45:10 zmei kernel: [  689.327646]  [<c029a9ff>] tcp_rcv_established+0x3ca/0x64f
Aug 29 14:45:10 zmei kernel: [  689.333601]  [<c029fd6a>] tcp_v4_do_rcv+0x26/0x2df
Aug 29 14:45:10 zmei kernel: [  689.338932]  [<c02a21d1>] tcp_v4_rcv+0x84c/0x8b3
Aug 29 14:45:10 zmei kernel: [  689.344121]  [<c028a470>] ip_local_deliver+0x134/0x1cc
Aug 29 14:45:10 zmei kernel: [  689.349813]  [<c028a300>] ip_rcv+0x425/0x461
Aug 29 14:45:10 zmei kernel: [  689.354638]  [<c027719b>] netif_receive_skb+0x19a/0x22d
Aug 29 14:45:10 zmei kernel: [  689.360394]  [<c0209036>] rtl8139_poll+0x297/0x405
Aug 29 14:45:10 zmei kernel: [  689.365594]  [<c0278b13>] net_rx_action+0x76/0x109
Aug 29 14:45:10 zmei kernel: [  689.370900]  [<c011d5f2>] __do_softirq+0x70/0xf0
Aug 29 14:45:10 zmei kernel: [  689.375648]  [<c010526b>] do_softirq+0x61/0xc6
Aug 29 14:45:10 zmei kernel: [  689.380185]  [<c011d575>] irq_exit+0x49/0x56
Aug 29 14:45:10 zmei kernel: [  689.384591]  [<c0105393>] do_IRQ+0xc3/0xd0
Aug 29 14:45:10 zmei kernel: [  689.388778]  [<c0103521>] common_interrupt+0x25/0x2c
Aug 29 14:45:10 zmei kernel: [  689.393832] DWARF2 unwinder stuck at common_interrupt+0x25/0x2c
Aug 29 14:45:10 zmei kernel: [  689.399774] Leftover inexact backtrace:
<EOF>

Regards,
    Boris.

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
