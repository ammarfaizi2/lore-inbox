Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTBQSPx>; Mon, 17 Feb 2003 13:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBQSPw>; Mon, 17 Feb 2003 13:15:52 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:14772 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267263AbTBQSPv>;
	Mon, 17 Feb 2003 13:15:51 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200302171825.VAA31465@sex.inr.ac.ru>
Subject: Re: IPSec: AH/ESP combination problems
To: toml@us.ibm.com (Tom Lendacky)
Date: Mon, 17 Feb 2003 21:25:38 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <3E4AD852.4060300@us.ibm.com> from "Tom Lendacky" at Feb 12, 3 05:27:14 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Problem #1: AH/ESP Tunnel mode input [IP-outer][AH][ESP][IP-inner]
> 
> When processing the input in xfrm4_rcv in xfrm_input.c, a check
> is made after processing the AH header to determine if the policy
> specified tunnel mode.  If tunnel mode was specified, then a
> check is made to see if the next header is an IP header.  If it
> is not an IP header then the packet is dropped.  However, if
> ESP tunnel mode has also been applied to the packet the next
> header will be the ESP header which must first be decrypted.

If you make this you want to get:

AH - IPIP - ESP - IPIP.



> Problem #2: AH/ESP Tunnel mode output [IP-outer][AH][ESP][IP-inner]
> 
> When creating the output for an AH header in ah_output of ah.c,
> a check is made to see if the policy specified tunnel mode.  If
> tunnel mode is specified, then an IPIP header is added after the AH
> header. 

The same as above.


> Problem #3: RFC 2401 order of AH and ESP headers
> 
> According to RFC 2401, if both AH and ESP headers are to be
> applied in transport mode,

It is not kernel problem and even not a problem of setkey, we allow to apply
arbitrary transformations in arbitrary order.

Alexey
