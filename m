Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWCHWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWCHWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWCHWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:52:57 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:63164 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932607AbWCHWw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:52:56 -0500
Message-ID: <440F6048.1030709@t-online.de>
Date: Wed, 08 Mar 2006 23:52:56 +0100
From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Brian Marete <bgmarete@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] 2.6.16-rc5: known regressions
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>	<20060227061354.GO3674@stusta.de> <1141308011.5884.5.camel@localhost>	<6dd519ae0603080313o4e7b8a61h5002125c33a0e008@mail.gmail.com> <1141849770.7534.55.camel@praia>
In-Reply-To: <1141849770.7534.55.camel@praia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: VylwmoZdoe6oTPXPLqXmM-DjwGiI+DNVwMcQP5JqzEe-GH3s-BFuQl
X-TOI-MSGID: 22c33dea-54aa-47b5-9c27-b20419b57d60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Brian

Mauro Carvalho Chehab wrote:
> Wow! Lots of people being c/c here! Since all pertinent guys are at
> lkml, I've just removed all those spam, keeping copied just the lists,
> and Adrian, who warned me about it.
> 
> Em Qua, 2006-03-08 às 14:13 +0300, Brian Marete escreveu:
> 
>>What you say is quite correct.
>>
>>However, my card is not known by the driver, and `card=3' has been working
>>for me all the while, with no problems at all. In any case, removing
>>`disable_ir=1' from the insmod options hides the problem for me. By the way,
>>that option was there since in an an earlier -rc, loading the driver without
>>it would cause an oops.
> 
> The option disable_ir is, in fact, a workaround. If this is not needed
> anymore, this is a progress ;) Anyway, having an OOPS is really bad. We
> should go further to avoid oops on it.
> 
> IR on some saa7134 cards are really a trouble. Sometimes, it just
> generates lots of weird events, since you are gathering a generic io
> port (GPIO) from hardware to generate keypressing. Using the wrong port
> may generate troubles at the system, by sending wrong events to input.
> With a wrong card, if somebody fixed the IR, it may broke for your
> board.

<snip>

I tried to reproduce your problem but i didn't succeed yet. I also think
that the IR support could be the problem. Card 3 defines a GPIO based
remote support.  As Mauro mentioned above, this is - at least - dangerous
if you force this card type but you don't have a remote control or just a
different one. This type of remote can use a GPIO port of the SAA713x to
generate interrupts. If this pin is floating on your card, the driver can
just be flooded with IRQs. We should have a look whether we can prevent this
in the IRQ handler.

Best regards
    Hartmut
