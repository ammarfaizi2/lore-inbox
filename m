Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVBCLpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVBCLpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVBCLkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:40:11 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:5568 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262890AbVBCL3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:29:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Date: Thu, 3 Feb 2005 12:30:19 +0100
User-Agent: KMail/1.7.1
References: <200502021428.12134.rjw@sisk.pl> <20050203105846.GA1360@elf.ucw.cz> <20050203110155.GA17576@isilmar.linta.de>
In-Reply-To: <20050203110155.GA17576@isilmar.linta.de>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502031230.20302.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 3 of February 2005 12:01, Dominik Brodowski wrote:
> On Thu, Feb 03, 2005 at 11:58:46AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > On Thu, Feb 03, 2005 at 11:41:26AM +0100, Pavel Machek wrote:
> > > > Okay, you are right, restoring it unconditionaly would be bad
> > > > idea. Still it would be nice to tell cpufreq governor "please change
> > > > the frequency ASAP" so it does not run at 800MHz for half an hour
> > > > compiling kernels on AC power.
> > > 
> > > It already does that... or at least it should. in cpufreq_resume() there is
> > > a call to schedule_work(&cpu_policy->update); which will cause a call
> > > cpufreq_update_policy() in due course. And cpufreq_update_policy() calls the
> > > governor, and it is supposed to adjust the frequency to the user's wish
> > > then.
> > 
> > Ok, so Rafael's suspend() routine seems like good fix...
> 
> No. I don't see a reason why my desktop P4 should drop to 12.5 frequency
> (p4-clockmod) if I ask it to suspend to mem.

So, would it be acceptable to check in _suspend() if the state is S4
and drop the frequency in that case or do nothing otherwise?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
