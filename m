Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTETGBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTETGBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:01:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263587AbTETGBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:01:40 -0400
Date: Mon, 19 May 2003 23:13:19 -0700 (PDT)
Message-Id: <20030519.231319.91314647.davem@redhat.com>
To: mbligh@aracnet.com
Cc: haveblue@us.ibm.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <88560000.1053409990@[10.10.2.4]>
References: <20030520034622.GK8978@holomorphy.com>
	<1053407030.13207.253.camel@nighthawk>
	<88560000.1053409990@[10.10.2.4]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Mon, 19 May 2003 22:53:11 -0700

   I have no frigging idea why you'd want to tear something out that
   works well already, and has a shitload of work put into it. 
   
It's pretty fundamentally broken for having had so much work
put into it.  Show me something other than "SpecWEB run for IBM
ran faster" as a reason for keeping this code in there.  Can you
even do this?

It is crap, from the very beginning, would you like to know why?

How does the in-kernel IRQ load balancing measure "load" and
"busyness"?  Herein lies the most absolutely fundamental problem with
this code, it fails to recognize that we end up with most of our
networking "load" from softint context.

We can process thousands of packets for one hardware interrupt.  Are
you able to comprehend this?

Measuring hardware interrupts in some was as "load" is about
as far from the truth as you can get.

This is just the tip of the iceberg.

rm -rf in-kernel-irqbalance;

And hey, if _YOU_ want a broken system which uses this bogus algorithm,
YOU CAN DO THIS with the userland thing if you want.
