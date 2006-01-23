Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWAWTUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWAWTUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWAWTUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:20:17 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:14805 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964902AbWAWTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:20:15 -0500
Message-ID: <43D52C69.5090707@t-online.de>
Date: Mon, 23 Jan 2006 20:20:09 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <43D1C99E.2000506@t-online.de> <20060123101538.14d21bf4@dxpl.pdx.osdl.net>
In-Reply-To: <20060123101538.14d21bf4@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: EG3PagZA8ehE3weF7YXJtIt2n3vGC25N03qVCnn4VIAml7ZS7ADy0J@t-dialin.net
X-TOI-MSGID: cf00bb46-dc9e-4fe0-b912-660f4c9ebfe3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>O
>  
>
>>It seems that the SuSE Firewall locked something ....
>>
>>I started with kernel 2.6.15-git7, tried 2.6.15.1 and 2.6.16-rc1*.
>>At the moment I do use a kernel 2.6.15-git7 patched with an updated sky2 
>>(v.013).
>>I could not find a single working sky2 configuration.
>>
>>    
>>
>
>Are you using the full kernel.org kernel, or are you putting sky2 driver into
>the SUSE kernel?
>
No SuSE kernels here. I started with kernel.org kernel 2.6.15-git7 and
had those problems. Then I tried 2.6.16-rc3-git3, the most recent kernel
at the time of my original writing. As I had some other problems with
that kernel I had a look at the git tree of Linus and applied all sky2 
related
patches to the otherwise unchanged 2.6.15-git7. 2.6.15.1 also was no
solution as sky2 seems to be not available there.

> There are a number of bug fixes related to hardware checksumming
>that are in the kernel.org kernel (2.6.15 or later).  There was one in ICMP.
>These fixes relate to places in the code where a protocol decides to trim a
>packet by removing bytes. I am not familiar with the SuSE Firewall. Is it just
>standard netfilter modules or additional code?
>  
>
I have to admit that I don´t know enough about the network layers
of the kernel, so here is a list of the network modules loaded (sky2
compiled into the kernel). SuSEFirewall is just standard netfiltering
using those modules.

ipt_MASQUERADE          3968  1
pppoe                  15360  2
pppox                   4616  1 pppoe
af_packet              23240  2
ppp_generic            30740  6 pppoe,pppox
slhc                    7040  1 ppp_generic
ipt_TOS                 2816  28
ipt_TCPMSS              4800  2
ipt_LOG                 7232  77
ipt_limit               2880  77
ipt_pkttype             1984  2
ipt_state               2240  45
ip6t_REJECT             5824  3
ipt_REJECT              5952  3
iptable_mangle          3200  1
iptable_nat             8836  1
iptable_filter          3264  1
ip6table_mangle         2752  0
ip_nat_ftp              3776  0
ip_nat                 18284  3 ipt_MASQUERADE,iptable_nat,ip_nat_ftp
ip_conntrack_ftp        8240  1 ip_nat_ftp
ip_conntrack           51020  6 
ipt_MASQUERADE,ipt_state,iptable_nat,ip_nat_ftp,ip_nat,ip_conntrack_ftp
ip_tables              24088  11 
ipt_MASQUERADE,ipt_TOS,ipt_TCPMSS,ipt_LOG,ipt_limit,ipt_pkttype,ipt_state,ipt_REJECT,iptable_mangle,iptable_nat,iptable_filter
ip6table_filter         3136  1
ip6_tables             25624  3 ip6t_REJECT,ip6table_mangle,ip6table_filter
ipv6                  271712  14 ip6t_REJECT

As said before, rtl8139 does work perfectly well, the same is true
for an identical system with a Via Rhine adapter.


cu,
 Knut
