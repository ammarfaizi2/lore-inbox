Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265145AbSJWS4y>; Wed, 23 Oct 2002 14:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265151AbSJWS4x>; Wed, 23 Oct 2002 14:56:53 -0400
Received: from [202.88.156.6] ([202.88.156.6]:29867 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S265145AbSJWS4x>; Wed, 23 Oct 2002 14:56:53 -0400
Date: Thu, 24 Oct 2002 00:27:41 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 3
Message-ID: <20021024002741.A27739@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB6E45F.5010402@mvista.com>; from cminyard@mvista.com on Wed, Oct 23, 2002 at 01:03:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 01:03:11PM -0500, Corey Minyard wrote:
> >
> Yes, it's not correct, I will fix it.  I didn't realize there was an 
> rcu-safe list.  That should make things simpler.

Yeah, RCU documentation needs some serious updating :(

One other thing, it might be better to do all handler checks
in request_nmi and release_nmi in the spinlock serialized
critical section to minimize memory barrier issues unlike in the code
snippet I mailed - things like the list_empty() check etc.

That way you need to look at memory barrier issues with only
one piece of lockfree code - call_nmi_handlers.

Thanks
Dipankar

