Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTJQUzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTJQUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:55:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40420 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263525AbTJQUzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:55:20 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: online resizing of devices/filesystems (2.6)
Date: Fri, 17 Oct 2003 15:49:44 -0500
User-Agent: KMail/1.5
Cc: thornber@sistina.com, linux-kernel@vger.kernel.org
References: <200310171116.07362.kevcorry@us.ibm.com> <20031017130543.0e01d862.akpm@osdl.org>
In-Reply-To: <20031017130543.0e01d862.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171549.44589.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 October 2003 15:05, Andrew Morton wrote:
> Resizing a blockdev while someone has a filesystem mounted on it is a bit
> rude, but I guess that as long as it is being expanded, not much can go
> wrong.

There's no technical reason why you couldn't shrink as well. But right now we 
don't have any filesystems that support online shrink, so the tools prevent 
that scenario. Online expand is quite common, though.

> bd_set_size() isn't quite what you want because it fiddles with the
> blocksize as well.

Ok.

> So one approach would be to do what NBD does, and just write i_size
> directly.

We had considered that originally. It just seemed like too big of a hack. :) 
Plus I wasn't sure if there were locking issues with changing fields in the 
inode.

> You could create a little helper library function which takes i_sem and
> then writes i_size.  But the VFS tends to avoid taking i_sem on blockdevs
> because it doesn't expect i_size to change ;)

So...should I take i_sem or not? :)  Perhaps calling i_size_write() in 
include/linux/fs.h would be preferrable, since it seems to be doing different 
things for SMP and preempt.

Thanks for the feedback!
-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

