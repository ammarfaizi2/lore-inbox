Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbRDWPlD>; Mon, 23 Apr 2001 11:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135443AbRDWPkv>; Mon, 23 Apr 2001 11:40:51 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:43022 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135397AbRDWPh6>; Mon, 23 Apr 2001 11:37:58 -0400
Date: Mon, 23 Apr 2001 09:37:47 -0600
Message-Id: <200104231537.f3NFblv08166@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this?
In-Reply-To: <3AE449A3.3050601@eisenstein.dk>
In-Reply-To: <3AE449A3.3050601@eisenstein.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:
> Hi people,
> 
> I'm reading through various pieces of source code to try and get an 
> understanding of how the kernel works (with the hope that I'll 
> eventually be able to contribute something really usefull, but you've 
> got to start somewhere ;)
> 
> While reading through the source I've stumbled across various bits and 
> pieces that are not exactely wrong, but not strictly correct either. I 
> was wondering if I would be wasting my time by cleaning this up or if it 
> would actually be appreciated. One example of these things is the patch 
> below:
[...]
> All the above does is to remove the last comma from 3 enumeration
> lists.  I know that gcc has no problem with that, but to be strictly
> correct the last entry should not have a trailing comma.

But it's more people-friendly to have that trailing comma. It makes
adding new enumerations just slightly easier, and also makes it easier
to manually apply failed patches. I'd rather see those trailing commas
left in.

> Another example is the following line (1266) from linux/include/net/sock.h
> 
>          return (waitall ? len : min(sk->rcvlowat, len)) ? : 1;
> 
> To be strictly correct the second expression (between '?' and ':' ) 
> should not be omitted (all you guys already know that ofcourse).

Yeah, that one's pretty ugly and unreadable.

> Would patches that clean up stuff like that be appreciated or am I just 
> wasting my time?

Go ahead and make suggestions. I expect some things will be accepted,
some rejected (just like I did). Steer clear of any brace or tabbing
style changes, though.

> Should I just adopt an 'if gcc -Wall does not complain then it's ok' 
> attitude and leave this stuff alone?

Gcc is often too picky. It tries to be clever, but in many cases I've
found it's not clever enough. It's useful as a mechanism to identify
potential problems, but just because gcc whinges, doesn't mean there
is a problem. You'll need to read and analyse the code to be sure gcc
is correct in throwing a warning.

The goal should *not* be to shut up gcc. The goal should be to produce
more readable code and to fix bugs. Gcc is merely a tool. And a flawed
one, at that.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
