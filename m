Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUC3Rg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbUC3Rg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:36:59 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:22800 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263415AbUC3Rg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:36:56 -0500
Date: Tue, 30 Mar 2004 10:35:59 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <854630000.1080668158@aslan.btc.adaptec.com>
In-Reply-To: <4069AB1B.90108@pobox.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <200403261315.20213.kevcorry@us.ibm.com> <1644340000.1080333901@aslan.btc.adaptec.com> <200403270939.29164.kevcorry@us.ibm.com> <842610000.1080666235@aslan.btc.adaptec.com> <4069AB1B.90108@pobox.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel should not be validating -trusted- userland inputs.  Root is
> allowed to scrag the disk, violate limits, and/or crash his own machine.
> 
> A simple example is requiring userland, when submitting ATA taskfiles via
> an ioctl, to specify the data phase (pio read, dma write, no-data, etc.).
> If the data phase is specified incorrectly, you kill the OS driver's ATA
> host wwtate machine, and the results are very unpredictable.   Since this
> is a trusted operation, requiring CAP_RAW_IO, it's up to userland to get the
> required details right (just like following a spec).

That's unfortunate for those using ATA.  A command submitted from userland
to the SCSI drivers I've written that causes a protocol violation will
be detected, result in appropriate recovery, and a nice diagnostic that
can be used to diagnose the problem.  Part of this is because I cannot know
if the protocol violation stems from a target defect, the input from the
user or, for that matter, from the kernel.  The main reason is for robustness
and ease of debugging.  In SCSI case, there is almost no run-time cost, and
the system will stop before data corruption occurs.  In the meta-data case
we've been discussing in terms of EMD, there is no runtime cost, the
validation has to occur somewhere anyway, and in many cases some validation
is already required to avoid races with external events.  If the validation
is done in the kernel, then you get the benefit of nice diagnostics instead
of strange crashes that are difficult to debug.

--
Justin

