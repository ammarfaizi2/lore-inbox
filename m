Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281007AbRKTKTa>; Tue, 20 Nov 2001 05:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRKTKTV>; Tue, 20 Nov 2001 05:19:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5309 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281007AbRKTKTQ>;
	Tue, 20 Nov 2001 05:19:16 -0500
Date: Tue, 20 Nov 2001 05:19:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more fun with procfs (netfilter) 
In-Reply-To: <E165z5s-0000SM-00@wagner>
Message-ID: <Pine.GSO.4.21.0111200407430.21912-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Nov 2001, Rusty Russell wrote:

> In message <Pine.GSO.4.21.0111190156140.17210-100000@weyl.math.psu.edu> you wri
> te:
> > Reason: netfilter procfs files try to fit entire records into the user
> > buffer.  Do a read shorter than record size and you've got zero.  And
> > read() returning 0 means you-know-what...
> 
> Yes.  Don't do this.
> 
> Hope that helps,

That's nice, but...

% awk '/ESTABLISHED/{print $5}' /proc/net/ip_conntrack| wc -l
26
% grep ESTABLISHED /proc/net/ip_conntrack| wc -l
56
%

- IOW, awk (both gawk and mawk) loses everything past the first 4Kb.
And yes, it's a real-world example (there was more than $5 and it was
followed by sed(1), but that doesn't affect the result - lost lines).

So the list of "don't do this" is a bit longer than just reading it
from shell.

