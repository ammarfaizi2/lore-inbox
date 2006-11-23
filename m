Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757459AbWKWUgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbWKWUgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757458AbWKWUgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:36:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757459AbWKWUgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:36:05 -0500
Message-ID: <456605EA.5060601@redhat.com>
Date: Thu, 23 Nov 2006 12:34:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com> <20061123122225.GD20294@2ka.mipt.ru>
In-Reply-To: <20061123122225.GD20294@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>>> Btw, what about putting aditional multiplexer into add/remove/modify
>>> switch? There will be logical 'ready' addon?
>> Is it needed?  Usually this is done with a *_wait call with a timeout of 
>> zero.  That code path might have to be optimized but it should already 
>> be there.
> 
> It does not allow to mark events as ready.
> And current interfaces wake up when either timeout is zero (in this case
> thread itself does not sleep and can process events), or when there is
> _new_ work - since there is no _new_ work, when thread awakened to
> process it was killed, kernel does not think that something is wrong.

Rather than mark an existing entry as ready, how about a call to inject 
a new ready event?

This would be useful to implement functionality at userlevel and still 
use an event queue to announce the availability.  Without this type of 
functionality we'd need to use indirect notification via signal or pipe 
or something like that.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
