Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319100AbSIJLvH>; Tue, 10 Sep 2002 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSIJLvG>; Tue, 10 Sep 2002 07:51:06 -0400
Received: from ns.ithnet.com ([217.64.64.10]:1040 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S319100AbSIJLvB>;
	Tue, 10 Sep 2002 07:51:01 -0400
Date: Tue, 10 Sep 2002 13:55:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: torvalds@transmeta.com, mingo@elte.hu, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] per isr in_progress markers
Message-Id: <20020910135533.77f0b182.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.33.0209091151200.14841-100000@penguin.transmeta.com>
	<Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002 21:37:42 +0200 (SAST)
Zwane Mwaikambo <zwane@mwaikambo.name> wrote:

> > (Btw, if there is, that would also allow us to notice the "constantly
> > screaming PCI interrupt" without help from the low-level isrs)
> 
> As an aside, i just had an idea for another way to improve interrupt 
> handling latency. Instead of walking through all the isrs in the chain, 
> we can have an isr flag wether it was the source of the irq, and if so we 
> stop right there and not walk through the other isrs. Obviously taking 
> into account that some devices are dumb and have no real way of 
> determining.
> 
> 	Zwane

Hello,

a short note on that: this proved to be a particularly bad idea back in the
amiga-days. All that happened with this idea (Amiga which has basically only 2
usable interrupts has heavy interrupt sharing) is that every good programmer
told the system that it was not the source of the ongoing interrupt - even if
it was - because otherwise you lost interrupts in heavy-load environment.
Shared interrupts _can_ work well, but you have to do short interrupt-routines
and don't mess the thing by over-intelligent (in fact non-atomic) operation.

Regards,
Stephan


> 
> -- 
> function.linuxpower.ca
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
