Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVBFFAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVBFFAu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271524AbVBFFAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:00:50 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:16142 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262701AbVBFFAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:00:37 -0500
Date: Sun, 06 Feb 2005 14:01:35 +0900 (JST)
Message-Id: <20050206.140135.112327413.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050205200242.2b629de7.davem@davemloft.net>
References: <20050205064643.GA29758@gondor.apana.org.au>
	<20050205.195039.05988480.yoshfuji@linux-ipv6.org>
	<20050205200242.2b629de7.davem@davemloft.net>
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

In article <20050205200242.2b629de7.davem@davemloft.net> (at Sat, 5 Feb 2005 20:02:42 -0800), "David S. Miller" <davem@davemloft.net> says:

> > Yes, IPv6 needs "split device" semantics
> > (for per-device statistics such as Ip6InDelivers etc),
> > and I like later solution.
> 
> Ok.  I never read whether ipv6, like ipv4, is specified to support
> a model of host based ownership of addresses.  Does anyone know?

I'm not sure it is explicitly specified, but there're some hints:

1. we need to allow multiple addresses on multiple interfaces.
   e.g. link-local address

2. if a packet has come from A to link-local address on the other side B,
   we should not receive it.
         +-------+
    ---->|A     B|
         +-------+

   Currently, it does not happen in usual because ndisc does NOT handle
   addresses on other device.

3. mib document states that we should take statistics on interface which 
   the address belongs to; not the interface where the packet has come
   from:

cited from RFC2011bis:
Local (*) packets on the input side are counted on the interface
associated with their destination address, which may not be the
interface on which they were received.  This requirement is caused by
the possibility of losing the original interface during processing,
especially re-assembly.

(*): here it means incoming, but not forwarding.


BTW, BSD has similar reference to interface structure in routeing entry.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
