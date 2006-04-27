Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWD0BMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWD0BMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 21:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWD0BMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 21:12:22 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:53194 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S964830AbWD0BMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 21:12:22 -0400
Mime-Version: 1.0
Message-Id: <a06230901c075ca078b8d@[129.98.90.227]>
In-Reply-To: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu>
References: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu>
Date: Wed, 26 Apr 2006 21:12:38 -0400
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: iptables is complaining with bogus unknown error
 18446744073709551615
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic kernel module loading! That is an option and it's off by 
default. When it's off, attempts to load kernel modules are ignored 
internally, and that's why iptables was failing. It tried to load 
xt_tcpudp, but was ignored by the kernel.


>
>At least since 2.6.1.16.1, many calls to iptables no longer function
>at least under 64-bit x86, presumably due to a bug in the netfilter
>kernel code.
>
>The problem is still present in 2.6.17-rc2.
>
>The error from iptables is
>iptables: unknown error 18446744073709551615
>
>Examples of rules that give the error are
>
>1) iptables -A INPUT -i bond0 -s 129.98.90.0/24 -p tcp --dport 548 -j ACCEPT
>2) iptables -A INPUT -i bond0 -s 129.98.90.101/32 -p tcp --dport 497 -j ACCEPT
>3) iptables -A INPUT -i bond0 -s 129.98.90.227/32 -p tcp --dport 22 -j ACCEPT
>
>Example of a rule that does not give the error:
>1) iptables -A INPUT -i bond0 -p ICMP --icmp-type echo-request -s
>129.98.90.13/32 -j ACCEPT
>
>The computer is using IPv4 and not IPv6, which has not been compiled into the
>kernel.
>
>iptables is version 1.3.5.
>
>Kernel configuration related to iptables follows:
>



>lsmod shows
>xt_state                4928  0
>ipt_LOG                 8960  0
>ip_conntrack_ftp       10000  0
>ip_conntrack           57880  2 xt_state,ip_conntrack_ftp
>nfnetlink               8520  1 ip_conntrack
>iptable_filter          5440  0
>ip_tables              22168  1 iptable_filter
>x_tables               17800  3 xt_state,ipt_LOG,ip_tables
>

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
