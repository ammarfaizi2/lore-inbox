Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272046AbTHHWmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHHWmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:42:11 -0400
Received: from codepoet.org ([166.70.99.138]:13267 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S272046AbTHHWmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:42:09 -0400
Date: Fri, 8 Aug 2003 16:42:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Georg Schwarz <geos@epost.de>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.21/2.4.22-rc1: IDE error message on startup
Message-ID: <20030808224210.GA26877@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Georg Schwarz <geos@epost.de>, linux-kernel@vger.kernel.org,
	andre@linux-ide.org
References: <1fze7ly.1v3ap5q173m695M@geos.net.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fze7ly.1v3ap5q173m695M@geos.net.eu.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 08, 2003 at 10:05:08PM +0200, Georg Schwarz wrote:
> Dear Linux kernel maintainers,
> 
> the following problem (aka bug?) appeared in 2.4.21 and still exists in
> 2.4.22-rc1 (kernels prior to 2.4.21 work fine):
> 
> SETUP:
> various mostly older PCs (486, Pentium I) and various smaller IDE drives
> (can would be happy to more details if needed)
> 
> PROBLEM:
> With Linux 2.4.21 or 2.4.22-rc1 (not with prior versions using the same
> .config however) on startup I get the following error messages for any
> connected IDE disk (but not ATAPI CR-ROM):
> 
> hda: attached ide-disk driver.
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }

A change was made to ide-disk.c where it _always_ attempts to do
a READ_NATIVE_MAX call regardless of whether the drive supports
the host protected area feature set in the
init_idedisk_capacity() function.  I submitted a patch to address
this, which is currently being reworked a bit in the 2.6 kernel 
tree and will then be backported again to 2.4.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
