Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVEZRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEZRcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEZRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:32:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:48051 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261615AbVEZRcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:32:07 -0400
Date: Thu, 26 May 2005 19:33:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050526173303.GA1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de> <20050526171132.GV1419@suse.de> <42960436.4070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42960436.4070106@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Re-reading AHCI spec, it does indicate that you want to set SActive
> >after building the command. I'll move it back, but keep the conditional
> >of setting SActive on queued commands.
> 
> SActive is intentionally used for non-NCQ devices.  The SATA registers 
> are -host- registers not -device- registers, remember.

But the host sets SActive only, the device clears it. And at least the
maxtor drives don't clear SActive on non-NCQ commands, which makes
things really confusing once you have completed a non-NCQ command and
start doing some NCQ ones. Page 59 of the AHCI 1.1 spec reads:

4. If it is a queued command, software shall first set
PxSACT.DS(pFreeSlot). [...]

So I really do think this is an error in ahci.c since the beginning.

> At the very least, I would like to see a lot of testing before you make 
> the current unconditional code conditional.

Perhaps you could include such a patch in libata-dev for a while, if you
wish? I really cannot remove it from the NCQ patch.

-- 
Jens Axboe

