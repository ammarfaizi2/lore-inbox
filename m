Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKOOCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKOOCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUKOOCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:02:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9638 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261600AbUKOOCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:02:19 -0500
Date: Mon, 15 Nov 2004 15:02:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Blizbor <kernel@globalintech.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 native IPsec implementation question
In-Reply-To: <4198B2B6.9050803@globalintech.pl>
Message-ID: <Pine.LNX.4.53.0411151455020.17543@yvahk01.tjqt.qr>
References: <4198B2B6.9050803@globalintech.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1. Why IPsec in 2.6 doesn't uses separate interface ?
>It makes impossible to implement firewall logic like this (or I'm
>missing something):
>
>incoming from eth0 allow AH
>incoming from eth0 allow ESP
>incoming from eth0 allow udp 500
>incoming from eth0 allow udp 53
>incoming from eth0 allow ICMP related
>incoming from eth0 deny all

iptables -A INPUT -N myipsec;
iptables -A INPUT -j myipsec -i eth0 -m ah
iptables -A INPUT -j myipsec -i eth0 -m esp
iptables -A INPUT -j ACCEPT -i eth0 -p udp --dport 53
iptables -A INPUT -j ACCEPT -i eth0 -p udp --dport 500
iptables -A INPUT -j ACCEPT -i eth0 -p icmp -m state --state RELATED
iptables -A INPUT -j REJECT -i eth0

>then set of filters restricting traffic incoming via IPsec for examle:
>incoming from ipsec0 allow tcp 389
>incoming from ipsec0 allow ICMP related
>incoming from ipsec0 deny all

iptables -A myipsec -j ACCEPT -p tcp --dport 389
iptables -A myipsec -j ACCEPT -p icmp -m state --state RELATED
iptables -A myipsec -j REJECT

Maybe that solves it? (Not sure whether the myipsec chain works as thought.)

>2. Why IPsec in 2.6 doesn't creates entries in the route tables ?

Because it doesnot create a device ipsecN?




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
