Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbRDQMdh>; Tue, 17 Apr 2001 08:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDQMd1>; Tue, 17 Apr 2001 08:33:27 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:8683 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S132526AbRDQMdT>; Tue, 17 Apr 2001 08:33:19 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B271DB@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: change_mtu boundary checking error
Date: Tue, 17 Apr 2001 05:29:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Going through the change_mtu() code in the kernel, I came across the default
function supplied when calling ether_setup().
I could see that eth_change_mtu() (drivers/net/net_init.c) does the
following:

	if( (new_mtu < 68) || (new_mtu > 1500) )
		return -EINVAL;

Looking in include/linux/if_ether.h I found the following constants:
#define ETH_ALEN		6	/* Octets in one ethernet addr */
#define ETH_HLAN		14	/* Total octets in header. */
#define ETH_ZLEN		60	/* Min. octets in frame sans FCS */
#define ETH_DATA_LEN		1500	/* Max. octets in payload */
#define ETH_FRAME_LEN	1514	/* Max. octets in frame sans FCS */


Now, the high boundary seemed reasonable (ETH_FRAME_LEN - ETH_HLEN =
ETH_DATA_LEN) which gives 1500, but why is the low boundary set to 68 ?
According to my calculations, it should have been ETH_ZLEN - ETH_HLEN which
gives 46.

Doesn't mtu means only the payload size ?
Where did the 68 come from ?


	Thanks,
	Shmulik Hen
	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)


