Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319044AbSHFKWE>; Tue, 6 Aug 2002 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319045AbSHFKWE>; Tue, 6 Aug 2002 06:22:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61189 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319044AbSHFKWD>; Tue, 6 Aug 2002 06:22:03 -0400
Message-ID: <3D4FA2F8.2050305@evision.ag>
Date: Tue, 06 Aug 2002 12:20:40 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
References: <13A77E76028@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:

> Hi Marcin,
>   what synchronizes these accesses to make sure that you do not have
> two ide_raw_taskfile requests on the flight, both using same 
> drive->srequest? It looks to me like that nothing, so you can overwrite 
> request's contents while somebody else already uses this buffer.

I don't think so. The queue lock is synchronizing them.
And then we usually add them just to the front of the queue in question
and wait for finishment until the request is done.
After all ide_raw_taskfile only gets used for REQ_SPECIAL request
types. This does *not* contain normal data request from block IO.
As of master slave issues - well we have the data pre allocated per
device not per channel! If q->request_fn would properly return the
error count instead of void, we could even get rid ot the
checking for rq->errors after finishment... But well that's
entierly different story.


