Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSL2XpQ>; Sun, 29 Dec 2002 18:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSL2XpQ>; Sun, 29 Dec 2002 18:45:16 -0500
Received: from almesberger.net ([63.105.73.239]:22800 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262258AbSL2XpP>; Sun, 29 Dec 2002 18:45:15 -0500
Date: Sun, 29 Dec 2002 20:53:28 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Anomalous Force <anomalous_force@yahoo.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: holy grail
Message-ID: <20021229205328.B1363@almesberger.net>
References: <20021227083047.B1406@almesberger.net> <20021228163517.66372.qmail@web13207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228163517.66372.qmail@web13207.mail.yahoo.com>; from anomalous_force@yahoo.com on Sat, Dec 28, 2002 at 08:35:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anomalous Force wrote:
> you miss my point. im not saying to model it after tcp/ip. that
> was just a reference to a method of data exchange wherein the
> data has metadata to describe it.

I understood that. What I was saying is that metadata in a TCP
connection is usually not sufficient for restoring the endpoint
state.

> it makes full sense in an enterprise with 3000+ users that operates
> 24/7/365. no scheduled down-time for kernel upgrades.

I don't disagree with the usefulness of such functionality, but
I disagree with the level at which you suggest to implement this.

The approach of trying to migrate low-level kernel state has the
following problems/disadvantages:

 - complexity
 - does not allow recovery from corrupt kernel state, as Pavel has
   suggested
 - does not support recovery from corrupt hardware state
 - does not support substitution of infrastructure (e.g. what if
   I want to fail over to a different machine, maybe quickly
   replace some non-hotpluggable hardware (*), or even swap that
   old disk with a new one that has completely different
   characteristics ?)

So, compared to an approach that implements this at the kernel to
user space API level, you get a lot of extra complexity, but miss
several very desirable features.

(*) While the "big iron" in your data center may have hot-swappable
    CPUs and everything, it would be nice if such things could also
    be done with commodity hardware that doesn't provide such
    luxury.

> this is not true. if the system were an integral part of the overall
> design, then programming would include it apriori.

Making something part of the design alone doesn't guarantee that
this is a good approach, nor that it will actually work :-)

> there is a fine distinction between kernel migration, and hot-swap.
> in a hot-swap setup, there will be signals pending from devices
[...]

Err, yes, but what does your "hot-swap" do that kernel migration
doesn't ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
