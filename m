Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJNMvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJNMvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 08:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJNMvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 08:51:19 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:6155 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750732AbVJNMvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 08:51:18 -0400
Date: Fri, 14 Oct 2005 21:51:13 +0900 (JST)
Message-Id: <20051014.215113.26967183.yoshfuji@linux-ipv6.org>
To: jesper.juhl@gmail.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org,
       acme@conectiva.com.br, ralf@linux-mips.org, greg@kroah.com,
       dccp@vger.kernel.org, patrick@tykepenguin.com, jt@hpl.hp.com,
       sri@us.ibm.com, andros@umich.edu, bfields@umich.edu,
       ncorbic@sangoma.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 01/14] Big kfree NULL check cleanup - net
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200510132125.44470.jesper.juhl@gmail.com>
References: <200510132125.44470.jesper.juhl@gmail.com>
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

In article <200510132125.44470.jesper.juhl@gmail.com> (at Thu, 13 Oct 2005 21:25:43 +0200), Jesper Juhl <jesper.juhl@gmail.com> says:

> --- linux-2.6.14-rc4-orig/net/ipv4/netfilter/ip_nat_snmp_basic.c	2005-10-11 22:41:33.000000000 +0200
> +++ linux-2.6.14-rc4/net/ipv4/netfilter/ip_nat_snmp_basic.c	2005-10-13 11:31:09.000000000 +0200
> @@ -1161,8 +1161,7 @@ static int snmp_parse_mangle(unsigned ch
>  		
>  		if (!snmp_object_decode(&ctx, obj)) {
>  			if (*obj) {
> -				if ((*obj)->id)
> -					kfree((*obj)->id);
> +				kfree((*obj)->id);
>  				kfree(*obj);
>  			}	
>  			kfree(obj);

Maybe:
    if (*obj)
        kfree((*obj)->id);
    kfree(obj);

Otherwise;
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

--yoshfuji
