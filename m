Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWFUSDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWFUSDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFUSDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:03:18 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:12729 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751104AbWFUSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:03:18 -0400
From: Ben Pfaff <blp@cs.stanford.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
References: <1150907317.8320.0.camel@alice>
	<1150909982.15275.100.camel@localhost.localdomain>
	<87mzc65soy.fsf@benpfaff.org>
	<1150912459.15275.101.camel@localhost.localdomain>
Reply-To: blp@cs.stanford.edu
Date: Wed, 21 Jun 2006 11:03:10 -0700
In-Reply-To: <1150912459.15275.101.camel@localhost.localdomain> (Alan Cox's
	message of "Wed, 21 Jun 2006 18:54:19 +0100")
Message-ID: <87irmu5qu9.fsf@benpfaff.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Mer, 2006-06-21 am 10:23 -0700, ysgrifennodd Ben Pfaff:
>> > +		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
>> > +		memcpy(buf, data, ETH_ZLEN);
>> 
>> Is this really correct?  It zeros out ETH_ZLEN bytes only to
>> immediately copy over all of them again.
>
> When I did it originally I tested with rdtsc and its actually quicker to
> let it build the static memset the copy data over it than to do the
> extra maths and the variable length loop.
>
> Hence the comment

You are saying that this:
        memset(buf, 0, ETH_ZLEN);
        memcpy(buf, data, ETH_ZLEN);
is faster than this?
        memcpy(buf, data, ETH_ZLEN);

Because as far as I can tell they are equivalent.
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org
