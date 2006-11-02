Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752729AbWKBIBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbWKBIBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbWKBIBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:01:31 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23512 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752729AbWKBIBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:01:31 -0500
Date: Thu, 2 Nov 2006 11:01:22 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061102080122.GA1302@2ka.mipt.ru>
References: <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4549A261.9010007@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 02 Nov 2006 11:01:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 08:46:41AM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> zhou drangon a écrit :
> >performance is great, and we are exciting at the result.
> >
> >I want to know why there can be so much improvement, can we improve 
> >epoll too ?
> 
> Why did you remove most of CC addresses but lkml ?
> Dont do that please...

Sure, since for example I'm not subscribed (fortunately) to lkml, and I
think you want me to answer the question too...

> Good question :)
> 
> Hum, I think I can look into epoll and see how it can be improved (if 
> necessary)

epoll can not be improved, since the whole polling is designed to have
several layers of dereferencing, kevent simplifies that chain noticebly.

> This is not to say we dont need kevent ! Please Evgeniy continue your work !

I will :)

> Just to remind you that according to 
> http://www.xmailserver.org/linux-patches/nio-improve.html David Libenzi had 
> to wait 18 months before epoll being officialy added into kernel.

kevent exists for about 10 month. We have plenty of time :)

> At that time, many applications were using epoll, and we were patching our 
> kernels for that.
> 
> 
> I cooked a very simple program (attached in this mail), using pipes and 
> epoll, and got 250.000 events received per second on an otherwise lightly 
> loaded machine (dual opteron 246 , 2GHz, 1MB cache per cpu) with 10.000 
> pipes (20.000 handles)

pipes will work with kevent's poll mechanisms only, so there will not be
any performance gain at all since it is essentially the same as epoll
design with waiting and rescheduling (all my measurements with 
epoll vs. kevent_poll always showed the same rates), pipes require the same
notifications as sockets for maximum perfomance.
I've put it into todo list.

> It could be nice to add support for other event providers in this program 
> (AF_INET & AF_UNIX sockets for example), and also add support for kevent, 
> so that we really can compare epoll/kevent without a complex setup.
> I should extend the program to also add/remove sources during lifetime, not 
> only insert at setup time.

If there would exist sockets support, then I could patch it to work with
kevents.

-- 
	Evgeniy Polyakov
