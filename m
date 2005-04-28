Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVD1Wpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVD1Wpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVD1Wpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:45:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32977 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262314AbVD1WpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:45:15 -0400
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: brace@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
In-Reply-To: <OFDD96A309.D5D89999-ON88256FF1.0062E298-88256FF1.00645C51@us.ibm.com>
References: <OFDD96A309.D5D89999-ON88256FF1.0062E298-88256FF1.00645C51@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114728218.18355.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 23:43:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 19:14, Bryan Henderson wrote:
> Probably the most common way to get the simple but slow write function 
> where the write() call actually writes to stable storage, and fails if it 
> can't, is the O_SYNC open flag.

O_SYNC doesn't work completely on several file systems and only on the
latest kernels with some of the common ones.

> But even that, in some versions of Linux, can miss write errors.  It's not 
> easy for Linux to catch them because the code that sees the I/O fail 
> doesn't know if it's part of some synchronous procedure where the user 
> will eventually find out about the error or the more common case where the 
> application has optimistically walked away and nothing can be done but 
> write off the loss.

Or because the error is reported out of order and there are ordering
guarantees in the fs. SCSI is ok here other controllers are not always
right.

