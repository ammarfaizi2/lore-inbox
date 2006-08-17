Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWHQPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWHQPQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWHQPQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:16:39 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:22800 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S964980AbWHQPQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:16:38 -0400
Date: Fri, 18 Aug 2006 00:18:20 +0900 (JST)
Message-Id: <20060818.001820.05196705.yoshfuji@linux-ipv6.org>
To: gerrit@erg.abdn.ac.uk, jmorris@namei.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCHv2 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port
 code
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.64.0608171054560.19149@d.namei>
References: <200608171325.47349@strip-the-willow>
	<Pine.LNX.4.64.0608171054560.19149@d.namei>
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

Hi,

In article <Pine.LNX.4.64.0608171054560.19149@d.namei> (at Thu, 17 Aug 2006 10:56:40 -0400 (EDT)), James Morris <jmorris@namei.org> says:

> On Thu, 17 Aug 2006, gerrit@erg.abdn.ac.uk wrote:
> 
> > -			if (inet2->num == snum &&
> > -			    sk2 != sk &&
> > -			    !ipv6_only_sock(sk2) &&
> > -			    (!sk2->sk_bound_dev_if ||
> > -			     !sk->sk_bound_dev_if ||
> > -			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
> 
> 
> > +		sk_for_each(sk2, node, head)
> > +			if (inet_sk(sk2)->num == snum                        &&
> > +			    sk2 != sk                                        &&
> > +			    (!sk2->sk_reuse        || !sk->sk_reuse)         &&
> > +			    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if
> > +			     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
> 
> 
> Doesn't this change the behavior for IPV6_V6ONLY sockets ?

It is tested in ipv4_rcv_saddr_equal() (called vi saddr_cmp), isn't it?

--yoshfuji
