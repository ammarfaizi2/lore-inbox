Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUJ0C7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUJ0C7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUJ0C7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:59:35 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43735 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261614AbUJ0C6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:58:09 -0400
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1098845361.5661.13.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 12:49:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-10-27 at 12:48, Li, Shaohua wrote:
> >
> >Hi!
> >
> >I've just had a go at fixing the issue with my implementation not
> >suspending the sysdevs (I believe swsusp does the same). In the
> process,
> >I reworked the MTRR support so it's not treated as a sysdev. Instead,
> >when we're saving cpu state, the mtrr_save function function is called.
> >When we go to restore CPU state, each CPU calls a function that resets
> >it's MTRRs and the 'main' cpu then frees the saved data. This is
> working
> >well here (did a dozen plus suspends on the trot), but I want to check
> >that it sounds like the right solution to you.
> >
> >Perhaps this method should be made more generic? (Are there likely to
> be
> >other per-cpu state savers needed?)
> >
> >One thing I have noticed is that by adding the sysdev suspend/resume
> >calls, I've gained a few seconds delay. I'll see if I can track down
> the
> >cause.

> Is the problem MTRR resume must be with IRQ enabled, right? Could we

That's right.

> implement a method sysdev resume with IRQ enabled? MTRR driver isn't the
> only case. The ACPI Link device is another case, it's a sysdev (it must
> resume before any PCI device resumed), but its resume (it uses semaphore
> and non-atomic kmalloc) can't invoked with IRQ enabled. I guess cpufreq
> driver is another case when suspend/resume SMP is supported.

I'll see if I can find some time to prepare something. Might be a bit
slow; humans don't multitask very well, and I'm trying to at the moment
:>

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

