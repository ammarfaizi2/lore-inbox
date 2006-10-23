Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWJWVSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWJWVSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWJWVSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:18:35 -0400
Received: from ns.suse.de ([195.135.220.2]:6584 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751226AbWJWVSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:18:34 -0400
Date: Mon, 23 Oct 2006 14:18:35 -0700
From: Greg KH <gregkh@suse.de>
To: Thomas Maier <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.19-rc2-mm2 sysfs: sysfs_write_file() writes zero terminated data
Message-ID: <20061023211835.GA27613@suse.de>
References: <op.tht1yneaiudtyh@master> <20061022183924.GA18032@suse.de> <op.thv4lpt0iudtyh@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.thv4lpt0iudtyh@master>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:02:03PM +0200, Thomas Maier wrote:
> Hello,
> 
> Sorry, maybe i missed something, but according to the
> code in fs/sysfs/file.c the "write" sequence is:
> 
> - call to sysfs_write_file(ubuf, count)
> - if (!sysfsbuf->page)  alloc zeroed page
> - copy count bytes from ubuf to sysfsbuf->page
> - call store(sysfsbuf->page, count)
> 
> When you write again to the file before closing it
> (possible?!), and count is less the the previous count
> you may not pass a zero terminated string/data to store().

Yeah, that might happen, but writing to a sysfs file again after the
first time is not the normal case here.  I'll add your patch to the
queue to keep this from happening though, good catch.

greg k-h
