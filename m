Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUGZVrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUGZVrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUGZVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:47:33 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:8392 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S266075AbUGZVrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:47:16 -0400
Date: Tue, 27 Jul 2004 00:46:54 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16645.13126.52445.630789@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407270028170.11416-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Tue, 27 Jul 2004 00:46:56 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Robert Olsson wrote:

> Pasi Sjoholm writes:

>  > Pid: 2, comm:          ksoftirqd/0
>  > EIP: 0060:[<e0871224>] CPU: 0
>  > EIP is at rtl8139_poll+0xb4/0x100 [8139too]
>  >  EFLAGS: 00000247    Not tainted  (2.6.7-mm7)
>  > EAX: ffffe000 EBX: 00000040 ECX: df4824f8 EDX: c0441978
>  > ESI: df482400 EDI: e0868000 EBP: dff85f80 DS: 007b ES: 007b
>  > CR0: 8005003b CR2: b7c5a000 CR3: 1fafd000 CR4: 000006d0
>  >  [<c0119580>] ksoftirqd+0x0/0xc0
>  >  [<c02c5f3a>] net_rx_action+0x6a/0x110
>  >  [<c01191a9>] __do_softirq+0xa9/0xb0
>  >  [<c01191d7>] do_softirq+0x27/0x30
>  >  [<c01195e8>] ksoftirqd+0x68/0xc0
>  >  [<c01277e5>] kthread+0xa5/0xb0
>  >  [<c0127740>] kthread+0x0/0xb0
>  >  [<c0102111>] kernel_thread_helper+0x5/0x14
>  > --
>  > I'm not a kernel expert but it would seem that ksoftirqd is in some sort a 
>  > loop because I didn't get any "printk("%s wakes ksoftirqd\n", 
>  > current->comm);"-lines.

>  Hello!

Hur är läget Robert?-)

>  This looks very much like the problem we see when doing route DoS testing
>  with Alexey.

Hmm, at least it sounds like same problem and in both situations network 
interface is kept busy.

>  In summary: High softirq loads can totally kill userland. The reason is that 
>  do_softirq() is run from many places hard interrupts, local_bh_enable etc 
>  and bypasses the ksoftirqd protection. It just been discussed at OLS with
>  Andrea and Dipankar and others. Current RCU suffers from this problem as well.

Ok, this explanation makes sense and my point of view I think this is 
quite critical problem if you can "crash" linux kernel just sending enough 
packets to network interface for an example.

>  I've experimented some code to defer softirq's to ksoftirqd after a time as 
>  well as deferring all softirq's to ksoftirqd. Andrea had some ideas as well 
>  as Ingo.

I would be more than glad to help you in testing if you want to publish 
some patches. 

--
Pasi Sjöholm

