Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVJ2WJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVJ2WJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVJ2WJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:09:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30598 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932461AbVJ2WJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:09:39 -0400
Message-ID: <4363F31F.2040303@pobox.com>
Date: Sat, 29 Oct 2005 18:09:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Deepak Saxena <dsaxena@plexity.net>, Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
References: <20051029191229.562454000@omelas>
In-Reply-To: <20051029191229.562454000@omelas>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> This patch adds support to the kernel for some more HW RNG devices
> and cleans up the code a bit.  My basic goal was to keep the same
> user space interface as exists, but not have to reproduce all
> the same 100 lines of user space interface code across every new
> driver (as we currently do with watchdogs...)
> 
> The new code separates the HW specific driver from the user 
> interface code and just adds a few function pointers so that
> the two can talk to each other. I opted out of using a sysfs
> class and all that complication b/c there will be one and only
> one RNG device at a time on a given system.
> 
> I've added drivers for Intels' IXP4xx and for the TI OMAP and
> these have both been tested.

I would prefer to let this live in -mm at least for a little while. 
Confirmation from AMD, Intel and VIA owners would be really nice, too. 
AMD and Intel might be a little bit hard to find.  I think Peter Anvin 
had an Intel ICH w/ RNG at one time...


> There was some discussion on lkml on the subject of killing
> the in-kernel driver and moving the whole implementation to
> user space but that cannot be done as some SOCs (MPC85xx for
> example) have the RNG unit as part of a larger device that
> needs kernel space code to manage command descriptor rings
> and other such things. We also want to be able to suspend/resume
> the RNG devices (see OMAP driver) and that needs to be done as part
> of the kernel PM path.

None of this precludes having this stuff in userspace.

That said, I don't object to your code being an intermediate step.

	Jeff (hw_random author)


