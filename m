Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVF1WX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVF1WX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVF1WWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:22:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbVF1WVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:21:04 -0400
Date: Tue, 28 Jun 2005 15:20:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       tytso@mit.edu, zwane@arm.linux.org.uk, jmforbes@linuxtx.org,
       rdunlap@xenotime.net, torvalds@osdl.org, chuckw@quantumlinux.com,
       alan@lxorguk.ukuu.org.uk, andrew.vasquez@qlogic.com,
       James.Bottomley@SteelEye.com
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
 board initialization.
Message-Id: <20050628152037.690c3840.akpm@osdl.org>
In-Reply-To: <20050628235148.4512d046.khali@linux-fr.org>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627225349.GK9046@shell0.pdx.osdl.net>
	<20050628235148.4512d046.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Chris, all,
> 
> > -stable review patch.  If anyone has any objections, please let us
> > know.
> 
> I have. This one patch is rather big and parts of it don't seem to
> belong to -stable. Can't it be simplified? More below.

The threshold for "what belongs in -stable" is a) set too high and b)
over-zealously enforced.

> > Return to previous held-logic of calling scsi_add_host() only
> > after the board has been completely initialized.
> 
> What real bug is it supposed to fix? (I guess some, but this leading
> comment should give the datails.)

If that's what was in the patch which went into 2.6.13 then we should be OK
with a full backport.  If the person who originally raised that patch put
unrelated things into a single patch then that's where the problem started.

Bear in mind that there is also risk in only part-applying a patch.

> > Also return pci_*() error-codes during probe failure paths.
> 
> How does this belong to stable please? I don't see this fixing any
> critical bug.

But it's obviously safe.

> > -	if (ret != 0) {
> > +	if (ret) {
> 
> This aint -stable material.

But it's obviously safe.  Let's use our brains on these patches and not
become beholden to doctrine, OK?
