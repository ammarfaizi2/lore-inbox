Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWGMDND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWGMDND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWGMDND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:13:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:18088 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932488AbWGMDNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:13:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=WAUVTfH7c/WTi/UeRmtHPu3qM5M14qeTiOw8GVjfG7hMaKfO9J2dzbV8Ij3+22j2FFN4ekvfy+M+5cGyHEOXmqT1oZ/cdrJCUscyInHmCTEwA6OINcWR5kMOp662WqU0Ixqy+iVbjY0c8YNWCiymRxFw5fTU9HCLfvxQCQMN6ns=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Date: Wed, 12 Jul 2006 22:56:01 -0400
User-Agent: KMail/1.9.1
Cc: andrea@cpushare.com, Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20060629192121.GC19712@stusta.de> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain>
In-Reply-To: <1152741776.22943.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607122256.04007.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 18:02, Alan Cox wrote:
...
> Actually measuring time through the network is extremely doable given
> enough samples as is communication through delay perturbation. A good
> viterbi encoder/decoder will fish a signal out of very high noise. Yes
> you pay a lot in data rate at that point but it works.

The data rate is important: it can mean a difference between an attack
that is practical and one that is impractical. Although I suspect the
orders of magnitude in the sampling rate of rdtsc versus network
packet times is more important. Another source of timing information
could be two seccomp threads (scheduled to different cores/SMT
threads) comparing their relative progress. What made the L1 cache
miss side-channel so interesting was its very high bandwidth. Relative
progress timing techniques will yield lower side-channel bandwidth on
many interesting configurations.

> Anyway at the point you pass the bytecode through a processing filter
> you don't need SECCOMP because your filter can remove any syscall
> attempts. 

Both int 80 and the rdtsc instructions are only 2 bytes long: they'll
generate too many false positives. It may be practical to filter out
the "f00f" instructions though. 
And filtering isn't fail-safe from a security point-of-view: if you
miss a case you lose. For example, can the f00f bug still be triggered
if there are prefixes between the lock prefix and the cmpxchg8b? I
don't know, but if so you'll need to filter for those cases too.

Filtering may be a good idea, but I wouldn't want to rely on it alone.

Andrew Wade
