Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVKMFic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVKMFic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 00:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKMFic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 00:38:32 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:27829 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751355AbVKMFic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 00:38:32 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] plugsched - update Kconfig-1
Date: Sun, 13 Nov 2005 16:37:40 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au> <200511131244.48358.kernel@kolivas.org> <4376CD9F.6040309@bigpond.net.au>
In-Reply-To: <4376CD9F.6040309@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131637.40704.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2005 16:22, Peter Williams wrote:
> Con Kolivas wrote:
> > On Sun, 13 Nov 2005 12:34, Peter Williams wrote:
> >>1. Make the ability to select which schedulers are built in independent
> >>of EMBEDDED.
> >>2. Only offer builtin schedulers as choice for the default scheduler.
> >>3. Only build in ingosched if PLUGSCHED is not configured.
> >
> > I disagree with 3. Surely people might want to build in only one
> > scheduler that is not ingosched without other choices.
>
> Yes, and they would be able to do that by selecting PLUGSCHED and then
> selecting only the scheduler that they want.  But this then leads to the
> observation that PLUGSCHED is probably makes things unnecessarily
> complex and all that is required is a means to select the schedulers to
> be built in and a choice of default (much like for the IO schedulers)?

Indeed it may be better to remove the "plugsched" option entirely. Once 
patched in it's not like you are building the kernel without the plugsched 
infrastructure. Provided each extra scheduler does not increase the kernel 
size too much (and a test build with/without all schedulers should tell you 
that), it may be best to just have the scheduler choice in the top menu and 
only expose the "schedulers to build in" under embedded. 

Of course if adding all the schedulers adds a lot of size to the kernel then 
it would be best to retain the "build support for multiple cpu schedulers" 
and default it to off. Do you have a quick comparison of build sizes 
with/without the various cpu schedulers? Last time I checked, staircase was a 
few hundred bytes larger than mainline despite being 200 lines of code less, 
probably due to its largely inline nature.

Cheers,
Con
