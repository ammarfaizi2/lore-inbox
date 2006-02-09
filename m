Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWBIXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWBIXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWBIXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:41:25 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:52130 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750832AbWBIXlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:41:24 -0500
Subject: Re: a couple of oopses with 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bernd-schubert@gmx.de, bernd.schubert@pci.uni-heidelberg.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060209152744.00de43f6.akpm@osdl.org>
References: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de>
	 <20060209152744.00de43f6.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 18:41:11 -0500
Message-Id: <1139528472.3275.60.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 15:27 -0800, Andrew Morton wrote:
> So we have a sata problem.  It triggered two scsi bugs.  The first (a
> warning) is being fixed.  I don't know if the second has been fixed.

The second should be fixed by this:

author goggin, edward <egoggin@emc.com>  Tue, 8 Nov 2005 20:02:23 +0000
(15:02 -0500)
commit 34ea80ec6a02ad02e6b9c75c478c18e5880d6713 

[SCSI] fix usb storage oops

The problem is that scsi_run_queue is called from scsi_next_command()
after doing a scsi_put_command.  If the command was the only thing
holding the reference on the scsi_device then the resulting device put
will tear down the block queue.  Fix this by taking a reference to the
device and holding it around scsi_run_queue()

James


