Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVLLUOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVLLUOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVLLUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:14:24 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:22250 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932212AbVLLUOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:14:22 -0500
Subject: Re: Memory corruption & SCSI in 2.6.15
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brian King <brking@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512121149360.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston> <439DC9E4.6030508@us.ibm.com>
	 <Pine.LNX.4.64.0512121149360.15597@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 14:13:51 -0600
Message-Id: <1134418432.9994.32.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 11:55 -0800, Linus Torvalds wrote:
> Indeed, that looks pretty subtle. 
> 
> James: Brian's patch looks obviously correct to me (scsi_alloc_sdev() will 
> have called scsi_sysfs_device_initialize() which will set up the release 
> function to free the queue). 

Yes it does ... I'll put it in the rc-fixes tree.

> This code has been like that forever, though, which makes me wonder. Can 
> anybody see what has changed to make the bug trigger? Or is there 
> something I'm missing?

The trigger, based on the failure path has to be a slave_alloc failure
of an underlying driver (which isn't that common).  This may not be
visible in the dmesg traces if anyone has one, because reporting the
condition is up to the driver.

James


