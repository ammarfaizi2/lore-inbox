Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbULNJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbULNJbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbULNJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:31:33 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:5097 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261464AbULNJbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:31:31 -0500
Date: Tue, 14 Dec 2004 10:31:28 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
In-Reply-To: <20041213212603.4e698de6.pochini@shiny.it>
Message-ID: <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
References: <20041213212603.4e698de6.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Giuliano Pochini wrote:

>
> I can't make NAT work on 2.6.9. Outgoing packets are translated and sent,
> but incoming packets get rejected. pc4 is the other box (inside the NAT) and
> host164-26... is the dynamic address of my machine:
>
> 20:42:20.132876 IP pc4.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
> 20:42:20.132876 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
> 20:42:20.446829 PPPoE  [ses 0x5198] [length 124 (4 extra bytes)] IP nsa.tin.it.domain > host164-26.pool21345.interbusiness.it.33115:  7213 0/1/0 (94)
> 20:42:20.446829 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it > nsa.tin.it: icmp 130: host164-26.pool21345.interbusiness.it udp port 33115 unreachable
>
> I enable NAT with this commands:
>
> echo "1" >/proc/sys/net/ipv4/ip_dynaddr
> echo "1" >/proc/sys/net/ipv4/ip_forward
> iptables -t nat -A POSTROUTING -s pc4 -d ! 192.168.1.0/24 -j MASQUERADE
>
> I also tried SNAT with same results. I don't know if this info is useful:
> all the connection couples shown by /proc/net/ip_conntrack are in
> [UNREPLIED] state. I'm using iptables 1.2.11 and linux 2.6.9. All the above
> works just fine with 2.6.8.1 and previous versions.

2.6.9 contains a large update to the connectiontracking code. One thing
that was changed is that it now verifies the checksum of tcp and udp
packets. I know of at least one user who has been bitten by this and what
looks like a broken sungem NIC.

Could you please try this:

modprobe ipt_LOG
echo 255 > /proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid

Then try again and then check the kernellog by executing 'dmesg', see if
it complains about bad checksums.

/Martin
