Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265990AbTIKEPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbTIKEPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:15:18 -0400
Received: from zero.aec.at ([193.170.194.10]:23569 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265990AbTIKEPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:15:10 -0400
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Andi Kleen <ak@muc.de>
Date: Thu, 11 Sep 2003 06:14:50 +0200
In-Reply-To: <uqD5.3BI.3@gated-at.bofh.it> ("Nakajima, Jun"'s message of
 "Thu, 11 Sep 2003 05:50:07 +0200")
Message-ID: <m3iso0arlx.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <uqD5.3BI.3@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> writes:

>> I would hate to break this again just to save a few hundred bytes in
>> this function. Also the overhead is very low so it is also not
>> interesting to make it conditional for speed reasons.
>
> For maintenance and testing purposes, I think it's still better to make
> it conditional. If the errata are fixed, you might want to kill the
> condition depending on the stepping, for example. During the transition
> time, you need to support both the steppings until old ones go away
> (then remove the workaround).

My understanding is that it will never be fixed on the K7 (current Athlons),
And these will be with us for a long time; more or less forever, just like
the f00f bug :-)

I would agree with you if the patch had some bad impact on common
paths, but I don't think that's the case here. It merely adds a cheap check
to an already slow path.

On the other hand the errata is so unlikely that I doubt it will be frequently
hit anyways. 2.6 kernel hitting it was just very very unlucky, and it
only did so very infrequently.

Just to fix the kernel we could have chosen a different workaround, like
adding an exception table entry to each prefetch and jumping back
(I did that on the x86-64 port originally). But this way is also not that bad
and it fixes hypothetical user space programs that could maybe hit it too.

Of course they may want to also fix it in a different way to run on older
kernels (e.g. handling the signal in user space or avoiding the conditions).
But doing it centrally in the kernel is a bit cleaner and at some point
people have to update their kernels anyways.

-Andi
