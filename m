Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTIXQYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbTIXQYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:24:32 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:60047 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261486AbTIXQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:24:29 -0400
Date: Wed, 24 Sep 2003 17:11:59 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Message-ID: <20030924171159.A7214@devserv.devel.redhat.com>
References: <20030924155720.C31236@devserv.devel.redhat.com> <Pine.LNX.4.44.0309242240500.6956-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309242240500.6956-100000@raven.themaw.net>; from raven@themaw.net on Wed, Sep 24, 2003 at 10:46:43PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 10:46:43PM +0800, Ian Kent wrote:
> The actual expire really needs to be interrutible.
> I didn't like the idea that the additional waiters would be 
> uninterruptible but perhaps I have no choice.
> 
> Given that do you think that using an interruptible_sleep_on for the 
> expire and a completion for the additional waiters could give an 
> acceptable solution?

No...
what happens if the person waking you does so inbetween the
        if ( wq->name ) {
test and the
                interruptible_sleep_on(&wq->queue);
.. ?
