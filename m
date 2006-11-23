Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933600AbWKWTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933600AbWKWTqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933590AbWKWTqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:46:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933600AbWKWTqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:46:50 -0500
Message-ID: <4565FA60.9000402@redhat.com>
Date: Thu, 23 Nov 2006 11:45:36 -0800
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
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com> <20061123115240.GA20294@2ka.mipt.ru>
In-Reply-To: <20061123115240.GA20294@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Kernel does not put there a new entry, it is only done inside
> kevent_wait(). Entries are put into queue (in any context), where they can be obtained
> from only kevent_wait() or kevent_get_events().

I know this is how it's done now.  But it is not where it has to end. 
IMO we have to get to a solution where new events are posted to the ring 
buffer asynchronously, i.e., without a thread calling kevent_wait.  And 
then you need the extra parameter and verification.  Even if it's today 
not needed we have to future-proof the interface since it cannot be 
changed once in use.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
