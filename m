Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTHJUih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270682AbTHJUih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:38:37 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31495
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S270680AbTHJUie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:38:34 -0400
Date: Sun, 10 Aug 2003 13:27:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Georg Schwarz <geos@epost.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21/2.4.22-rc1: IDE error message on startup
In-Reply-To: <20030808224210.GA26877@codepoet.org>
Message-ID: <Pine.LNX.4.10.10308101318450.12816-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given the early nature of the test, its design was to catch devices which
fail to issue an abort for unsupported command sets.  This was to be a
means to flag the device as possible non-compliant.  It is okay to remove
or delete all, as clearly early warnings about standard command sets not
being supported was a silly design on my part.

Making all error messages hide by far is superior than exposing a
potential problem with hardware.  Maybe exposing the facts of media
forensics would clarify the issues; however, it is not that important.

Regards,

--a

On Fri, 8 Aug 2003, Erik Andersen wrote:

> On Fri Aug 08, 2003 at 10:05:08PM +0200, Georg Schwarz wrote:
> > Dear Linux kernel maintainers,
> > 
> > the following problem (aka bug?) appeared in 2.4.21 and still exists in
> > 2.4.22-rc1 (kernels prior to 2.4.21 work fine):
> > 
> > SETUP:
> > various mostly older PCs (486, Pentium I) and various smaller IDE drives
> > (can would be happy to more details if needed)
> > 
> > PROBLEM:
> > With Linux 2.4.21 or 2.4.22-rc1 (not with prior versions using the same
> > .config however) on startup I get the following error messages for any
> > connected IDE disk (but not ATAPI CR-ROM):
> > 
> > hda: attached ide-disk driver.
> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> A change was made to ide-disk.c where it _always_ attempts to do
> a READ_NATIVE_MAX call regardless of whether the drive supports
> the host protected area feature set in the
> init_idedisk_capacity() function.  I submitted a patch to address
> this, which is currently being reworked a bit in the 2.6 kernel 
> tree and will then be backported again to 2.4.
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

