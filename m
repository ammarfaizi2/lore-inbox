Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbTFSUos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTFSUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:44:48 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30218 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265487AbTFSUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:44:44 -0400
Date: Thu, 19 Jun 2003 22:58:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Write Cache Enable in 2.4.20?
Message-ID: <20030619205839.GA11080@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com> <3EF1EB2E.8010702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF1EB2E.8010702@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Jeff Garzik wrote:

> This sounds like a bug, either in an application, or in Linux kernel's 
> scsi disk implementation.
> 
> Data is only guaranteed to be written onto disk following an 
> fsync(2)-like operation in the application.  And in turn, it is the 
> Linux kernel's responsibility to ensure that such a flush is propagated 
> all the down to the low-level driver, in my opinion.  Sophisticated 

I think file systems also have certain write ordering requirements to
maintain on-disk consistency, these would also need to make sure the
order is correct. AFAICS, SuSE have patched the reiserfs in their
2.4.20 kernel (8.2) to use write barriers (however deep these are
anchored), but ext3 or xfs don't show related log entries at boot-up or
mount time.

Is this something that will be fixed in 2.6 or will 2.6 still require me
to turn off the write cache?

> hosts can have barriers, and "dumb" hosts can simply call the drive's 
> flush-cache / sync-cache command.

-- 
Matthias Andree
