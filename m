Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319270AbSIFSPl>; Fri, 6 Sep 2002 14:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSIFSPl>; Fri, 6 Sep 2002 14:15:41 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8119 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319270AbSIFSPk>;
	Fri, 6 Sep 2002 14:15:40 -0400
To: "David S. Miller" <davem@redhat.com>
cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
In-reply-to: Your message of Fri, 06 Sep 2002 10:37:17 PDT.
             <20020906.103717.82432404.davem@redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13091.1031336351.1@us.ibm.com>
Date: Fri, 06 Sep 2002 11:19:11 -0700
Message-Id: <E17nNhM-0003PD-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020906.103717.82432404.davem@redhat.com>, > : "David S. Miller" w
rites:
>    From: Gerrit Huizenga <gh@us.ibm.com>
>    Date: Fri, 06 Sep 2002 10:26:04 -0700
>    
>    One of our goals is to actually take the next generation of the most
>    common "large system" web server and get it to scale along the lines
>    of Tux or some of the other servers which are more common on the
>    small machines.  For some reasons, big corporate customers want lots
>    of features that are in a web server like apache and would also like
>    the performance on their 8-CPU or 16-CPU machine to not suck at the
>    same time.  High ideals, I know, wanting all features *and* performance
>    from the same tool...  Next thing you know they'll want reliability
>    or some such thing.
> 
> Why does Tux keep you from taking advantage of all the
> feature of Apache?  Anything Tux doesn't handle in it's
> fast path is simple fed up to Apache.

You have to ask the hard questions...   Some of this is rooted in
the past when Tux was emerging as a technology rather ubiquitously
available.  And, combined with the fact that most customers tend to
lag the technology curve, Apache 1.X or, in our case, IBM HTTPD was
simply a customer drop in with standard configuration support that
roughly matched that on all other platforms, e.g. AIX, Solaris, HPUX,
Linux, etc.  So, doing a one off for Linux at a very heterogenous
large customer adds pain, that pain becomes cost for the customer in
terms of consulting, training, sys admin, system management, etc.

We also had some bad starts with using Tux in terms of performance
and scalability on 4-CPU and 8-CPU machines, especially when combining
with things like squid or other cacheing products from various third
parties.

Then there is the problem that 90%+ of our customers seem to have
dynamic-only web servers.  Static content is limited to a couple of
banners and images that need to be tied into some kind of cacheing
content server.  So, Tux's benefits for static serving turned out to
be only additional overhead because there were no static pages to be
served up.

And, honestly, I'm a kernel guy much more than an applications guy, so
I'll admit that I'm not up to speed on what Tux2 can do with dynamic
content.  The last I knew was that it could pass it off to another server.
So we are focused on making the most common case for our customer situations
scale well.  As you are probably aware, there are no specweb results
posted using Apache, but web crawler stats suggest that Apache is the
most common server.  The problem is that performance on Apache sucks
but people like the features.  Hence we are working to make Apache
suck less, and finding that part of the problem is the way it uses the
kernel.  Other parts are the interface for specweb in particular which
we have done a bunch of work on with Greg Ames.  And we are feeding
data back to the Apache 2.0 team which should help Apache in general.

gerrit
