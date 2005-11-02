Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVKBUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVKBUXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVKBUXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:23:49 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:3439 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965220AbVKBUXs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:23:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cLZjvNiE8MxnSCvt4jMn13udUOYHM1+kHkDIHRf1vW1bs7TwrB8kVa3sA4dyfC68ezbY7hxcWIAAdFF8yqwJ7duvODLxnCtPI+9XmcXKUMk+yyWSUd7CsSa4YU5yk2NlQtfBJcyLojHU5oih4RqYMPwxpg5He8GPNRJHxqgyrD4=
Message-ID: <69304d110511021223m59716878qc247ab96d8c1e24e@mail.gmail.com>
Date: Wed, 2 Nov 2005 21:23:46 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Steve Snyder <R00020C@freescale.com>
Subject: Re: Can I reduce CPU use of conntrack/masq?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511021450.47657.R00020C@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511021450.47657.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Steve Snyder <R00020C@freescale.com> wrote:
> Hello.
>
> I am working on what amounts to a Ethernet to Ultra-Wide Band (UWB)
> converter box.  Packets are simply routed from 1 interface to
> another.
>
> This box is based on an ARM7TDMI CPU, running Linux 2.4.26, and the
> network throughput of the box is CPU-limited.  How limited?  The
> 100Mbps/FD Ethernet can do no better than 35Mbps.
>
> I've discovered that I can improve Ethernet throughput by about %20 by
> removing the the conntrack/masq support from the kernel.  The removal
> is good only as a test, though, since I need this functionality to
> move the packets between interfaces.
>
> This is the relevant config:
>
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
>
> Enabled at boot time like this:
>
> /sbin/iptables -t nat -A POSTROUTING -o uwb0 -j MASQUERADE
> echo "1" > /proc/sys/net/ipv4/ip_forward
>
> I wonder if I can improve conntrack/masq performance at the expense of
> flexibility.  This will be a closed system, with simple and static
> routing.  Are there any trade-offs I can make to sacrifice unneeded
> flexibility in routing for reduced CPU utilization in conntrack/masq?

Hmmm... totally untested and don't know the details of UWB but...
can't you simply ether-bridge the interfaces instead of masquerading?
It should need less CPU


> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
