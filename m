Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWJAURz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWJAURz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWJAURz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:17:55 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:22149 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932301AbWJAURy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:17:54 -0400
Date: Sun, 1 Oct 2006 14:17:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 13
Message-ID: <20061001201753.GG16272@parisc-linux.org>
References: <20060928211920.GI5017@parisc-linux.org> <1159732857.3542.5.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159732857.3542.5.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 03:00:57PM -0500, James Bottomley wrote:
> OK, my plan for this is to place it in SCSI misc as soon as we get
> 2.6.19-rc1.  That way we'll give it a thorough check out in -mm before
> it hits mainline.
> 
> By the way, a global change log (rather than changes relative to
> previous versions) would be appreciated.

Certainly ...

Add ability to scan scsi busses asynchronously

Since it often takes around 20-30 seconds to scan a scsi bus, it's
highly advantageous to do this in parallel with other things.  The bulk
of this patch is ensuring that devices don't change numbering, and that
all devices are discovered prior to trying to start init.  For those
who build SCSI as modules, there's a new scsi_wait_scan module that will
ensure all bus scans are finished.

This patch only handles drivers which call scsi_scan_host.  Fibre Channel,
SAS, SATA, USB and Firewire all need additional work.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

