Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWHFXj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWHFXj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHFXj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:39:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49974 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWHFXj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:39:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cjj4NRxFz1jt5olp2c4SROkdDMYYQdkH33gGX8HBEGPOts4eeUFzGwSYQWfs5GlbB5rZ70mjNeyVnanO6GEtzyHq/re1QZ3EVQ7iXC8jplqOua0BaVGQK7LNkRMs619uZs/SJ5/RIL9EiV874wXDlcjYk8vGMQ07f8c08jdwv7Y=
Message-ID: <82faac5b0608061639v315c6fa9l17cd4bf44b6bbc51@mail.gmail.com>
Date: Mon, 7 Aug 2006 09:39:54 +1000
From: "Darren Jenkins" <darrenrjenkins@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [KJ] [patch] fix common mistake in polling loops
Cc: "Zed 0xff" <zed.0xff@gmail.com>, kernel-janitors@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060805114547.GA5386@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
	 <20060805114052.GE4506@ucw.cz> <20060805114547.GA5386@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day

On 8/5/06, Pavel Machek <pavel@ucw.cz> wrote:

> > Well, whoever wrote thi has some serious problems (in attitude
> > department). *Any* loop you design may take half a minute under
> > streange circumstances.

6.
common mistake in polling loops [from Linus]:


>
> Actually it may be broken, depending on use. In some cases this loop
> may want to poll the hardware 50 times, 10msec appart... and your loop
> can poll it only once in extreme conditions.
>
> Actually your loop is totally broken, and may poll only once (without
> any delay) and then directly timeout :-P -- that will break _any_
> user.

The Idea is that we are checking some event in external hardware that
we know will complete in a given time (This time is not dependant on
system activity but is fixed). After that time if the event has not
happened we know something has borked.
So in the loop, after the time period has expired without the event
happening we can go and clean up and get ready to go again, without
bothering to poll any more, because we already know something has
borked.

What does this give you ? Well it can improve performance by speeding
up re-try's when under heavy system load. The cost of cause is code
complexity.



Darren J.
