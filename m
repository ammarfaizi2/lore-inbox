Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWHLUnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWHLUnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWHLUnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:43:00 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:8455 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932608AbWHLUm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:42:59 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Daniel <damage@rooties.de>
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 21:43:04 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608122140.44365.damage@rooties.de> <200608122115.08419.s0348365@sms.ed.ac.uk> <200608122226.26516.damage@rooties.de>
In-Reply-To: <200608122226.26516.damage@rooties.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122143.04859.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 23:26, Daniel wrote:
> Oh, sorry I have forgotten to tell:
>
> drunken init # lspci |grep Prism
> 00:08.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism
> Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)
>
> So I'm using the prism54 driver (CONFIG_PRISM54). My version of
> wireless-tools is 29_pre10 and the version of the used firmware is 1.0.4.3.

I noticed you have the mode set to Master, is this intentional?

I've found my Prism54 (which is an older model, but the same firmware) 
requires me to ifconfig up before I can set iwconfig parameters correctly.

The only changes I can see to the prism driver in 2.6.16 are:

--- a/drivers/net/wireless/prism54/isl_ioctl.c
+++ b/drivers/net/wireless/prism54/isl_ioctl.c
@@ -748,7 +748,7 @@ prism54_get_essid(struct net_device *nde
 	if (essid->length) {
 		dwrq->flags = 1;	/* set ESSID to ON for Wireless Extensions */
 		/* if it is to big, trunk it */
-		dwrq->length = min(IW_ESSID_MAX_SIZE, essid->length + 1);
+		dwrq->length = min((u8)IW_ESSID_MAX_SIZE, essid->length);
 	} else {
 		dwrq->flags = 0;
 		dwrq->length = 0;
--- a/drivers/net/wireless/prism54/islpci_eth.c
+++ b/drivers/net/wireless/prism54/islpci_eth.c
@@ -177,7 +177,7 @@ islpci_eth_transmit(struct sk_buff *skb,
 #endif
 
 			newskb->dev = skb->dev;
-			dev_kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			skb = newskb;
 		}
 	}

Both very minor changes. What was the last kernel that worked? Have you tried  
with acpi=off? Is this a PCI or PCMCIA card?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
