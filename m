Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTE3Gb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTE3Gb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:31:58 -0400
Received: from ftp-xb.sasken.com ([164.164.56.3]:15346 "EHLO
	sandesha.sasken.com") by vger.kernel.org with ESMTP id S263302AbTE3Gb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:31:57 -0400
Date: Fri, 30 May 2003 12:19:54 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: variable dev->hard_header_len 
Message-ID: <Pine.LNX.4.33.0305301209520.18077-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi

I am trying to write a driver on linux-2.4.19. My hardware requires that
the packets going out should be VLAN tagged and coming in might/might not
have a tag. I have written a new hard_header function for this and set the
hard_header_len to ETH_HLEN+VLAN_HLEN. But, when a packet is received
without a tag, the eth_type_trans function is removing the first
ETH_HLEN+VLAN_HLEN bytes, as the hard_header_len is this much. so, the
packets are not being understood by the upper layers properly.

I changed the eth_type_trans function code as follows:

	if the device is my device
	        skb_pull(skb,ETH_HLEN);
	else
	        skb_pull(skb,dev->hard_header_len);

Could anyone tell me if it is going to affect any other functionality?

Could someone suggest some cleaner solution for my problem?

Thanks & regards
Madhavi.

Madhavi Suram
Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

************************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
