Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTIEPg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTIEPg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:36:27 -0400
Received: from babsi.intermeta.de ([212.34.184.3]:64260 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP id S262803AbTIEPgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:36:23 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Henning Schmiedehausen <hps@intermeta.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <874qzrsljc.fsf@deneb.enyo.de>
References: <20030830230701.GA25845@work.bitmover.com>
	 <87llt9bvtc.fsf@deneb.enyo.de> <bj1fhj$its$4@tangens.hometree.net>
	 <874qzrsljc.fsf@deneb.enyo.de>
Content-Type: text/plain
Organization: INTERMETA - Gesellschaft  =?ISO-8859-1?Q?=20f=C3=BCr?= Mehrwertdienste mbH
Message-Id: <1062776157.20632.1697.camel@forge.intermeta.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Sep 2003 17:35:57 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.2 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 10:10, Florian Weimer wrote:

> > You need a shaper connected to the ISP backbone which shapes the
> > outgoing traffic for you and a border router which talks to the T1
> > (C17xx or C26xx). Normally, if your ISP has some sort of clue, you
> > will also need a bastion router which can handle backbone <-> 100 MBit
> > traffic and does dynamic routing updates (EGP or OSPF) to the ISP
> > backbone (A C26xx or C37xx).
> 
> C37xx can handle a maximum load of 225 kpps (data sheet number,
> i.e. this value cannot be exceeded even under most favorable
> conditions), the others handle even less.  Such routers are of no help
> during a DoS attack.
> 
> Yes, I snipped the DoS context, and your approach would work in a
> benign environment. 8-)

225kpps * 64 Bytes (minimum packet len) = 13,7 MBytes / sec

100 MBit / 8 bit = 12,5 MBytes / sec

So, IMHO even with a small packet saturated 100 MBit link you won't
reach 225kpps. AFAIK this was Ciscos intention to publish this number.
It basically says "you will have filled your link before you fill our
router". 

I'm pretty sure that your 37xx won't do any routing updates anymore at
this point. And if you do _anything_ that forces the packets down the
slow path from the routing engine, you're toast anyway.

But I'm pretty sure that a C37xx would handle full 100 MBit traffic to a
busy website without any problems. In fact, I know that it does. ;-) (We
did switch to a C12000 shortly after, mainly because we went Gigabit).

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)

