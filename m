Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWKBIS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWKBIS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWKBIS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:18:57 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:47823 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1751676AbWKBIS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:18:56 -0500
Date: Thu, 02 Nov 2006 09:18:55 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
In-reply-to: <20061102080122.GA1302@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org
Message-id: <4549A9EF.9000303@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT
References: <20061101130614.GB7195@atrey.karlin.mff.cuni.cz>
 <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz>
 <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz>
 <20061101185745.GA12440@2ka.mipt.ru>
 <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
 <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com>
 <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com>
 <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a écrit :
> pipes will work with kevent's poll mechanisms only, so there will not be
> any performance gain at all since it is essentially the same as epoll
> design with waiting and rescheduling (all my measurements with 
> epoll vs. kevent_poll always showed the same rates), pipes require the same
> notifications as sockets for maximum perfomance.
> I've put it into todo list.

Evgeniy I think this part is *important*. I think most readers of lkml are not 
aware of exact mechanisms used in epoll, kevent poll, and 'kevent'

I dont understand why epoll is bad for you, since for me, ep_poll_callback() 
is fast enough, even if we can make it touch less cache lines if reoredering 
'struct epitem' correctly. My epoll_pipe_bench doesnt change the rescheduling 
rate of the test machine.

Could you in your home page add some doc that clearly show the path taken for 
those 3 mechanisms and different events sources (At least sockets)

Eric
