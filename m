Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUHaNyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUHaNyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHaNyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:54:14 -0400
Received: from users.linvision.com ([62.58.92.114]:26573 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268503AbUHaNyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:54:04 -0400
Date: Tue, 31 Aug 2004 15:54:03 +0200
From: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
Message-ID: <20040831135403.GB2854@bitwizard.nl>
References: <20040830163931.GA4295@bitwizard.nl> <1093952715.32684.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093952715.32684.12.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 12:45:15PM +0100, Alan Cox wrote:
> On Llu, 2004-08-30 at 17:39, Rogier Wolff wrote:
> > We encounter "bad" drives with quite a lot more regularity than other
> > people (look at the Email address). We're however, wondering why the
> > IDE code still retries a bad block 8 times? By the time the drive
> > reports "bad block" it has already tried it several times, including a
> > bunch of "recalibrates" etc etc. For comparison, the Scsi-disk driver
> > doesn't do any retrying.
> 
> It helps for some things like magneto-opticals. For generic hard drives
> its only relevant for older devices.
> 
> > (*) Note: Tested last month: The driver still works for MFM
> > drives. However, the initialization apparently is not enough
> > anymore. The drive did not work when the BIOS didn't think there was a
> > drive.
> 
> Please file a bug report if 2.6 also shows that problem.

Will try to test when we have time. 

So, can we agree on: 
	- might be needed for 
		- Floppies?
		- MO drives
		- older drives

Can we auto-detect these cases (Linus doesn't like configurable
parameters that need tweaking to work well, and I agree: 99% of the
users want to have stuff that works (well) out of the box.)


How about we set the num-retries to 1, and increase to 8 for
"weird devices" (floppy, MO), and older drives. 

How do we detect: "Older drives"? Would "MFM": the user specified the
geometry" be valid as a detection of "older drive"?

Or do we want to include the 40Mb-1G generation drives as well? How
do we detect those if we want to include them? 

I do want to make the num_retries thing a configurable parameter,
should the autodetect get it wrong: We get drives that we want to
recover without the kernel-level retries...

(still: I argue that you need to consider a "retry-works" error as an
early warning that your media is going bad, and you need to get your
data off ASAP! If the kernel silently retries and succeeds, the user
won't notice a thing and continue using the drive (or MO media) until
the error becomes irrecoverable. I recommend we put the retry at the
user level. As in "person behind keyboard".)

I'll try to make a patch as long as we work towards a feature set
first.... 


	Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
