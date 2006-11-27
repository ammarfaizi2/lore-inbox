Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758510AbWK0SVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758510AbWK0SVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758507AbWK0SVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:21:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757861AbWK0SVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:21:52 -0500
Message-ID: <456B2C82.7040700@redhat.com>
Date: Mon, 27 Nov 2006 10:20:50 -0800
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
Subject: Re: Kevent POSIX timers support.
References: <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru> <20061123085243.GA11575@2ka.mipt.ru> <456603E7.9090006@redhat.com> <20061124095052.GC13600@2ka.mipt.ru>
In-Reply-To: <20061124095052.GC13600@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>> We need to pass the data in the sigev_value meember of the struct 
>> sigevent structure passed to timer_create to the caller.  I don't see it 
>> being done here nor when the timer is created.  Do I miss something? 
>> The sigev_value value should be stored in the user/ptr member of struct 
>> ukevent.
> 
> sigev_value was stored in k_itimer structure, I just do not know where
> to put it in the ukevent provided to userspace - it can be placed in
> pointer value if you like.

sigev_value is a union and the largest element is a pointer.  So, 
transporting the pointer value is sufficient and it should be passed up 
to the user in the ptr member of struct ukevent.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
