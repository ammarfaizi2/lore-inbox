Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVKSLss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVKSLss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKSLss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 06:48:48 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:47109 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751085AbVKSLsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 06:48:47 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: tgraf@suug.ch (Thomas Graf)
Subject: Re: [DEBUG INFO]IPv6: sleeping function called from invalid context.
Cc: yoshfuji@linux-ipv6.org, yanzheng@21cn.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20051118123557.GD20395@postel.suug.ch>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EdRCZ-0007uy-00@gondolin.me.apana.org.au>
Date: Sat, 19 Nov 2005 22:48:15 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf <tgraf@suug.ch> wrote:
> 
> I did. I think it was right, why would an allocation be necessary on
> the second call to inet6_dump_fib()? The walker allocated in process
> context on the first call should be reused from cb->args[0].

Continued dumps are always called under spin lock (see netlink_dump).
So we need to use GFP_ATOMIC in dumpers.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
