Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTIXNw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTIXNw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:52:29 -0400
Received: from mail-14.iinet.net.au ([203.59.3.46]:47046 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261364AbTIXNw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:52:28 -0400
Date: Wed, 24 Sep 2003 21:38:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
In-Reply-To: <1064408962.5074.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Arjan van de Ven wrote:

> On Wed, 2003-09-24 at 15:01, Ian Kent wrote:
> > This is a corrected patch for the autofs4 daedlock problem I posted about 
> > @@ -206,6 +207,11 @@
> >  
> >  		interruptible_sleep_on(&wq->queue);
> >  
> > +		if (waitqueue_active(&wq->queue) && current != wq->owner) {
> > +			set_current_state(TASK_INTERRUPTIBLE);
> > +			schedule_timeout(wq->wait_ctr * (HZ/10));
> > +		}
> > +
> 
> this really really looks like you're trying to pamper over a bug by
> changing the timing somewhere instead of fixing it...

Agreed.

> 
> also are you sure the deadlock isn't because of the racey use of
> interruptible_sleep_on ?
> 

OK so maybe I should have suggestions instead of comments.

Please elaborate.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

