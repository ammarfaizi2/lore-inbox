Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUGIT7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUGIT7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUGIT7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:59:17 -0400
Received: from [203.178.140.15] ([203.178.140.15]:40964 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265833AbUGIT7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:59:06 -0400
Date: Sat, 10 Jul 2004 04:59:04 +0900 (JST)
Message-Id: <20040710.045904.106621629.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: bastian@waldi.eu.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040709123005.086fdfc5.davem@redhat.com>
References: <20040709120336.74e57ceb.akpm@osdl.org>
	<20040709192253.GA11138@wavehammer.waldi.eu.org>
	<20040709123005.086fdfc5.davem@redhat.com>
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

In article <20040709123005.086fdfc5.davem@redhat.com> (at Fri, 9 Jul 2004 12:30:05 -0700), "David S. Miller" <davem@redhat.com> says:

> On Fri, 9 Jul 2004 21:22:53 +0200
> Bastian Blank <bastian@waldi.eu.org> wrote:
> 
> > The original submission is recorded on
> > http://marc.theaimsgroup.com/?l=linux-net&m=104551077013011&w=2. And the
> > complaint was that it puts '"ipv6 stuff" into the generic netdevice
> > structure'. I don't know if this can be solved another way.
> 
> Put it in the inet6device private area.

David, inet6device area is created when we create first address.
The first address is likely link-local address based on
mac address, and kernel detects address duplication and 
delete the inet6device.  Finally, we don't have inet6device.

> It's been a year, and you haven't put forth the effort to look
> for solutions like that?

I'd suggest following approach.
 1. support up/down via netlink interface.
 2. add IFLA_IFID (or something like that) (RTM_NEWLINK attribute)
    inet6 layer create inet6device without an address
    when receiving this.

User will be able to do
 # ip link eth0 up eui64 de:ad:be:ef:ca:fe:ba:be
or something like this.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
