Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTHSUAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTHSTVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:21:33 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:37386 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261185AbTHSTTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:19:42 -0400
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA bus update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org>
	<20030819174208.GA4992@kroah.com>
	<wrpptj1fr83.fsf@hina.wild-wind.fr.eu.org>
	<20030819183537.GA5297@kroah.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 19 Aug 2003 21:19:13 +0200
Message-ID: <wrpk799fob2.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030819183537.GA5297@kroah.com> (Greg KH's message of "Tue,
 19 Aug 2003 11:35:37 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

>> Well, there is nothing to do in this function, because that's what the
>> whole driver does: nothing. It just presents a range of IO ports to be
>> probed to the main EISA code, and nothing else.

Greg> But it exports something in sysfs, right?  Any reason you just
Greg> don't dynamically create it?  It's real hard to get static
Greg> allocation of struct device correct.

Indeed, it registers a platform device. On the dynamic vs static
subject, it shouldn't matter here. Could switch to dynamic allocation
if needed.

Greg> Will this code ever be able to be built as a module?  If so,
Greg> this will not be correct.

No, it won't ever be a module. It woudn't make sense. Most of the time,
it is needed to boot the system...

>> Once it has registered as an EISA bus root, it doesn't get called
>> anymore, the core code does it all by itself.

Greg> So the release function never gets called at all then?  Why
Greg> would this be needed at all?

The only case in which it is called is when registration to the EISA
framework fails (because there is no EISA mainboard, or some PCI/EISA
bridge has registered before, with the same IO range). Thus we call
plateform_device_unregister, which calls the release function. And
this only happens at init time. Never after.

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
