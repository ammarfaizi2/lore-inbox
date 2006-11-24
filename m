Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933879AbWKXLvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933879AbWKXLvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934276AbWKXLvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:51:38 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54913 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S933879AbWKXLvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:51:37 -0500
Date: Fri, 24 Nov 2006 14:50:04 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Hans Henrik Happe <hhh@imada.sdu.dk>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124115004.GB32545@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <200611232249.56886.hhh@imada.sdu.dk> <45662206.1070104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45662206.1070104@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 14:50:05 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:34:46PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Hans Henrik Happe wrote:
> >I don't know if this falls under the simplification, but wouldn't there be 
> >a race when reading/copying the event data? I guess this could be solved 
> >with an extra user index. 
> 
> That's what I said, reading the value from the ring buffer structure's 
> head would be racy.  All this can only work for single threaded code.

Value in the userspace ring is updated each time it is changed in kernel
(when userspace calls kevent_commit()), when userspace has read its old
value it is guaranteed that requested number of events _is_ there
(although it is possible that there are more than that value).

Ulrich, why didn't you comment on previous interface, which had exactly
_one_ index exported to userspace - it is only required to add implicit
uidx and (if you prefer that way) additional syscall, since in previous
interface both waiting and commit was handled by kevent_wait() with
different parameters.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
