Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757202AbWKVXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbWKVXzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757203AbWKVXzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:55:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6070 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757197AbWKVXzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:55:52 -0500
Message-ID: <4564E2AB.1020202@redhat.com>
Date: Wed, 22 Nov 2006 15:52:11 -0800
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
References: <11641265982190@2ka.mipt.ru>
In-Reply-To: <11641265982190@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> + struct kevent_ring
> + {
> +   unsigned int ring_kidx, ring_uidx, ring_over;
> +   struct ukevent event[0];
> + }
> + [...]
> +ring_uidx - index of the first entry userspace can start reading from

Do we need this value in the structure?  Userlevel cannot and should not 
be able to modify it.  So, userland has in any case to track the tail 
pointer itself.  Why then have this value at all?

After kevent_init() the tail pointer is implicitly assumed to be 0. 
Since the front pointer (well index) is also zero nothing is available 
for reading.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
