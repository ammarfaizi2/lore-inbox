Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUIPVTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUIPVTl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIPVTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:19:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58384 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263736AbUIPVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:19:38 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: martin.bouzek@radas-atc.cz
Subject: Re: Minor IPSec bug + solution
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <1095327372.4466.87.camel@mabouzek>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C83f1-0002X7-00@gondolin.me.apana.org.au>
Date: Fri, 17 Sep 2004 07:19:23 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bouzek <martin.bouzek@radas-atc.cz> wrote:
> 
> I was setting up an VPN via IPSec in kernel 2.6.x on IPv4 and found the
> following bug. It is not possible to set up an IPComp/ESP tunnel with
> IPComp set as mandatory. The following setup works fine for me:

You can never set IPComp as mandatory because ipcomp_output() will not
compress anything that is incompressible.

> function. For tunnels it returns 
> 
> tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, family);

The check is correct as it is.  Internal states must never match any
required transform.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
