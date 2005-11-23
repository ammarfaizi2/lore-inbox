Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVKWN5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVKWN5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKWN5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:57:31 -0500
Received: from tim.rpsys.net ([194.106.48.114]:63117 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750803AbVKWN5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:57:30 -0500
Subject: Re: [PATCH] split sharpsl_pm.c into generic and corgi/spitz
	specific parts
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051123130350.GA23090@elf.ucw.cz>
References: <20051123130350.GA23090@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 13:57:09 +0000
Message-Id: <1132754229.8016.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 14:03 +0100, Pavel Machek wrote:
> This splits sharpsl_pm.c into sharpsl_pm.c (generic code) and
> sharpsl_pm_pxa.c (spitz/corgi specific code). sharpsl_pm.c code should
> be reusable by collie.
> 
> I'd like to see it applied...

This diff looks much neater than the last one and I agree with the
principle of it. I don't think its the right time to apply it for two
reasons:

1. We probably shouldn't (can't?) make changes like this in -rc kernels 
2. I would like to see some signs that battery measurement, charging and
suspend/resume are all working on collie before we start applying
patches to support it. Only once that's happened do we know how much
common code we have and what changes are needed. Currently you only
appear to have covered battery measurement?

I have a proposal for how we proceed with this:

After 2.6.15 is released, I envisage a patch which splits the common
sections of sharpsl_pm.c into arm/common and arm/mach-pxa/sharpsl.h into
include/arm/hardware/sharpsl_pm.h. I'm happy to generate that patch if
necessary and pass it to Russell. I'll try and create a patch to show
the structure I'm aiming for in the next couple of days but at the
moment we don't know exactly which code is common and I'd prefer to try
and do the split in one go. 

In the meantime, creating the diffs like the last one show where the
split needs to be and converting those diffs to the final file locations
should be straightforward.

Waiting for 2.6.15 should also give you some time to get the collie
charging and suspend/resume code developed/tested and then point 2 above
will no longer apply. 

I did note your patch adds a copyright header to a file you're mostly
deleting code from?

Richard

