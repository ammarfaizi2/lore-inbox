Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUGCGEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUGCGEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 02:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUGCGEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 02:04:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264923AbUGCGET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 02:04:19 -0400
Message-ID: <40E64C50.5010906@pobox.com>
Date: Sat, 03 Jul 2004 02:04:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andi Kleen <ak@muc.de>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
References: <22Gkd-1AX-17@gated-at.bofh.it> <m3r7sx6dip.fsf@averell.firstfloor.org> <200407030130.02067.phillips@arcor.de>
In-Reply-To: <200407030130.02067.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> It is designed to be crash-safe:
> 
>   - Each snapshot exception is logged to disk by overwriting the last sector
>     of a grow-only list of snapshot exceptions.
> 
>   - Write completion is not handed back up the chain until:
> 
>       - the data to be overwritten has been copied to a new exception
>       - the new exception has been logged to the snapshot store as above
> 
> As far as I can see, the concept is leak-proof, except for being sensitive to 
> random garbage in the last few sector writes.  I suspect that doesn't happen 
> on modern disk drives.  If it does, I hope somebody will shout.
> 
> I am not sure what you mean about barriers, perhaps you were thinking of 
> synchronous waiting.  This snapshot driver does wait for completions, but it 
> pipelines the waits so throughput is not affected much (snapshot overhead is 
> dominated by copyouts).


Barriers as discussed on lkml ensure your data is committed to stable 
storage, not simply completed requests.  In SCSI this means ordered 
tags, FUA, or cache flushing.  Ditto ATA (cache flushing, mostly).

	Jeff


