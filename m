Return-Path: <linux-kernel-owner+w=401wt.eu-S1751487AbXARVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXARVWz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXARVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:22:55 -0500
Received: from [195.171.73.133] ([195.171.73.133]:33858 "EHLO
	pelagius.h-e-r-e-s-y.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751422AbXARVWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:22:55 -0500
Message-ID: <45AFE52C.30308@walrond.org>
Date: Thu, 18 Jan 2007 21:22:52 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Kernel headers - linux-atm userspace build broken by recent change;
 __be16 undefined
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know exactly when this change went in, but it's not in 2.6.18.3 
and is in 2.6.19.2+

  $ diff linux/include/linux/if_arp.h linux-2.6/include/linux/if_arp.h
133,134c133,134
<       unsigned short  ar_hrd;         /* format of hardware address   */
<       unsigned short  ar_pro;         /* format of protocol address   */
---
 >       __be16          ar_hrd;         /* format of hardware address   */
 >       __be16          ar_pro;         /* format of protocol address   */
137c137
<       unsigned short  ar_op;          /* ARP opcode (command)         */
---
 >       __be16          ar_op;          /* ARP opcode (command)         */


This causes the linux-atm userspace compile to fail like this:

In file included from arp.c:19:
/usr/include/linux/if_arp.h:133: error: expected 
specifier-qualifier-list before '__be16'

I guess if_arp.h needs to include include/linux/byteorder/big_endian.h?

Andrew Walrond
