Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131400AbRC1LxM>; Wed, 28 Mar 2001 06:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131424AbRC1LxC>; Wed, 28 Mar 2001 06:53:02 -0500
Received: from algernon.satimex.tvnet.hu ([195.38.110.113]:40210 "EHLO zeus.suselinux.hu") by vger.kernel.org with ESMTP id <S131400AbRC1Lwr>; Wed, 28 Mar 2001 06:52:47 -0500
Date: Wed, 28 Mar 2001 13:52:09 +0200 (CEST)
From: Pjotr Kourzanoff <pjotr@suselinux.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0103281328300.25356-100000@zeus.suselinux.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Linus Torvalds wrote:

> ... lots of stuff removed ...
>
> So in /dev, there are two problems: we are getting painfully close to
> major numbers with 8 bits, and we've run out of minors several times. In
> fact, a lot of the reason for the dearthness of major numbers is the fact
> that we use multiple majors for some stuff that really wants many minors.
>

  Well, one solution to this on the long term comes quite naturally:
make major/minor separation a policy, i.e., as in network/host
IP numbers. That is, in addition to 32-bit dev_t there would
be a 32-bit devmask_t that when &-ed with dev_t would yield the
major. The default, for compatibility reasons will be devmask of 255
(or -1+1<<12). For example, all floppies would fall into 2/8 major
(using IP address notation). Obviously, all this is not advantageous
on the short term, but in the absence of better ideas, this can give
some flexibility when allocating/shifting to new majors/minors...Of
course, namespaces approach is even better, but when will all drivers
be converted to support them?

Cheers,

Pjotr


