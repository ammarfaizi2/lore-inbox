Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbULMUg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbULMUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbULMUei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:34:38 -0500
Received: from vsmtp12.tin.it ([212.216.176.206]:33231 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S262281AbULMU0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:26:12 -0500
Date: Mon, 13 Dec 2004 21:26:03 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9 NAT problem
Message-Id: <20041213212603.4e698de6.pochini@shiny.it>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't make NAT work on 2.6.9. Outgoing packets are translated and sent,
but incoming packets get rejected. pc4 is the other box (inside the NAT) and
host164-26... is the dynamic address of my machine:

20:42:20.132876 IP pc4.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
20:42:20.132876 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
20:42:20.446829 PPPoE  [ses 0x5198] [length 124 (4 extra bytes)] IP nsa.tin.it.domain > host164-26.pool21345.interbusiness.it.33115:  7213 0/1/0 (94)
20:42:20.446829 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it > nsa.tin.it: icmp 130: host164-26.pool21345.interbusiness.it udp port 33115 unreachable

I enable NAT with this commands:

echo "1" >/proc/sys/net/ipv4/ip_dynaddr
echo "1" >/proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s pc4 -d ! 192.168.1.0/24 -j MASQUERADE

I also tried SNAT with same results. I don't know if this info is useful:
all the connection couples shown by /proc/net/ip_conntrack are in
[UNREPLIED] state. I'm using iptables 1.2.11 and linux 2.6.9. All the above
works just fine with 2.6.8.1 and previous versions.

Linux Jay 2.6.9 #3 SMP Mon Dec 13 19:58:08 CET 2004 ppc unknown


--
Giuliano.
