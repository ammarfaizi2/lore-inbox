Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSKADSC>; Thu, 31 Oct 2002 22:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265574AbSKADSC>; Thu, 31 Oct 2002 22:18:02 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:17171 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265568AbSKADSB>; Thu, 31 Oct 2002 22:18:01 -0500
Date: Fri, 01 Nov 2002 12:22:12 +0900 (JST)
Message-Id: <20021101.122212.601751630.yoshfuji@linux-ipv6.org>
To: lpetande@morphine.tml.hut.fi
Cc: takamiya@po.ntts.co.jp, ajtuomin@morphine.tml.hut.fi, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       pekkas@netcore.fi, torvalds@transmeta.com, jagana@us.ibm.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.44.0210311232310.18909-100000@morphine.tml.hut.fi>
References: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
	<Pine.GSO.4.44.0210311232310.18909-100000@morphine.tml.hut.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.44.0210311232310.18909-100000@morphine.tml.hut.fi> (at Thu, 31 Oct 2002 12:44:00 +0200 (EET)), Henrik Petander <lpetande@morphine.tml.hut.fi> says:

> > (2) Avoiding Netfilter Hooks
> > 	In your imprementation HA uses netfilter to intercept packets
> > 	sent to MN. We think it is costy so we have a suggestion to
> > 	use FIB structure to forward packets to MN. Bacause we think
> > 	forwarding packets from HA to MN is FORWARDING, not FILTERING.
> > 	We think the kernel maintainers may prefer such a manner using
> > 	FIB structure for forwarding.
> 
> We are using standard routing in HA to route packets intercepted by HA to
> MN through a tunnel device.  However, HA needs to also act as a neighbor
> discovery proxy for MN and not tunnel any ND packets destined to MN, but
> reply to them on the bahalf of MN. We use the netfilter hook to check for
> ND packets with global addresses that would be otherwise tunneled and feed
> them directly to the local processing code.

I believe that netfilter is not appropriate here.
If it is protocol requirement, do it in the stack itself.

Well, HA is router. 

Sending side: Make mip6_forward().
              When new MN is being registered, setup proxy ndisc and 
              make routes to MN via mip device (which is mip tunnel),
              which actually calls mip6_foward().
              When packet arrives, it checks MNs and forward it to it.
Receiving side: 
              mipl tunnel receives packets from MN.
              check source address according to the list of MNs,
	      then forward it.

Also, I believe that the binding information should be hold as FIB entry.

--yoshfuji
