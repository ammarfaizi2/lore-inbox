Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLUMk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 07:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTLUMk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 07:40:59 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12770 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262838AbTLUMk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 07:40:57 -0500
Message-ID: <3FE594D0.8000807@colorfullife.com>
Date: Sun, 21 Dec 2003 13:40:48 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org>
In-Reply-To: <20031221113640.GF3438@mail.shareable.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>Manfred Spraul wrote:
>  
>
>>What about switching to rcu?
>>    
>>
>
>What about killing fasync_helper altogether and using the method that
>epoll uses to register "listeners" which send a signal when the poll
>state of a device changes?
>
I think it would be a step in the wrong direction: poll should go away 
from a simple wake-up to an interface that transfers the band info 
(POLL_IN, POLL_OUT, etc). Right now at least two passes over the f_poll 
functions are necessary, because the info which event actually triggered 
is lost. kill_fasync transfers the band info, thus I don't want to 
remove it.

>
>That would trim off code all over the place, make the fast paths a
>little bit faster (in the case that there aren't any listeners), and
>most importantly make SIGIO reliable for every kind of file descriptor,
>instead of the pot luck you get now.
>
>Just an idea :)
>
It's a good idea, but requires lots of changes - perhaps it will be 
necessary to change the pollwait and f_poll prototypes.

--
    Manfred

