Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVECSoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVECSoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVECSoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:44:06 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:19223 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261561AbVECSn6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:43:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VdNzr/m+ALbkduqEcKMSehIr8UjLsB7LkNSa0VqvZehTlYpNyrlWqOx7Lid5vk6q/+y34pKKE+OJrU0Ki6wpUS6XGK1KjjwoR0gIBJP70hp9rVmjsdswtCJc1Adv1vT7GL2NJHiOREx+DzgVyOJV5JIMdwBUUHkINCqK7l0vwuc=
Message-ID: <29495f1d05050311431681d259@mail.gmail.com>
Date: Tue, 3 May 2005 11:43:54 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: davidm@hpl.hp.com
Subject: Re: sparse warning, or why does jifies_to_msecs() return an int?
Cc: schwidefsky@de.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/05, David Mosberger <davidm@napali.hpl.hp.com> wrote:
> I'm seeing the following warning from sparse:
> 
> include/linux/jiffies.h:262:9: warning: cast truncates bits from constant value (3ffffffffffffffe becomes fffffffe)
> 
> it took me a while to realize that this is due to
> the jiffies_to_msecs(MAX_JIFFY_OFFSET) call in
> msecs_to_jiffies() and due to the fact that
> jiffies_to_msecs() returns only an "unsigned int".
> 
> Is there are a good reason to constrain the return value to 4 billion
> msecs?  If so, what's the proper way to shut up sparse?

Is there any logical reason to need longer than 46 days of
milliseconds? I mean, sure, we could support years in milliseconds,
but why  :) ? If you need longer, specify in seconds. Or add an
interface which does days :) I think it's perfectly reasonable to
constrain time units representative storage in the following manner:

seconds: unsigned int
milliseconds: unsigned int
microseconds: unsigned long
nanoseconds: u64

These are the assumptions I have made in my timeofday-based soft-timer
rework, for what it's worth.

I will look into all the math, though, as all the conversions need to
be accurate for my rework (to support existing interfaces).

Thanks,
Nish
