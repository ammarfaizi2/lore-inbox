Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267843AbVBFEgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267843AbVBFEgg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272676AbVBFEgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:36:36 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:14350 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S268337AbVBFEg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:36:27 -0500
Date: Sun, 06 Feb 2005 13:37:23 +0900 (JST)
Message-Id: <20050206.133723.124822665.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050205201044.1b95f4e8.davem@davemloft.net>
References: <20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
	<20050205201044.1b95f4e8.davem@davemloft.net>
Organization: USAGI Project
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

In article <20050205201044.1b95f4e8.davem@davemloft.net> (at Sat, 5 Feb 2005 20:10:44 -0800), "David S. Miller" <davem@davemloft.net> says:

> > Alternatively we can
> > remove the dst->dev == dev check in dst_dev_event and dst_ifdown
> > and move that test down to the individual ifdown functions.
> 
> I think there is a hole in this idea.... maybe.
> 
> If the idea is to scan dst_garbage_list down in ipv6 specific code,
> you can't do that since 'dst' objects from every pool in the kernel
> get put onto the dst_garbage_list.   It is generic.

How about making dst->ops->dev_check() like this:

static int inline dst_dev_check(struct dst_entry *dst, struct net_device *dev)
{
	if (dst->ops->dev_check)
		return dst->ops->dev_check(dst, dev)
	else
		return dst->dev == dev;
}

--yoshfuji
