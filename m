Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULMWKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULMWKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULMWKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:10:49 -0500
Received: from imap.telefonica.net ([213.4.129.150]:20362 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S261198AbULMWKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:10:39 -0500
Message-ID: <41BE1399.8010300@telefonica.net>
Date: Mon, 13 Dec 2004 23:11:37 +0100
From: =?ISO-8859-1?Q?Antonio_P=E9rez?= <aperlu@telefonica.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
References: <20041213212603.4e698de6.pochini@shiny.it>
In-Reply-To: <20041213212603.4e698de6.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>I can't make NAT work on 2.6.9. Outgoing packets are translated and sent,
>but incoming packets get rejected. pc4 is the other box (inside the NAT) and
>host164-26... is the dynamic address of my machine:
>
>20:42:20.132876 IP pc4.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
>20:42:20.132876 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it.33115 > nsa.tin.it.domain:  7213+ AAAA? www.drweb32.com. (33)
>20:42:20.446829 PPPoE  [ses 0x5198] [length 124 (4 extra bytes)] IP nsa.tin.it.domain > host164-26.pool21345.interbusiness.it.33115:  7213 0/1/0 (94)
>20:42:20.446829 PPPoE  [ses 0x5198] IP host164-26.pool21345.interbusiness.it > nsa.tin.it: icmp 130: host164-26.pool21345.interbusiness.it udp port 33115 unreachable
>
>I enable NAT with this commands:
>
>echo "1" >/proc/sys/net/ipv4/ip_dynaddr
>echo "1" >/proc/sys/net/ipv4/ip_forward
>iptables -t nat -A POSTROUTING -s pc4 -d ! 192.168.1.0/24 -j MASQUERADE
>
>I also tried SNAT with same results. I don't know if this info is useful:
>all the connection couples shown by /proc/net/ip_conntrack are in
>[UNREPLIED] state. I'm using iptables 1.2.11 and linux 2.6.9. All the above
>works just fine with 2.6.8.1 and previous versions.
>
>Linux Jay 2.6.9 #3 SMP Mon Dec 13 19:58:08 CET 2004 ppc unknown
>
>
>--
>Giuliano.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
add this:
echo 0 > /proc/sys/net/ipv4/tcp_bic
echo 0 > /proc/sys/net/ipv4/tcp_ecn
echo 0 > /proc/sys/net/ipv4/tcp_vegas_conf_avoid

please , tell me if this work.
