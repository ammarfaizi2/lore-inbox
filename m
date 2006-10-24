Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWJXD1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWJXD1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWJXD1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:27:14 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:23700 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932407AbWJXD1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:27:13 -0400
Date: Tue, 24 Oct 2006 04:27:04 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: David Zeuthen <davidz@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, olpc-dev@laptop.org, greg@kroah.com,
       len.brown@intel.com, sfr@canb.auug.org.au, benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061024032704.GA24320@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org> <1161641703.2597.115.camel@zelda.fubar.dk> <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 04:56:30AM +0200, Shem Multinymous wrote:

> 30 seconds? I've seen battery applets that poll 1sec intervals (that's
> actually useful when you tweak power saving). And for things like the
> hdaps accelerometer driver, we're at the 50HZ region.

Reading the battery status has the potential to call an SMI that might 
take an arbitrary period of time to return, and we found that having 
querying at around the 1 second mark tended to result in noticable 
system performace degredation.

Possibly it would be useful if the kernel could keep track of how long 
certain queries take? That would let userspace calibrate itself without 
having to worry about whether it was preempted or not.

> You can't require reading battery status to be a root-only operation.

We certainly can. Whether we want to is another matter :) I tend to 
agree that moving to a setup that makes it harder for command-line users 
to read the battery status would be a regression.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
