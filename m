Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKPSkd>; Thu, 16 Nov 2000 13:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPSkX>; Thu, 16 Nov 2000 13:40:23 -0500
Received: from Cantor.suse.de ([194.112.123.193]:44548 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129091AbQKPSkH>;
	Thu, 16 Nov 2000 13:40:07 -0500
Date: Thu, 16 Nov 2000 19:10:05 +0100
From: Andi Kleen <ak@suse.de>
To: Nishant Rao <nishant@cs.utexas.edu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Setting IP Options in the IP-Header
Message-ID: <20001116191005.A19297@gruyere.muc.suse.de>
In-Reply-To: <20001116181840.A18222@gruyere.muc.suse.de> <Pine.LNX.4.21.0011161136160.5903-100000@crom.cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011161136160.5903-100000@crom.cs.utexas.edu>; from nishant@cs.utexas.edu on Thu, Nov 16, 2000 at 11:55:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 11:55:24AM -0600, Nishant Rao wrote:
> Well, while what you say makes sense, it isn't exactly a solution to our
> problem.
> 
> we are trying to expose and set a NEW option altogether. So our question 
> pertains more to what code we write in the kernel to create and expose a 
> new custom option. so for this, we would need to know the offsets of the
> current options like source routing etc and then hopefully try and stuff
> data from setting our option after the maximum that can be set by these
> other existing options.
> 
> once that code is in place within the ip_build_options routine in the
> ip_options.c file in the linux kernel, we can then use the setsockopt() 
> at the application level to make sure that a packet is filled with the
> corresponding option.
> 
> i hope i was able to explain my question more clearly.

It still does not make more sense. Linux never generates options itself,
so there are no fixed offsets for you to know. It all depends on the 
one generating the options in the first place (application or peer) 

If you want to add a new option you'll need to add an option parser that
handles all cases. For application sending it is probably better to just
change the application though. 

Usually it is not a good idea to add options anyways, because they tend
to trigger slow paths in routers.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
