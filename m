Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVAPKHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVAPKHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVAPKHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:07:09 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:25750 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262469AbVAPKHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:07:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IhDfzP8uSYEd9duz90XZsAGrNOMmYx+t/FKtYKi5RbVwoh7fxyRzey0VussHvFqeytigpDH9h1JawEk4nTu0bgSVlE8hJw0aN1C4hLu2kipskm4rxSnYJdaHtoBNWPddhW+VKfHaYw0SIh7xtYZ2y9kncu+iBgy3WigEI/KscJY=
Message-ID: <4d6522b90501160206306b0140@mail.gmail.com>
Date: Sun, 16 Jan 2005 12:06:59 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: User space out of memory approach
Cc: Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105630523.4644.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105630523.4644.52.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Alan...

> > well looking into Alan's email again I think I answered thinking on
> > the wrong side :-) that the suggestion was to switch off OOM
> > altogether and be done with all the discussion... tsk tsk tsk too
> > defensive and hasty I guess :-)
> 
> Thats what mode 2 is all about. There are some problems with over-early
> triggering of OOM that Andrea fixed that are still relevant (or stick
> "never OOM if mode == 2" into your kernel)
> 
> > Did I get it right this time Alan?
> 
> Basically yes - the real problem with the OOM situation is there is no
> correct answer. People have spent years screwing around with the OOM
> killer selection logic and while you can make it pick large tasks or old
> tasks or growing tasks easily nobody has a good heuristic about what to
> die because it depends on the users wishes. OOM requires AF_TELEPATHY
> sockets and we don't have them.
>
> 
> For most users simply not allowing the mess to occur solves the problem
> - not all but most.
> 

What do you think about the point we are trying to make, i.e., moving the
ranking of PIDs to be killed to user space? Or, making user have some influence
on it? We were misunderstood because the patch we sent was to make "a slight"
organization in the way OOM killer compute rates to PIDs, not to change its
selection logic. But now, we can discuss (I mean implement)
alternative selection
logics without messing the code at kernel space. The parameters and
criteria on how
to combine them can be open to more people test it according to platform and, if
not user, at least according to application memory consumpition pattern.

Well, while AF_TELEPATH socket is not on its way :) ... we may at
least experiment
different raking policies.

br

Edard
 

-- 
"In a world without fences ... who needs Gates?"
