Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVF1Wev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVF1Wev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVF1WcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:32:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262206AbVF1Wb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:31:28 -0400
Date: Tue, 28 Jun 2005 15:30:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, tytso@mit.edu,
       zwane@arm.linux.org.uk, jmforbes@linuxtx.org, rdunlap@xenotime.net,
       torvalds@osdl.org, chuckw@quantumlinux.com, alan@lxorguk.ukuu.org.uk,
       andrew.vasquez@qlogic.com, James.Bottomley@SteelEye.com
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow board initialization.
Message-ID: <20050628223012.GG9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net> <20050627225349.GK9046@shell0.pdx.osdl.net> <20050628235148.4512d046.khali@linux-fr.org> <20050628152037.690c3840.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628152037.690c3840.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> The threshold for "what belongs in -stable" is a) set too high and b)
> over-zealously enforced.

Do you have things you'd like to see in -stable that didn't make the
cut?

> > > Return to previous held-logic of calling scsi_add_host() only
> > > after the board has been completely initialized.
> > 
> > What real bug is it supposed to fix? (I guess some, but this leading
> > comment should give the datails.)
> 
> If that's what was in the patch which went into 2.6.13 then we should be OK
> with a full backport.  If the person who originally raised that patch put
> unrelated things into a single patch then that's where the problem started.

Agreed.

> Bear in mind that there is also risk in only part-applying a patch.

Yup, if it's only part of the patch, it needs to be re-tested to be sure
something important wasn't dropped in the chop up.

> > > Also return pci_*() error-codes during probe failure paths.
> > 
> > How does this belong to stable please? I don't see this fixing any
> > critical bug.
> 
> But it's obviously safe.
> 
> > > -	if (ret != 0) {
> > > +	if (ret) {
> > 
> > This aint -stable material.
> 
> But it's obviously safe.  Let's use our brains on these patches and not
> become beholden to doctrine, OK?

I agree.  The real fix only is 100% preferred, but not at the risk of
a patch that's less stable.  We've certainly asked for that as the rule
of thumb, but it is just that...a rule of thumb.
