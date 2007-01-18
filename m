Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbXARWMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXARWMt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbXARWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:12:49 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:55461 "EHLO
	ginger.cmf.nrl.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601AbXARWMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:12:49 -0500
X-Greylist: delayed 1270 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 17:12:48 EST
Message-Id: <200701182151.l0ILpEnF024936@cmf.nrl.navy.mil>
To: Andrew Walrond <andrew@walrond.org>
cc: LKML <linux-kernel@vger.kernel.org>
Reply-To: chas3@users.sourceforge.net
Subject: Re: Kernel headers - linux-atm userspace build broken by recent change; __be16 undefined 
In-reply-to: <45AFE52C.30308@walrond.org> 
Date: Thu, 18 Jan 2007 16:51:14 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-9.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it might be that the userspace code shouldnt be including if_arp.h.
can you try that instead?

In message <45AFE52C.30308@walrond.org>,Andrew Walrond writes:
>Don't know exactly when this change went in, but it's not in 2.6.18.3 
>and is in 2.6.19.2+
>
>  $ diff linux/include/linux/if_arp.h linux-2.6/include/linux/if_arp.h
>133,134c133,134
><       unsigned short  ar_hrd;         /* format of hardware address   */
><       unsigned short  ar_pro;         /* format of protocol address   */
>---
> >       __be16          ar_hrd;         /* format of hardware address   */
> >       __be16          ar_pro;         /* format of protocol address   */
>137c137
><       unsigned short  ar_op;          /* ARP opcode (command)         */
>---
> >       __be16          ar_op;          /* ARP opcode (command)         */
>
>
>This causes the linux-atm userspace compile to fail like this:
>
>In file included from arp.c:19:
>/usr/include/linux/if_arp.h:133: error: expected 
>specifier-qualifier-list before '__be16'
>
>I guess if_arp.h needs to include include/linux/byteorder/big_endian.h?
>
>Andrew Walrond
