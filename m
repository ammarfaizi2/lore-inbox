Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVERQEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVERQEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVERQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:03:41 -0400
Received: from vena.lwn.net ([206.168.112.25]:42421 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262314AbVERP7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:59:32 -0400
Message-ID: <20050518155927.8751.qmail@lwn.net>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][UPDATE PATCH 2/4] convert soft-timer subsystem to timerintervals 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 18 May 2005 01:21:41 PDT."
             <20050518082141.GC4205@us.ibm.com> 
Date: Wed, 18 May 2005 09:59:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nishanth,

To my uneducated eye, this patch looks like a useful cleaning-up of the
timer API.  I do have one question, though...

> @@ -238,15 +327,41 @@ void add_timer_on(struct timer_list *tim
>  	check_timer(timer);
>  
>  	spin_lock_irqsave(&base->lock, flags);
> +	timer->expires = jiffies_to_timerintervals(timer->expires);

It would appear that, depending on where you are, ->expires can be
expressed in two different units.  Users of add_timer() and mod_timer()
are expecting jiffies, but the internal code uses timer intervals.  What
happens when somebody does something like this?

	mod_timer(&my_timer, my_timer.expires + additional_delay);

Might it be better to store the timerintervals value in a different
field, and leave ->expires as part of the legacy interface only?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
