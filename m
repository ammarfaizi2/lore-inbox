Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264828AbSJaKml>; Thu, 31 Oct 2002 05:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbSJaKmk>; Thu, 31 Oct 2002 05:42:40 -0500
Received: from tml.hut.fi ([130.233.44.1]:21778 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S264828AbSJaKmQ>;
	Thu, 31 Oct 2002 05:42:16 -0500
Date: Thu, 31 Oct 2002 12:44:00 +0200 (EET)
From: Henrik Petander <lpetande@morphine.tml.hut.fi>
To: Noriaki Takamiya <takamiya@po.ntts.co.jp>
cc: ajtuomin@morphine.tml.hut.fi, <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <yoshfuji@wide.ad.jp>, <pekkas@netcore.fi>, <torvalds@transmeta.com>,
       <jagana@us.ibm.com>
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
In-Reply-To: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
Message-ID: <Pine.GSO.4.44.0210311232310.18909-100000@morphine.tml.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noriaki,

On Thu, 31 Oct 2002, Noriaki Takamiya wrote:

> Hi,
>
>   This is Takamiya, a member of USAGI Project.
>   Your work is very cool.
Thanks.

>
>   Please note that we're preparing for checking to what extent this
>   patch is compliant to the Internet draft of MIPv6.

We are interested in seeing the results, especially if the tests are based
on the draft19, which ought to be published soon based on the discussions
in the mobile-ip mailing list.

>
> (2) Avoiding Netfilter Hooks
> 	In your imprementation HA uses netfilter to intercept packets
> 	sent to MN. We think it is costy so we have a suggestion to
> 	use FIB structure to forward packets to MN. Bacause we think
> 	forwarding packets from HA to MN is FORWARDING, not FILTERING.
> 	We think the kernel maintainers may prefer such a manner using
> 	FIB structure for forwarding.

We are using standard routing in HA to route packets intercepted by HA to
MN through a tunnel device.  However, HA needs to also act as a neighbor
discovery proxy for MN and not tunnel any ND packets destined to MN, but
reply to them on the bahalf of MN. We use the netfilter hook to check for
ND packets with global addresses that would be otherwise tunneled and feed
them directly to the local processing code.

Thanks,

Henrik Petander

		----------------------------------
		Henrik Petander
		Helsinki University of Technology,
		GO/Core Project
		Henrik.Petander@hut.fi
		Office: +358 (0)9 451 5846
		GSM: +358 (0)40 741 5248
		----------------------------------

