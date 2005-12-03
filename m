Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLCRKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLCRKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVLCRKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:10:38 -0500
Received: from web36914.mail.mud.yahoo.com ([209.191.85.82]:65395 "HELO
	web36914.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932083AbVLCRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:10:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qG93gnxDbb27FGnaLiJQ5pHLlt23SU3FbZn9mQMTTupVjb6JVGfLRk6G/khRRFomuGw8cFzmpT04qb1mxthO4r4uCEbG/CfYjqmlFnujsSys15NPT1kSMaNoYHBvBca7cGheC280P9wY/Rn/96KzZrdFdWkxvkLq0ZRrW1PN+n0=  ;
Message-ID: <20051203171037.94369.qmail@web36914.mail.mud.yahoo.com>
Date: Sat, 3 Dec 2005 17:10:37 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
To: vitalhome@rbcmail.ru
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, david-b@pacbell.net,
       akpm@osdl.org, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
In-Reply-To: <200512031149.jB3Bna5h049169@www4.pochta.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- vitalhome@rbcmail.ru wrote:

> Mark,
> 
> > > >I still do not see why you are stating this.  Why do you say this?
> > > > 
> > > >
> > > Due to possible priority inversion problems in David's core.
> > 
> > Which you still haven't proven, in fact you now seem to be changing your mind and saying 
> > that
> > there might be a problem if an adapter driver was implemented badly although I still 
> > don't see how
> > this could happen (the priority inversion I mean not the badly implemented driver ;).
> 
> Truly admiring your deep understanding of the real-time technology, I should remind you 
> that within the real-time conditions almost each event may happen and may not happen, for 
> instance, two calls from different context to the same funtion may happen at the same or 
> almost the same time, and may not happen that way. Therefore I used the word "possible". 
> Hope I clarified that a bit for you.
> 
> Please also see my previous emails for the explanation of how priority inversion can 
> happen. This is not gonna be a rare case, BTW.

Vitaly, 
 
First, please can you not change the CC list in the midle of a thread. 
 
Second, I studied real-time OS's at university and even started to write my  own RTOS so I do know
the basic's of real-time technology. My problem wasn't understanding what you meant, just which
part of the code you where referring to :(. 
 
OK, looking through the code after a cup of coffe I can see the problem you are pointing out,
thank you :), for some reason I thought that that code was protected by a spin_lock :/. 
 
How to fix this? 
 
David, how would you feel about adding a NOT_DMAABLE flag in the spi_message structure? This
helper routine could then use this thus solving the one buffer to many callers problem (well
moving into the adapter driver, but as that serialise's transfers anyway I think this would remove
the priority inversion problem, Vitaly?) 
 
The other solution is to do a kmalloc for each caller (would could try to be smart and only do
that if the buffer is being used). 
 
Let me know, if noone else is interested in fixing this then I'll do it and send a patch. 
 
Mark

> 
> Vitaly
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
