Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUF1RF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUF1RF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUF1RF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:05:26 -0400
Received: from [203.178.140.15] ([203.178.140.15]:42249 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265091AbUF1RFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:05:19 -0400
Date: Tue, 29 Jun 2004 02:06:27 +0900 (JST)
Message-Id: <20040629.020627.76560474.yoshfuji@linux-ipv6.org>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: 2.6.6: IPv6 initialisation bug
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040628010200.A15067@flint.arm.linux.org.uk>
References: <20040628010200.A15067@flint.arm.linux.org.uk>
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

In article <20040628010200.A15067@flint.arm.linux.org.uk> (at Mon, 28 Jun 2004 01:02:01 +0100), Russell King <rmk+lkml@arm.linux.org.uk> says:

> Ok, I've just tried 2.6.7 out on my root-NFS'd firewall with IPv6 built
> in, and it doesn't work because of the problem I described below.
:
> What's the solution?

Bring lo up before bring others up.
What does prevent you from doing this?
(Do we need some bits to do this automatically?)


> Is there a good reason why IPv6 uses the loopback device for local
> routes?

IPv6 creates kernel routes for local addresses on lo to receive
packets for local address.

Well, someone probably wants to have
static local routes on ethX + temprary (cache) local routes on lo
(as IPv4 does; correct me if I'm wrong.)

But this won't work because IPv6 does DAD when we make some interface up.
We need lo anyway.

--yoshfuji

