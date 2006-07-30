Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWG3KGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWG3KGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWG3KGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:06:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22662 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751386AbWG3KGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:06:15 -0400
Date: Sun, 30 Jul 2006 12:05:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>
Subject: Re: Generic battery interface
Message-ID: <20060730100559.GA1920@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Here's one approach: use a syscall (e.g., ioctl) saying "block until
> >there's new data on this fd, or N milliseconds have passed, whichever
> >is *later*". This way each client declares the update rate it wants
> >and can change it on the fly. The driver sees all the requests and can
> >perform the minimum hardware quering -- for example, it won't query
> >the hardware at all if no client has submitted a request with
> >parameter N more than N milliseconds go. And there's no excessive work
> >or interrupts. Some (simple) kernel code infrastructure is needed to
> >help drivers manage the pending requests.
> 
> Here's a rough sketch for the userspace side of a continuous function
> sampling interface. It handles the blocking a bit better than the
> above proposal, in that it lets you easily handle multiple readouts.
> It's agnostic about /dev vs. /sys.

Looks good to me.

> I'm not getting into the kernel side for now; it's doable, and with
> proper infrastructure (e.g., at the sysfs level) can be elegant and
> efficient.

I guess that hwmon people would like this, anyway...

Are there any plans at merging tp_smapi, BTW? After fixing few minor
details (like removing " mV" from files)... it looks like it would fit
into hwmon infrastructure rather nicely.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
