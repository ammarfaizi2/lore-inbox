Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWFMP2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWFMP2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWFMP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:28:54 -0400
Received: from rtr.ca ([64.26.128.89]:7839 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932137AbWFMP2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:28:53 -0400
Message-ID: <448ED9B3.8050506@rtr.ca>
Date: Tue, 13 Jun 2006 11:28:51 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca>
In-Reply-To: <448ED2FC.2040704@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm.  I notice that 2.6.17 has a new sysctl related
to this stuff:  /proc/sys/net/ipv4/tcp_workaround_signed_windows

It makes no difference whatsoever for me here
when varied while /proc/sys/net/ipv4/tcp_window_scaling==1.

The site www.everymac.com is still not browseable until
setting /proc/sys/net/ipv4/tcp_window_scaling===0.

There's one other difference I see in the tcpdump traces.
The first packets from each trace below show different
values for "wscale".  The old (working) kernels use "wscale 2",
whereas 2.6.17 uses "wscale 6".  In both cases, the value
seen in /proc/sys/net/ipv4/tcp_adv_win_scale is 2.

This is from (working) 2.6.16.18:
> 
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: S 2933486277:2933486277(0) win 5840 <mss 1460,sackOK,timestamp 730285 0,nop,wscale 2>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56224: S 2545625510:2545625510(0) ack 2933486278 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134760199 730285>
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56224: P 1:206(205) ack 607 win 32798 <nop,nop,timestamp 134760217 730448>
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 206 win 1728 <nop,nop,timestamp 730626 134760217> 

This is from (failing) 2.6.17-rc6-git2:
> 
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: S 3000518105:3000518105(0) win 5840 <mss 1460,sackOK,timestamp 4294759165 0,nop,wscale 6>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: S 3368494549:3368494549(0) ack 3000518106 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134771817 4294759165> 
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: . ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294760162 134771817>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: . ack 607 win 32798 <nop,nop,timestamp 134771918 4294760162> 

Something is broken somewhere.
