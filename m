Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVIDSuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVIDSuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 14:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVIDSuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 14:50:54 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:4558 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751004AbVIDSux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 14:50:53 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
Subject: Re: R: [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 19:51:00 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDCEIIEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDCEIIEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041951.00822.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 19:36, Giampaolo Tomassoni wrote:
[snip]
>
> This may be true for AAL5 support, which is the way by which data is
> actually transferred between ADSL DSLAMs and CPE equipment.
>
> This may not be generally true, however: most providers are already
> delivering internet+voice solutions over ADSL channels (here in Italy, in
> example, Telecom offers Alice Mia, which is an ADSL line with internet
> access and VoIP for added voice capabilities). Albeit the voice part of
> these solutions are actually based on VoIP technology, it is not the best
> way to do this. In the future, I believe we will easily see internet +
> voice sols based over AAL5 + AAL2/3, or even multi voice channels over
> AAL2/3 over ADSL (replacing ISDN PRIs and multi-BRIs -based lines for PABX
> connection).
>
> When (and if) that will happen, we will probabily need a kernel-based
> solution since cell timing and QoS is a much stricter requirement with
> non-AAL5 encodings, such that it is easier to attain from inside the kernel
> than from userland.
>
> So, I'm not that shure all the ATM code is to be stripped out of the
> kernel. Maybe it can be done with the PPPoATM network interface. But
> probably it can't be done with the ATM core and the ATM SAR code. Wherever
> the latter will be in ATMUSB, in ATMSAR or in a device driver.

The above is a decent technical justification for why the code is generally 
required; it's set my mind at rest, I thought maybe this was only for the 
speedtouch modem crew.

I was aware of ATM's ability to interleave data and "digital voice" services; 
ATM is widely deployed across Europe in preparation for "pure digital" 
consumer telephony..

My primary concern with the ATM code is that it's not (yet) an often used part 
of the kernel; there are a number of viable applications out there, but most 
can happily use linux-atm and/or pppd. I can see VoIP clients doing the same.

However, for embedded or non-pure-client purposes, there's a reason for an 
in-kernel implementation.

I don't know enough about the applications of the "ATM stack" versus using a 
userspace library, so I think as long as the patch is cleaned up and can be 
reused, it's okay to put in the kernel.

>
> The PPPoATM module is a network interface. It stays on the other side of
> the ATM world: [netif] <-> [PPPoATM] <-> [atmif] <-> [ATM] <-> [ATMSAR] <->
> [device driver]. I'm not a PPPoATM expert, but it may probably be possible
> to have all the PPPoATM code in userland. But the [ATM] <-> [ATMSAR] <->
> [device driver] chain is probably too close to hardware to gain any benefit
> by "userlanding" it.
>

I agree, if there are users beyond the speedtouch modem, it may make sense to 
have this code in the kernel. Thanks for fielding my questions.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
