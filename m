Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbTL3PC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbTL3PC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 10:02:27 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:40367 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S265807AbTL3PCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 10:02:25 -0500
Message-Id: <200312301502.hBUF23Rr028832@ginger.cmf.nrl.navy.mil>
To: Duncan Sands <baldrick@free.fr>
cc: Muli Ben-Yehuda <mulix@mulix.org>, "Sirotkin, Alexander" <demiurg@ti.com>,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [Linux-ATM-General] Re: network driver that uses skb destructor 
In-Reply-To: Message from Duncan Sands <baldrick@free.fr> 
   of "Tue, 30 Dec 2003 10:48:06 +0100." <200312301048.06261.baldrick@free.fr> 
Date: Tue, 30 Dec 2003 10:02:04 -0500
From: chas williams (contractor) <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-6.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i wouldnt think skb chaining is absolutely necessary.  if your driver/layer
needs a copy of the data within the skb, it should call skb_clone.  this
lets your layer do whatever it needs with the skb headers et al while not
making copies of the data right?

In message <200312301048.06261.baldrick@free.fr>,Duncan Sands writes:
>> I wrote a patch to allow chaining of skb destructors, which was fairly
>> simple and would allow both the driver and the upper layers to set
>> their destructors. If there's any interet, I could probably resurrect
>> it.
>
>It may also be useful for the ATM layer.  At the moment there is a
>vcc->pop routine that frees skb's, it should really be a destructor.
>Check out this email:
>	http://www.atm.tut.fi/list-archive/linux-atm/msg05485.html
>However AFAICS destructors would need to be chained.
>
>Duncan.
