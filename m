Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUHLMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUHLMvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268531AbUHLMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:51:35 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:27600 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268551AbUHLMsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:48:24 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nathan Bryant <nbryant@optonline.net>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092267400.2136.24.camel@gaston>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
	<1092231462.2087.3.camel@mulgrave>  <1092267400.2136.24.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Aug 2004 08:48:06 -0400
Message-Id: <1092314892.1755.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 19:36, Benjamin Herrenschmidt wrote:
> Some hosts will continuously DMA to memory iirc.. I remember having a
> problem with 53c8xx on some macs when transitionning from MacOS to Linux
> because of that.

I think you're thinking of the scripts engine?  on pre 53c875 chips,
yes, this is true.  The on-board processor is executing instructions
from host memory.  However, this is read only in quiescent (waiting for
host connect or target reconnect) mode, so shouldn't be a problem for
suspend.  On the 875 and later, we host the scripts in on-chip memory so
they shouldn't be troubling main memory when idling.

> We need to properly quisce the host, but that's a per host driver thing
> and shouldn't be too difficult.
> 
> Regarding suspend-to-disk, it's fairly easy for the sd driver not to
> spin down the disk for S4 (only for S3). However, we will still probably
> do at least a bus reset when waking up...

Why?  We don't do a bus reset on boot, why should we need to do one on
resume?  For FC, the equivalent, a LIP Reset can be rather nasty on a
SAN and should be avoided.

The slight problem is probably going to be knowing that we may need to
spin up devices (for internal ones) before resuming operation.

James


