Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWIVHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIVHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWIVHi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:38:58 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5128 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750845AbWIVHi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:38:57 -0400
Date: Fri, 22 Sep 2006 16:41:09 +0900 (JST)
Message-Id: <20060922.164109.112537486.yoshfuji@linux-ipv6.org>
To: nenolod@atheme.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser
 to bypass CAP_NET_BIND_SERVICE requirement
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org>
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org>
	<736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org> (at Fri, 22 Sep 2006 02:31:59 -0500), William Pitcock <nenolod@atheme.org> says:

> This patch allows for a user to disable the requirement to meet the  
> CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by  
> the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.

Why?  I don't think this is a good idea.

> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index e4b1a4d..c3f7c3c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -411,6 +411,7 @@ enum
> 	NET_IPV4_TCP_WORKAROUND_SIGNED_WINDOWS=115,
> 	NET_TCP_DMA_COPYBREAK=116,
> 	NET_TCP_SLOW_START_AFTER_IDLE=117,
> +	NET_IPV4_ALLOW_LOWPORT_BIND_NONSUPERUSER=118,
>    };
> 
>    enum {

This implies all IPv4 protocols including other protocols
such as UDP, SCTP, ...

> @@ -1412,3 +1418,4 @@ EXPORT_SYMBOL(inet_stream_ops);
>    EXPORT_SYMBOL(inet_unregister_protosw);
>    EXPORT_SYMBOL(net_statistics);
>    EXPORT_SYMBOL(sysctl_ip_nonlocal_bind);
> +EXPORT_SYMBOL(sysctl_ip_allow_lowport_bind_nonsuperuser);

Please be aware about indent.

--yoshfuji
