Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933070AbWK0Sgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbWK0Sgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933065AbWK0Sgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:36:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933060AbWK0Sgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:36:45 -0500
Message-ID: <456B3016.9020706@redhat.com>
Date: Mon, 27 Nov 2006 10:36:06 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: johnpol@2ka.mipt.ru, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
References: <456603E7.9090006@redhat.com>	<20061124095052.GC13600@2ka.mipt.ru>	<456B2C82.7040700@redhat.com> <20061127.102443.74556125.davem@davemloft.net>
In-Reply-To: <20061127.102443.74556125.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> Now we'll have to have a compat layer for 32-bit/64-bit environments
> thanks to POSIX timers, which is rediculious.

We already have compat_sys_timer_create.  It should be sufficient just 
to add the conversion (if anything new is needed) there.  The pointer 
value can be passed to userland in one or two int fields, I don't really 
care.  When reporting the event to the user code we cannot just point 
into the ring buffer anyway.  So while copying the data we can rewrite 
it if necessary.  I see no need to complicate the code more than it 
already is.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
