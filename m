Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTLJFz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTLJFz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 00:55:27 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:52754 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262730AbTLJFzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 00:55:24 -0500
Message-ID: <3FD6B9B4.3040906@nishanet.com>
Date: Wed, 10 Dec 2003 01:14:12 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <1070827127.1991.16.camel@big.pomac.com>	 <200312081207.45297.ross@datscreative.com.au>	 <1070993538.1674.10.camel@big.pomac.com> <1071007478.5293.11.camel@athlonxp.bradney.info>
In-Reply-To: <1071007478.5293.11.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>What do the IDE ones[patches] claim to fix? I have had no real issue with IDE at
>all.. being able to burn CDs, DVDs, use my ATA133 drive for hdparm,
>greps, compilation, and general use.....
>
>Craig
>

These patches belong together because the same
necessity is the mother of their invention.

You may not have an offboard promise or sis hd
controller.

Alan Cox looked at "nforce2 irq storm" and the
offboard promise and sis controllers exposing
that dma operations might be running out of
time(time? timing..."timer"? a timer is a given
so "timer" was unthinkable!) waiting for irq
availability. That was months ago. It was only
evident that giving a "bight of slack(1)" to those
ops could help slightly, but we have a timer in
any case, don't we?

One person with a timer patch may backed into
the nforce2 solution while just trying to get
nmi_watchdog to work, right?

Ian Kumlien looks most likely to reason the problem
all the way through(2).

-Bob D

(1) "give me a bight of slack"
     "ah, for a bitty byte of pre-unicode slack loop"
  http://www.bartleby.com/61/13/B0241300.html

*bight*
 

PRONUNCIATION <http://www.bartleby.com/61/12.html>: 	  
<http://www.bartleby.com/61/wavs/13/B0241300.wav> bt
NOUN: 	*1**a.* A loop in a rope. *b.* The middle or slack part of an 
extended rope. *2**a.* A bend or curve, especially in a shoreline. *b.* 
A wide bay formed by such a bend or curve.
ETYMOLOGY: 	Middle English, bend, angle, from Old English /byht/. See 
*bheug- <http://www.bartleby.com/61/roots/IE63.html>* in Appendix I.


(2)  voted most likely to finesse through on a level above monkeys

 From Ian Kumlien:

I did some reading on amd's site, and if the disconnect + apic fixed the
same problem as the ~500ns delay, then it could be as i suspect...

I suspect that something goes wrong with apic ack when the cpu is
disconnected and according to the amd docs we could check the
Northbridge's CLKFWDRST or isn't that avail on the outside?
(It would be interesting to see if that fixes the problem as well.)

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26237.PDF

I don't really have the knowledge but it would sure be nicer to fix this
by checking this than to just disable it. I dunno if there is something
we could do from within the kernel aswell with the sending of HLT but i
doubt it.

Anyways, we need a generalized patch that does better checking on the
NMI bit (like Ross' patch). 

PS. Anyone that can point me to northbridge tech docks? and CC

-- Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net


