Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbUCZSmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUCZSmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:42:08 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:25035 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S264116AbUCZSl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:41:59 -0500
Date: Fri, 26 Mar 2004 19:41:42 +0100
From: Robert Schwebel <robert@schwebel.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326184142.GF16461@pengutronix.de>
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de> <40646C2B.6020306@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40646C2B.6020306@pacbell.net>
User-Agent: Mutt/1.4i
X-Scan-Signature: a16e8366fd9e318f9bc95bac572a1f5e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 09:45:15AM -0800, David Brownell wrote:
> >We have tried that, Windows does not like it. The only constellation
> >where it worked was setting the device descriptor's bConfigClass=0x02. 
> 
> Sorry, I meant "device" descriptors.  Yes, I noticed their "spec"
> had strange things to say.  Is there some reason you're not including
> the CDC header and union descriptors?  That spec does talk about those,
> and the erratum I found also talks about better CDC ACM conformance.

USB_CLASS_COM is surely ok. The descriptors may be a relict from the
time where the CDC equivalents where not in the driver... 

The problem is that, as it is now, it works. The whole RNDIS stuff is
extremely time intensive to debug: when you have one odd value in some
place, Windows just says "Error 10" and you have to guess what you did
wrong. No further information available. So the best way to be
successful may be to check it in as it is, maybe add some FIXMEs, and
let the masses test the code. Then cleanup the remaining issues step by
step and wait until nobody crys any more :-) 

> Different topic:  I noticed that on PXA you were using "ep5-int".
> That's documented as always using DATA0 -- data toggle not working.
> Was that making any trouble for you?  I've never actually tried
> using those endpoints, because of that functional limitation.

Well, there is no other interrupt endpoint on the PXA, and it somehow
works :-) 

> Also it looks like you've only tested this on PXA hardware.

It was hard enough :-) 

> Most of the patch is the (R)NDIS support code, which is easy
> to merge, but the "g_ether" updates will take longer.

Ok. We have tried to make the design as minimal-invasive as possible... 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
