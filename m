Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSERTU0>; Sat, 18 May 2002 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSERTUZ>; Sat, 18 May 2002 15:20:25 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:40208 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S313789AbSERTUY>; Sat, 18 May 2002 15:20:24 -0400
Date: Sat, 18 May 2002 20:58:02 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Tommy Reynolds <reynolds@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can BUG() also be used "safely" in interrupts?
Message-ID: <20020518205802.F751@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020517090139.G635@nightmaster.csn.tu-chemnitz.de> <20020517092740.62b4d60b.reynolds@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 09:27:40AM -0500, Tommy Reynolds wrote:
> BUG() is overkill here, since it breaks all existing spin locks trying to get
> the error message printed by the kernel.  Instead, why not just:
> 
> 	printk( KERN_WARN "spurious interrupt from my device\n" );
> 
> like everyone else does? 

That's what I do now.

> Keep in mind that if you are sharing an interrupt vector, each
> and every interrupt handler gets called for each and every
> interrupt, so having the device driver check that the device to
> which it is attached is really generating an interrupt is
> simple good form.

This is already being done. But I do REALLY paranoid checking of
each and every parameter of every function that is not declared 'static'.

But in this case the caller of the function or the hardware is
doing really strange things and it should be fixed ASAP and this
is the best way to catch the caller ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
