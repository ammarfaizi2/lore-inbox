Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVHaNk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVHaNk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVHaNk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:40:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29636 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964806AbVHaNk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:40:56 -0400
Message-ID: <4315B366.5040906@us.ibm.com>
Date: Wed, 31 Aug 2005 08:40:54 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: CFQ refcounting fix
References: <200508302241.j7UMf8ag018433@d01av03.pok.ibm.com> <20050831072830.GG4018@suse.de>
In-Reply-To: <20050831072830.GG4018@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 30 2005, brking@us.ibm.com wrote:
> 
>>I ran across a memory leak related to the cfq scheduler. The cfq
>>init function increments the refcnt of the associated request_queue.
>>This refcount gets decremented in cfq's exit function. Since blk_cleanup_queue
>>only calls the elevator exit function when its refcnt goes to zero, the
>>request_q never gets cleaned up. It didn't look like other io schedulers were
>>incrementing this refcnt, so I removed the refcnt increment and it fixed the
>>memory leak for me.
>>
>>To reproduce the problem, simply use cfq and use the scsi_host scan sysfs
>>attribute to scan "- - -" repeatedly on a scsi host and watch the memory
>>vanish.
> 
> 
> Yeah, that actually looks like a dangling reference. I assume you tested
> this properly?

Yes. I applied the patch, booted my system (which was crashing on bootup before
due to out of memory errors due to the leak) ran the scan a few times and verified
/proc/meminfo didn't continually decrease like without it, and rebooted again.
If there is anything else you would like me to do, I would be happy to do so.

Thanks

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
