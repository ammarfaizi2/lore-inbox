Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVIDSgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVIDSgg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVIDSgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 14:36:36 -0400
Received: from smtp0.libero.it ([193.70.192.33]:20198 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S932078AbVIDSgf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 14:36:35 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>,
       "Giampaolo Tomassoni" <g.tomassoni@libero.it>
Cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: R: [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 20:36:18 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDCEIIEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200509041720.55588.s0348365@sms.ed.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: Alistair John Strachan [mailto:s0348365@sms.ed.ac.uk]
> Inviato: domenica 4 settembre 2005 18.21
> 
> ...omissis...
> 
> Just out of curiosity, is there ANY reason why this has to be done in the 
> kernel? The PPPoATM module for pppd implements (via linux-atm) a 
> completely 
> userspace ATM decoder.. if anything, now redundant ATM stack code 
> should be 
> REMOVED from Linux!

This may be true for AAL5 support, which is the way by which data is actually transferred between ADSL DSLAMs and CPE equipment.

This may not be generally true, however: most providers are already delivering internet+voice solutions over ADSL channels (here in Italy, in example, Telecom offers Alice Mia, which is an ADSL line with internet access and VoIP for added voice capabilities). Albeit the voice part of these solutions are actually based on VoIP technology, it is not the best way to do this. In the future, I believe we will easily see internet + voice sols based over AAL5 + AAL2/3, or even multi voice channels over AAL2/3 over ADSL (replacing ISDN PRIs and multi-BRIs -based lines for PABX connection).

When (and if) that will happen, we will probabily need a kernel-based solution since cell timing and QoS is a much stricter requirement with non-AAL5 encodings, such that it is easier to attain from inside the kernel than from userland.

So, I'm not that shure all the ATM code is to be stripped out of the kernel. Maybe it can be done with the PPPoATM network interface. But probably it can't be done with the ATM core and the ATM SAR code. Wherever the latter will be in ATMUSB, in ATMSAR or in a device driver.

The PPPoATM module is a network interface. It stays on the other side of the ATM world: [netif] <-> [PPPoATM] <-> [atmif] <-> [ATM] <-> [ATMSAR] <-> [device driver]. I'm not a PPPoATM expert, but it may probably be possible to have all the PPPoATM code in userland. But the [ATM] <-> [ATMSAR] <-> [device driver] chain is probably too close to hardware to gain any benefit by "userlanding" it.


> 
> ...omissis...
> 
> 
> -- 
> Cheers,
> Alistair.

Cheers,

	giampaolo

