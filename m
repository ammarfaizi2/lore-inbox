Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHAVEo>; Thu, 1 Aug 2002 17:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHAVEo>; Thu, 1 Aug 2002 17:04:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:20495 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S317066AbSHAVEk>;
	Thu, 1 Aug 2002 17:04:40 -0400
Date: Thu, 1 Aug 2002 23:07:45 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy TARREAU <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solved APM bug with -rc5
Message-ID: <20020801210745.GA20387@alpha.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local> <20020801152459.GA19989@alpha.home.local> <1028220826.14865.69.camel@irongate.swansea.linux.org.uk> <20020801203520.GA244@pcw.home.local> <1028240183.15022.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028240183.15022.99.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 11:16:23PM +0100, Alan Cox wrote:
> On Thu, 2002-08-01 at 21:35, Willy TARREAU wrote:
> > +	while (cpu_number_map(smp_processor_id()) != 0) {
> > +		schedule();
> > +	}
 
> What guarantees that loop will ever exit ?

none, as in the already existing other implementation. But at least, I'd
prefer an infinite loop instead of some random code being executed without
noticing it.

Do you know a better way of doing that ? The other implementation
used a fake thread which also did a schedule(). I wonder if this
is to make the scheduler work a bit more so that we get more
chances to swap the CPU.

Cheers,
Willy

