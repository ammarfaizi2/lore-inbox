Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWAQT4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWAQT4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWAQT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:56:06 -0500
Received: from smtpout.mac.com ([17.250.248.72]:21703 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964783AbWAQT4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:56:05 -0500
In-Reply-To: <E1EywcM-0004Oz-IE@laurel.muq.org>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <341A8E0C-9619-499C-8800-BEB63CBC15C3@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Date: Tue, 17 Jan 2006 14:56:00 -0500
To: Cynbe ru Taren <cynbe@muq.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2006, at 14:35, Cynbe ru Taren wrote:
> What happens repeatedly, at least in my experience over a variety  
> of boxes running a variety of 2.4 and 2.6 Linux kernel releases, is  
> that any transient I/O problem results in a critical mass of RAID5  
> drives being marked 'failed', at which point there is no longer any  
> supported way of retrieving the data on the RAID5 device, even  
> though the underlying drives are all fine, and the underlying data  
> on those drives almost certainly intact.

Insufficient detail.  Please provide a full bug report detailing the  
problem, then we can help you.

> I've NEVER had a RAID1 throw a temper trantrum and go into  
> apoptosis mode the way RAID5s do given the slightest opportunity.

I've never had either RAID1 _or_ RAID5 throw temper tantrums on me,  
_including_ during drive failures.  In fact, I've dealt easily with  
Linux RAID multi-drive failures that threw all our shiny 3ware RAID  
hardware into fits it took me an hour to work out.

> Something HAS to be done to make the RAID5 logic MUCH more  
> conservative about destroying RAID5
> systems in response to a transient burst of I/O errors, before it  
> can in good conscience be declared ready for production use -- or  
> at MINIMUM to provide a SUPPORTED way of restoring a butchered  
> RAID5 to last-known-good configuration or such once transient  
> hardware issues have been resolved.

The problem is that such errors are _rarely_ transient, or indicate  
deeper media problems.  Have you then verified your disks using  
smartctl?  There already _is_ such a way to restore said "butchered"  
RAID5:  "mdadm --assemble --force"  In any case, I suspect your RAID- 
on-SATA problems are more due to the primitive nature of the SATA  
error handling; much of the code does not do more than a basic bus  
reset before failing the whole I/O.

> In the meantime, IMHO Linux RAID5 should be prominently flagged  
> EXPERIMENTAL -- NONCRITICAL USE ONLY or some such, to avoid  
> building up ill-will and undeserved distrust of Linux software  
> quality generally.

It works great for me, and for a lot of other people too, including  
production servers.  In fact, I've had fewer issues with Linux RAID5  
than with a lot of hardware RAIDs, especially when the HW raid  
controller died and the company was no longer in business :-\.  If  
you can provide actual bug reports, we'd be happy to take a look at  
your problems, but as it is, we can't help you.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


