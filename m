Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316237AbSEKSbN>; Sat, 11 May 2002 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSEKSbM>; Sat, 11 May 2002 14:31:12 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:35333 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316237AbSEKSbL>; Sat, 11 May 2002 14:31:11 -0400
Date: Sat, 11 May 2002 20:30:59 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1/6: 64 bit jiffies
In-Reply-To: <200205111815.g4BIF0Y02586@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0205112022030.29302-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Denis Vlasenko wrote:

> On 11 May 2002 08:25, Tim Schmielau wrote:
> > +static inline void init_jiffieswrap_timer(void)
> > +{
> > +	init_timer(&jiffieswrap_timer);
> > +	jiffieswrap_timer.expires = jiffies + CHECK_JIFFIESWRAP_INTERVAL;
> > +	jiffieswrap_timer.function = check_jiffieswrap;
> > +	add_timer(&jiffieswrap_timer);
> > +}
> 
> I'm ignorant on the issue... does active timer mandate check for
> expiration at every timer tick? 

No, timers are implemented in a highly efficient manner. The above
timer will just add O(1) cost to 4 table refills, meaning some 100 cycles 
per quarter of a year.

> If yes, it is somewhat silly to use timer:
> such check would be more costly than
> 	
> 	if(!++jiffies) jiffies_hi++;
> 
> (or similar) construct in timer int.
> 
> BTW, I always liked above thing more that any other 64 jiffy solution.
> What's wrong with it?

It's slower than

	jiffies_64++;

which went into Linus' tree yesterday :-)

Tim

