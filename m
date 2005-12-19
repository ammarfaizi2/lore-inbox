Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVLSUD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVLSUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVLSUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:03:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34379 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964932AbVLSUD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:03:57 -0500
Date: Mon, 19 Dec 2005 21:05:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219200533.GP3734@suse.de>
References: <20051219153236.GA10905@swissdisk.com> <20051219193508.GL3734@suse.de> <1135022319.2029.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135022319.2029.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, Ben Collins wrote:
> On Mon, 2005-12-19 at 20:35 +0100, Jens Axboe wrote:
> > On Mon, Dec 19 2005, Ben Collins wrote:
> > > This patch fixes the WRITE vs READ issue, and also sends the extra two
> > > commands. Anyone with an iPod connected via USB (not sure about firewire)
> > > should be able to reproduce this issue, and verify the patch.
> > 
> > The bug was in the SCSI layer, and James already has the fix integrated
> > for that. It really should make 2.6.15, James are you sending it upwards
> > for that?
> 
> You mean this patch?
> 
> James Bottomley:
>       [SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)
> 
> This fixes an oops with data direction because sbp2 was not checking
> enough itself.
> 
> I seriously doubt this will fix the issue being reported. Changing the
> blk request to a READ did not fix the problem. The problem was only
> fixed by sending the extra two commands. The direction was just a side
> issue.

Your report surely made it seem like an issue, hence I pointed you at
the fix(es). What part of the block layer didn't like these commands?

> Is there a problem with sending the commands? If they don't bother
> unaffected devices, but it does fix a large number of other devices,
> what's the problem?

It's not necessarily a problem, especially if other paths end up doing
it in some way or another. Hard to say whether it bothers other device,
but I agree it should not. Please resend after 2.6.15 is released (and
do make those macros functions, thanks).

-- 
Jens Axboe

