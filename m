Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSFMCyY>; Wed, 12 Jun 2002 22:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSFMCyX>; Wed, 12 Jun 2002 22:54:23 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:27057 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S317423AbSFMCyT>; Wed, 12 Jun 2002 22:54:19 -0400
Message-Id: <5.1.0.14.2.20020613124142.03292410@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Jun 2002 12:52:05 +1000
To: john slee <indigoid@higherplane.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020612145212.GF27429@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:52 AM 13/06/2002 +1000, john slee wrote:
>[ trimmed cc ]
>
>On Wed, Jun 12, 2002 at 10:28:15PM +1000, Lincoln Dale wrote:
> > right now, those bills are anywhere between 10% to 25% incorrect.
>
>10-25% is roughly equivalent to the hit rates i've seen on my web caches
>in real life, with MANY users.  i can't believe people are actually
>using this for data accounting.

ho hum.  we're straying from the topic here, but you've missed the point.
yes, a typical HTTP cache has a hit-rate around 30-35%.

any "margin of error" is on the basis of TCP retransmissions, IP+TCP header 
overhead, ...

that wouldn't negate a hit-rate.  rather, its 10-25% margin-of-error on the 
30-35% hit-rate.  ie. (0.1 x 0.35) or: 3.5% of the hit-rate may be in error.

but seeing as a HTTP cache is in essence glueing two TCP connections 
togethers, whats to say that the client wouldn't have had the TCP 
retransmissions in the first place?  all i'm talking about is ensuring that 
application "accounting" information is accurate.

right now, there is no method of doing that since the OS doesn't provide 
that data.

>i also can't think of many decent "free" (whatever your interpretation
>of that is) ways to do it either.  interface packet counters wrap
>around, most commercial firewalls i've used have inaccurate or
>incomplete logging (to put it lightly), and packet sniffers sometimes
>can't keep up.
>
>surely if profit (or just keeping your head above the water) is the goal
>you can justify the necessary resources to use something like netflow, a
>product designed to do exactly what you seem to want, among other
>things.  (search cisco.com, and no, i'm not a cisco employee)

since we're well away from the real issue anyway ....

i know a thing or two about netflow and other accounting mechanisms that 
cisco has.  (i am a cisco employee even if this particular topic isn't 
related to the work i do for them).
netflow counts statistics at layer2/3/4.

unfortunately, its rather hard to use netflow when a single stream goes to 
two places.
e.g. an idle HTTP/1.1 persistent connection can be reused for a different 
HTTP client.  netflow will only show a single flow, but there may be 
multiple HTTP requests from multiple (downstream) clients on that.

how about Pipelined Persistent connections?
what about streaming-media where a live stream is split to multiple clients?

>fiddling the network stack so that you can do dubious hacks in an
>allegedly apparently dubious aspect of squid just doesn't seem to be the
>ideal way to fix this problem.

since you obviously know lots about this topic, what "superior solutions" 
do you have?


cheers,

lincoln.
PS. personally i don't care if squid has this or not - its been many many 
years since i contributed any code to squid - but i do have a personal 
interest in helping make linux a better OS.

