Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWANJva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWANJva (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWANJva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:51:30 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:10257 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751213AbWANJva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:51:30 -0500
Date: Sat, 14 Jan 2006 18:52:13 +0900 (JST)
Message-Id: <20060114.185213.131923397.yoshfuji@linux-ipv6.org>
To: pavel@ucw.cz
Cc: davem@davemloft.net, drepper@redhat.com, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: ntohs/ntohl and bitops
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20060112010406.GA2367@ucw.cz>
References: <43C42F0C.10008@redhat.com>
	<20060111.000020.25886635.davem@davemloft.net>
	<20060112010406.GA2367@ucw.cz>
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

In article <20060112010406.GA2367@ucw.cz> (at Thu, 12 Jan 2006 01:04:06 +0000), Pavel Machek <pavel@ucw.cz> says:

> 
> On Wed 11-01-06 00:00:20, David S. Miller wrote:
> > From: Ulrich Drepper <drepper@redhat.com>
> > Date: Tue, 10 Jan 2006 14:02:52 -0800
> > 
> > > I just saw this in a patch:
> > > 
> > > +               if (ntohs(ih->frag_off) & IP_OFFSET)
> > > +                       return EBT_NOMATCH;
> > > 
> > > This isn't optimal, it requires a byte switch little endian machines.
> > > The compiler isn't smart enough.  It would be better to use
> > > 
> > >      if (ih->frag_off & ntohs(IP_OFFSET))
:
> Could you possibly 
> #define IP_OFFSET htons(1234)
> ?

In this case, you should use __constant_htons().
I still prefer:
   if (ih->frag_off & htons(IP_OFFSET))
though.

--yoshfuji
