Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWEGNNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWEGNNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWEGNNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:13:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:42681 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932150AbWEGNNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:13:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iKzLVCOwjJc8e0YogHy0AiL5srA1kbI9DiLMos4lU24dXVFYOo77eyJNTHuSeZsgLP9hYem5Qy4pPwSIcNgyzHB2FOA78pLT5g2LWEWGY4VLvdfS8+mQV+9scTsG2R9104asprBzxhPShb8M0iba/7BXYlVfo+zSS7dN0qXZyzo=
Message-ID: <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com>
Date: Sun, 7 May 2006 10:13:50 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060507045920.GH15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060505203436.GW15445@waste.org>
	 <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org>
	 <20060506.170810.74552888.davem@davemloft.net>
	 <20060507045920.GH15445@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure.
>
> First, since the existence of /dev/random's entropy accounting scheme
> is predicated on the assumption that we can break the hash function at
> will, I'll replace SHA1 with, oh, say, CRC-16. This'll be illustrative
> until someone has a nice preimage attack against SHA1.
>
> Then I'll run my test on one of the various arches where HZ=~100 and
> we don't have a TSC. Like Sparc?
>
> Now all the inputs are easily predictable from anywhere with <10ms
> ping, with the occassional need to guess between a pair of timer
> ticks. And since I can calculate preimages of CRC-16, I can now deduce
> the state of the pool if I can watch some subset of its output, say
> https session keys I request. And then I can start guessing future
> outputs and breaking into other people's https sessions.
>
> The point of /dev/random is to -survive- SHA1 being broken by never
> giving out more secrets than we take in.

OK, here goes...

1 - by eliminating feeding enthopy from network cards you are
eliminating all sources of enthropy for _lots_ of people (think
headless servers, embedded systems - even though there can be other
sources of enthropy there) Unfortunatelly, bad enthropy is still
better than no enthropy (just think - no ssh / https, etc, etc)

2 - some platforms have much better enthropy sources than ethernet (or
user input), just think hardware rngs, or even the sound card rng
thing mentioned above

3 - as people said, your example (CRC-16 on specific platfoms) is
(IMHO) an exxageration. Of course, /dev/random should try and protect
us from whatever protocol being broken. That being said, this
protection should be 'realistic'. In theory most things are broken if
we have enough equipment and computing power.

My conclusion, I have no problem removing SA_SAMPLE_RANDOM *IN
SPECIFIC CASES* (meaning, this should be user configurable). In a
secure environment / platform has rng, it could be turned off, and in
a headless server / embedded system / it could be left on.

Of course, that's just MHO...

Thiago
