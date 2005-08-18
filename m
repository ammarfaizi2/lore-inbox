Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVHRBHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVHRBHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVHRBHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:07:19 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:27197 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVHRBHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:07:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=YGQmzoLzzqcJ7SvHGDIg/6QYB2cH5oJ0KlHPEPRNbZ5mQKzp2GSNQX8UHaRJx3XTyYTpxsKtwCKG7PzJ10z+JUT+p2LdhX3T0Afmg0nKMqw3joi3AIqArsXkjnCD8mObQXsdVVXpMMJE6Wr2NYEjcR0xs29XgKCJKAeYWOc/L+Q=
Date: Wed, 17 Aug 2005 21:07:03 -0400
To: Bernardo Innocenti <bernie@develer.com>
Cc: lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@OpenLDAP.org,
       Giovanni Bajo <rasky@develer.com>, Simone Zinanni <simone@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
Message-ID: <20050818010703.GA13127@nineveh.rivenstone.net>
Mail-Followup-To: Bernardo Innocenti <bernie@develer.com>,
	lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@OpenLDAP.org,
	Giovanni Bajo <rasky@develer.com>,
	Simone Zinanni <simone@develer.com>
References: <4303DB48.8010902@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4303DB48.8010902@develer.com>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:50:16AM +0200, Bernardo Innocenti wrote:

> The relative timestamp reveals that slapd is spending 50ms
> after yielding.  Meanwhile, GCC is probably being scheduled
> for a whole quantum.
>
> Reading the man-page of sched_yield() it seems this isn't
> the correct behavior:
>
>    Note: If the current process is the only process in the
>    highest priority list at that time, this process will
>    continue to run after a call to sched_yield.

   The behavior of sched_yield changed for 2.6.  I suppose the man
page didn't get updated.

>From linux/Documentation/post-halloween.txt:

| - The behavior of sched_yield() changed a lot.  A task that uses
|   this system call should now expect to sleep for possibly a very
|   long time.  Tasks that do not really desire to give up the
|   processor for a while should probably not make heavy use of this
|   function.  Unfortunately, some GUI programs (like Open Office)
|   do make excessive use of this call and under load their
|   performance is poor.  It seems this new 2.6 behavior is optimal
|   but some user-space applications may need fixing.

    This is pretty much all I know about it; I just thought I'd point
it out.

> I also think OpenLDAP is wrong.  First, it should be calling
> pthread_yield() because slapd is a multithreading process
> and it just wants to run the other threads.  See:

    Is it possible that this problem has been noticed and fixed
already?

--
Joseph Fannin
jfannin@gmail.com

 /* So there I am, in the middle of my `netfilter-is-wonderful'
talk in Sydney, and someone asks `What happens if you try
to enlarge a 64k packet here?'. I think I said something
eloquent like `fuck'. - RR */
