Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVC2Xn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVC2Xn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVC2Xn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:43:57 -0500
Received: from CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com ([69.194.86.29]:54146
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261651AbVC2Xno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:43:44 -0500
From: Andrew James Wade 
	<ajwade@CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Date: Tue, 29 Mar 2005 18:36:55 -0500
User-Agent: KMail/1.7.1
References: <20050324132342.GD7115@beast> <20050329103049.GB19541@gondor.apana.org.au> <1112093428.5243.88.camel@uganda>
In-Reply-To: <1112093428.5243.88.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291836.56223.ajwade@CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 29, 2005 05:50 am, Evgeniy Polyakov wrote:
> I think the most people use hardware accelerated devices to
> speed up theirs calculations - embedded world is the best example - 
> applications that are written to use /dev/random
> will work just too slow, so hardware vendors
> place HW assistant chips to unload that very cpu-intencive work
> from main CPU.
> Without ability speed this up in kernel, we completely [ok, almost] 
> loose all RNG advantages.

The reason for hardware random number generators is that computers
are pretty deterministic machines and random number sources tend to be
few, far between, very low bitrate, and of uncertain randomness. So much
so that without a user (a decent entropy source), a computer might take
minutes to collect a few hundred bits of entropy.[1] The advantage of a
hardware RNG is that it is random in the first place, high bitrates are
just icing on the cake.

[1] Vague recollection from a hardware RNG article.

The thing is few applications need truly random data, and even fewer
need much. (Maybe casinos). Even cryptographic applications don't need
much; they can be served by a carefully crafted pseudo-random number
generator, so long as that generator is seeded with enough entropy. (512
bits of entropy is plenty). And while a crypographically strong
pseudo-random number generator is pretty cpu-intensive, I would be
quite surprised to learn that a hardware RNG is faster.
