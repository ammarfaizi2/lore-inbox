Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVJCW5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVJCW5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVJCW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:57:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932492AbVJCW5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:57:13 -0400
Date: Mon, 3 Oct 2005 15:56:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Anderson <ryan@autoweb.net>
cc: =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
Message-ID: <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> 
 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>
  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> 
 <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com> 
 <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
 <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Oct 2005, Ryan Anderson wrote:
> 
> Let me rephrase what Linus said, to help remove the misreading that
> seems so common today.  I think a fair rewording would be, "A spec is a
> guideline.  When it fails to match reality, continuing to follow it is a
> tremendous mistake."

Yes (and that _should_ be obvious, but seldom is). But even stronger than 
that.

Even in the case where a spec follows reality, the organization of the 
spec very seldom has anything to do with organization of code.

A lot of people seem to think that spec abstractions should be translated 
into code abstraction. Not so. It often makes no sense to do so at all.

There are exceptions. I suspect that pretty much all of them are specs 
that _used_ to be code (ie they are documentation of real 
implementations).

For example, Al Viro pointed out privately that the C preprocessor spec 
actually matches what a C preprocessor is supposed to do, and that it was 
easy to generate code from the spec. The reason? The code existed first, 
the spec was written from that. Writing it back into software "just 
works", because the spec really _was_ software to begin with, just 
re-written as a spec.

But when it comes to hardware, almost all specs are written from the 
standpoint of the hardware, not the standpoint of the software driving it. 
The spec might even tell you accurately what the hardware does (hey, 
miracles happen!), but that doesn't mean that you should organize your 
software around it.

And the undeniable fact is, that once a spec gets big and complex enough, 
it won't be exhaustively tested. For example, we've seen time and time 
again that the hardware testing has been totally not based on any spec, 
but on just testing against (usually just one, and usually Windows) one 
single implementation of the "other side".

So for example, you'll have a general spec that says that the hardware 
reacts in certain ways, but the only case that has been _tested_ is the 
particular ways that Windows uses. Which is why we have hardware that 
locks up when given commands in the wrong order - where "wrong" is not 
defined by the spec, but by what Windows just happens to do.

This is especially common in the "cheap" market. For example, for SCSI, 
most of the violations tend to be USB storage - which is supposed to act 
largely like SCSI, but in reality really doesn't. It locks up if you 
try to access sectors that aren't there, etc.

And this is where the spec people come in. They think that the "spec" is 
right, and the reality is wrong. So they blame the broken hardware. Which 
is "true" to some degree - there's a lot of broken hardware out there. But 
it's _pointless_. Broken hardware is not an excuse - it's just a fact of 
life. It's not acceptable to say "but the spec says.." 

And yes, the real problem with people ignoring reality are often in the 
high end. The high end tends to be the place where vendors are used to 
saying "we don't use broken hardware". The high end is where people say 
"if it doesn't conform to spec, we don't care: it's broken". In short, the 
high end is where people are the most likely to just ignore the realities 
_outside_ the high end. They'll point to the spec, and say "do it like 
this". Without ever caring that doing it like that simply may not _work_ 
on a lot of setups.

So when the SAS people say that the SCSI layer should conform to their 
needs, next time they should remember that it _also_ needs to conform to 
the needs of things like USB storage. Which has totally different goals, 
implementation issues, and bugs. 

		Linus
