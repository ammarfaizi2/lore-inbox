Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319219AbSIJP1U>; Tue, 10 Sep 2002 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319551AbSIJP1U>; Tue, 10 Sep 2002 11:27:20 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:42990
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319219AbSIJP1T>; Tue, 10 Sep 2002 11:27:19 -0400
Subject: Re: [PATCH][RFC] per isr in_progress markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@mwaikambo.name>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <11228.1031670308@redhat.com>
References: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain>
	  <11228.1031670308@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 16:32:35 +0100
Message-Id: <1031671955.1537.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 16:05, David Woodhouse wrote:
> 
> mingo@elte.hu said:
> >  this is something i have a 0.5 MB patch for that touches a few
> > hundred drivers. I can dust it off if there's demand - it will break
> > almost nothing because i've done the hard work of adding the default
> > 'no work was done' bit to every driver's IRQ handler. 
> 
> Note that you can also survive IRQ storms this way -- if all handlers 
> returned 'no work was done' and you get over $N irqs per second, disable 
> that IRQ for a while.

You can do that without touching any drivers and its better that way

Firstly the "no work was done" check is insufficient if work is being
done but the IRQ rate is too high to keep up.

Secondly the check means mangling all the drivers when you can establish
if work was done anyway by checking bh/userspace has also had some run
time.

I'm all for surviving IRQ storms on a level triggered IRQ, but do it
purely on interrupt rate and measured system progress not on some
assumption that the driver knows what its doing.

