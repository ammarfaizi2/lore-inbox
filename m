Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbVGNVr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbVGNVr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbVGNVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:47:20 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:30077 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S263152AbVGNVph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:45:37 -0400
Date: Thu, 14 Jul 2005 14:45:36 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
Message-ID: <20050714214536.GA11412@hexapodia.org>
References: <20050713185955.GB12668@hexapodia.org> <42D67D84.2020306@suse.de> <20050714175447.GA16651@hexapodia.org> <42D6B09F.2090800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D6B09F.2090800@suse.de>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 08:36:15PM +0200, Stefan Seyfried wrote:
> But the failure you have seen now - failure to invalidate the resume
> header - could also happen as long as we do not fix the reason for your
> failure. If we fix it, we don't need additional security nets ;-)

So if the header is overwritten before the pages are read back in, that
implies that the overwriting IO did not get to disk in my failing case.
Since pleny of other IO did end up on disk (scribbling on my ext3 in the
process), I wonder what could be different there...

> But i have no idea what went wrong for you, i'll have a look at the code
> but i doubt that i'll find much of interest.
> 
> One thing which would be interesting:
> You don't eventually have multiple swap partitions?

One root partition, one swap partition, no swap files or anything.

The only interesting thing I can think of is that my swap partition is
only 512MB while the machine has 1.25GB RAM.  (Installed Ubuntu and took
the defaults before installing the SODIMM.)

FWIW, I have suspended and resumed a few times since the failure and
haven't seen a repeat of the problem.  I am seeing some other problems
with 2.6.13-rc2-mm1 that I didn't see before - DRM/i830 lockups after
swsusp - that might be masking the problem, but I have done the
boot-swsusp-resume-swsusp-resume successfully.

I'm at a loss as to what I might have done to trigger the problem.

-andy
