Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSHUJCm>; Wed, 21 Aug 2002 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSHUJCm>; Wed, 21 Aug 2002 05:02:42 -0400
Received: from miranda.axis.se ([193.13.178.2]:14746 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S318080AbSHUJCl>;
	Wed, 21 Aug 2002 05:02:41 -0400
From: johan.adolfsson@axis.com
Message-ID: <018001c248f2$b9283260$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oliver Xymoron" <oxymoron@waste.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net> <20020820180257.GF19225@waste.org> <05da01c2487e$b2321120$b9b270d5@homeip.net> <20020820193408.GG19225@waste.org> <05fe01c24897$5e0a7380$b9b270d5@homeip.net> <20020820230023.GA19951@waste.org>
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Wed, 21 Aug 2002 11:11:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Oliver Xymoron" <oxymoron@waste.org>
> On Wed, Aug 21, 2002 at 12:17:26AM +0200, johan.adolfsson@axis.com wrote:
>
> > I just compared the generated asm:
> > Accurate timestamp scaled to ns: 45 instructions (resolution actually 40
ns)
> > Approximate 40 ns resolution: 21 instructions
> > Approximate 40 us resolution: 9 instructions
> > For comparison one syscall path (gettimeofday()) is approx 400
instructions
> > and the add_timer_randomness() function that only uses jiffies is 76
> > instructions, so mayby I'm microoptimising here?
> > Is it worth the cycles to get 40 ns resolution instead of 40us ?
>
> Seems like it's probably worth the effort. In practice, such
> difference often are lost in the noise compared to cache flushes, etc.
> Does the 'correct' code suffer branch penalties or the like that might
> make it significantly worse than the quick code? If not, then I'd say
> definitely use it.

The correct code has two potential branches instead of one and also
need to stack one register when I have them in functions, but that might
change if the function is inlined in add_timer_randomness().
I can shave off a few instruction if I don't scale it to ns but instead
transform it to a plain 25MHz counter which is what we want anyway I guess.

BTW: I think the trust_pct approach looks nice adn I hope it gets included.

/Johan


