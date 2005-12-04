Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVLDB3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVLDB3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVLDB3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:29:16 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:57424 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750785AbVLDB3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:29:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=urWSdbH9cIV1Yh0MOp4gW0kwgwEdc8B8t8SIe3d+2ZlsQ/wVRYQhRS+SUkoJZnuy76PhmGCHQRbzxvPF092FPrJBnCAc4Kydwg7YsnzMa0Gu/cDl4/THfS5MN6R0eFz/qa1THIgnYMNI3pT45yslqj8b5Wk8EFJ+nqZzmb+RW5w=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 00/43] ktimer reworked
Date: Sat, 3 Dec 2005 20:28:57 -0500
User-Agent: KMail/1.8.3
Cc: Roman Zippel <zippel@linux-m68k.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512011828150.1609@scrub.home> <1133464097.7130.15.camel@localhost.localdomain>
In-Reply-To: <1133464097.7130.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512032028.59472.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 14:08, Steven Rostedt wrote:
> On Thu, 2005-12-01 at 18:44 +0100, Roman Zippel wrote:
> > Hi,
> > 
> > On Thu, 1 Dec 2005, Russell King wrote:
> ...
> > > Hence, timers have the implication that they are _expected_ to expire.
> > > Timeouts have the implication that their expiry is an exceptional
> > > condition.
> > 
> > IOW a timeout uses a timer to implement an exceptional condition after a 
> > period of time expires.
> > 
> > > So can we stop rehashing this stupid discussion?
> > 
> > The naming isn't actually my primary concern. I want a precise definition 
> > of the expected behaviour and usage of the old and new timer system. If I 
> > had this, it would be far easier to choose a proper name.
> > E.g. I still don't know why ktimeout should be restricted to raise just 
> > "error conditions", as the name implies.
> > 
> 
> ktimeout may not need to be restricted to anything.

     But does it make sense to use it in any other circumstances? It sounds
like the rb-tree based ktimer system is suitable for the general case. So
you can have a simple rule: use ktimeout for timing out when an expected
event doesn't occur, and ktimer for everything else. Are there any
situations where you want a timer optimized for the removal case that is not
also monotonic and low-res? And are there any situations in practice other
than the "timeout" one where you'd want to use a timer wheel instead of a
rb-tree?

    It sounds to me that the ktimer should be the general case, leaving
ktimeout to be optimized for one particular case (by e.g. decreasing the
resolution to reduce cascades).

Andrew Wade
