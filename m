Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTIXOzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTIXOzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 10:55:05 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:8578 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261357AbTIXOzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 10:55:02 -0400
Date: Wed, 24 Sep 2003 22:46:43 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
In-Reply-To: <20030924155720.C31236@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0309242240500.6956-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Arjan van de Ven wrote:

> On Wed, Sep 24, 2003 at 09:38:16PM +0800, Ian Kent wrote:
> > > interruptible_sleep_on ?
> > > 
> > 
> > OK so maybe I should have suggestions instead of comments.
> 
> instead of interruptible_sleep_on(), it looks like you really want
> to use completions for this code..
> see kernel/workqueue.c for how those are used
> 

I did try that but thinking again ...

The actual expire really needs to be interrutible.
I didn't like the idea that the additional waiters would be 
uninterruptible but perhaps I have no choice.

Given that do you think that using an interruptible_sleep_on for the 
expire and a completion for the additional waiters could give an 
acceptable solution?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

