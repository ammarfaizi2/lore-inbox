Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVEQFDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVEQFDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEQFDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:03:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:668 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261782AbVEQFAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:00:04 -0400
Date: Tue, 17 May 2005 06:00:25 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [PATCH] Fix root hole in pktcdvd
Message-ID: <20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
References: <11163046681444@kroah.com> <11163046692974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11163046692974@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 09:37:49PM -0700, Greg KH wrote:
> ioctl_by_bdev may only be used INSIDE the kernel.  If the "arg" argument
> refers to memory that is accessed by put_user/get_user in the ioctl
> function, the memory needs to be in the kernel address space (that's the
> set_fs(KERNEL_DS) doing in the ioctl_by_bdev).  This works on i386 because
> even with set_fs(KERNEL_DS) the user space memory is still accessible with
> put_user/get_user.  That is not true for s390.  In short the ioctl
> implementation of the pktcdvd device driver is horribly broken.

Same comment as for previous patch.  I'll take a look at that sucker,
it might happen to be OK, seeing that most of the bdev ->ioctl() instances
ignore file argument and we might get away with passing odd stuff to
anything that could occur here.
