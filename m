Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUC3SDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbUC3SDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:03:20 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49795 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263788AbUC3SDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:03:07 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: "Enhanced" MD code avaible for review
Date: Tue, 30 Mar 2004 20:11:18 +0200
User-Agent: KMail/1.5.3
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       dm-devel@redhat.com
References: <760890000.1079727553@aslan.btc.adaptec.com> <4069AB1B.90108@pobox.com> <854630000.1080668158@aslan.btc.adaptec.com>
In-Reply-To: <854630000.1080668158@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302011.18790.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of March 2004 19:35, Justin T. Gibbs wrote:
> > The kernel should not be validating -trusted- userland inputs.  Root is
> > allowed to scrag the disk, violate limits, and/or crash his own machine.
> >
> > A simple example is requiring userland, when submitting ATA taskfiles via
> > an ioctl, to specify the data phase (pio read, dma write, no-data, etc.).
> > If the data phase is specified incorrectly, you kill the OS driver's ATA
> > host wwtate machine, and the results are very unpredictable.   Since this
> > is a trusted operation, requiring CAP_RAW_IO, it's up to userland to get
> > the required details right (just like following a spec).
>
> That's unfortunate for those using ATA.  A command submitted from userland
> to the SCSI drivers I've written that causes a protocol violation will
> be detected, result in appropriate recovery, and a nice diagnostic that
> can be used to diagnose the problem.  Part of this is because I cannot know
> if the protocol violation stems from a target defect, the input from the
> user or, for that matter, from the kernel.  The main reason is for
> robustness and ease of debugging.  In SCSI case, there is almost no
> run-time cost, and the system will stop before data corruption occurs.  In

In ATA case detection of protocol violation is not possible w/o checking every
possible command opcode.  Even if implemented (notice that checking commands
coming from kernel is out of question - for performance reasons) this breaks
for future and vendor specific commands.

> the meta-data case we've been discussing in terms of EMD, there is no
> runtime cost, the validation has to occur somewhere anyway, and in many
> cases some validation is already required to avoid races with external
> events.  If the validation is done in the kernel, then you get the benefit
> of nice diagnostics instead of strange crashes that are difficult to debug.

Unless code that crashes is the one doing validation. ;-)

Bartlomiej

