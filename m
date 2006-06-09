Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWFIVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWFIVXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWFIVXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:23:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:30603 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030517AbWFIVXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:23:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MDXsx6S0RR5/Y7MfdqpSXCHDaWSI0b4KGK9qryXgH6kDOFrMXzC0/1ckiUmq6r+L3xssFAR46JOoGYpH2I6c+QTLLCGTNVwzgB1CqqxZwvtHcvP8FyP3hjGWcBWv+U3BQc+7JZ6X6kbAbASUH/L738VAfUvH1nnMQ/jOXKp2/yc=
Message-ID: <305c16960606091423v58a9cf29xf61d37539e89915d@mail.gmail.com>
Date: Fri, 9 Jun 2006 18:23:15 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1149883402.3894.265.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
	 <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
	 <1149878633.3894.224.camel@mindpipe>
	 <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
	 <1149881504.3894.250.camel@mindpipe>
	 <305c16960606091243h10638b2ayb7f1066bb839e496@mail.gmail.com>
	 <1149883402.3894.265.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Lee Revell <rlrevell@joe-job.com> wrote:
> Well, what you are trying to do seems hacky.  What real world problem
> are you trying to solve that setting swappiness to 0 is not sufficient
> for?
>
> Lee

For my usage, having processes swap is a complete loss. I have enough
ram and if some process doesnt fits into ram i would rather have it
killed than have it swap. Swap activity hogs my system and probably
either the process would fill up the swap and die anyway or it would
be too slow to be usable and i would kill it.

But i have some processes which gain considerable performance benefit
it they do their temporary work over tmpfs. The problem is that just
sometimes, their temporary work just doesnt fit into ram. In that case
swapping would be just fine. The simple dataformat on disk is a gain
when the stuff you are working on doesnt need to survive
unmounting/powerloss.
Now ive considered two alternatives:

1) Creating a new filesystem, a very simple one which only stores the
data in disk, and all the other stuff (superblock etc) is kept in
kernel memory, and let pagecache do its work on keeping fresh stuff on
ram.
2) Modifying tmpfs to accept a device, and when things dont fit in
ram, they would be flushed to this device instead first, while there
is space availiable, and then ultimately revert to swap when its
present.

It seems to me that both approaches would converge to the same thing,
but 2 is better because there would be no functionality duplication,
and it would get to keep the cool name
