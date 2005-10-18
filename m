Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVJRGXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVJRGXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVJRGXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:23:30 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:7437 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932410AbVJRGX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:23:29 -0400
Date: Tue, 18 Oct 2005 15:23:18 +0900 (JST)
Message-Id: <20051018.152318.68554424.yoshfuji@linux-ipv6.org>
To: ahendry@tusc.com.au
Cc: acme@ghostprotocols.net, eis@baty.hanse.de, linux-x25@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] X25: Add ITU-T facilites
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1129615767.3695.15.camel@localhost.localdomain>
References: <1129513666.3747.50.camel@localhost.localdomain>
	<20051017022826.GA23167@mandriva.com>
	<1129615767.3695.15.camel@localhost.localdomain>
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

In article <1129615767.3695.15.camel@localhost.localdomain> (at Tue, 18 Oct 2005 16:09:27 +1000), Andrew Hendry <ahendry@tusc.com.au> says:

> +/* 
> +*     ITU DTE facilities
> +*     Only the called and calling address
> +*     extension are currently implemented.
> +*     The rest are in place to avoid the struct
> +*     changing size if someone needs them later
> ++ */
> +struct x25_dte_facilities {
> +	unsigned int    calling_len, called_len;
> +	char            calling_ae[20];
> +	char            called_ae[20];
> +	unsigned char   min_throughput;
> +	unsigned short  delay_cumul;
> +	unsigned short  delay_target;
> +	unsigned short  delay_max;
> +	unsigned char   expedited;
> +};

Why don't you use fixed size members?
And we can eliminate 8bit hole.

struct x25_dte_facilities {
     u32             calling_len
     u32             called_len;
     u8              calling_ae[20];
     u8              called_ae[20];
     u8              min_throughput;
     u8              expedited;
     u16             delay_cumul;
     u16             delay_target;
     u16             delay_max;
};

--yoshfuji
