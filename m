Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVAaWLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVAaWLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVAaWLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:11:37 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39064 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261397AbVAaWK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:10:57 -0500
Message-ID: <41FEAD90.6060403@tmr.com>
Date: Mon, 31 Jan 2005 17:13:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: "David S. Miller" <davem@davemloft.net>,
       David Brownell <david-b@pacbell.net>,
       jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, ahaas@airmail.net
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
References: <20050127154150.360f95e2.davem@davemloft.net><20050127154150.360f95e2.davem@davemloft.net> <41F99656.5040304@trash.net>
In-Reply-To: <41F99656.5040304@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> David S. Miller wrote:
> 
>> I've forwarded this to netfilter-devel for inspection.
>> Thanks for collecting all the data points so well.
>>
> Here is the fix for everyone. Please report back if it doesn't
> solve the problem. Thanks.

Worked here.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ===== net/ipv4/netfilter/ip_nat_proto_tcp.c 1.10 vs edited =====
> --- 1.10/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-01-17 23:00:55 +01:00
> +++ edited/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-01-28 02:13:06 +01:00
> @@ -105,7 +105,7 @@
>  		return 0;
>  
>  	iph = (struct iphdr *)((*pskb)->data + iphdroff);
> -	hdr = (struct tcphdr *)((*pskb)->data + iph->ihl*4);
> +	hdr = (struct tcphdr *)((*pskb)->data + hdroff);
>  
>  	if (maniptype == IP_NAT_MANIP_SRC) {
>  		/* Get rid of src ip and src pt */


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
