Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVLPDTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVLPDTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLPDTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:19:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:46490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751296AbVLPDTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:19:20 -0500
Date: Thu, 15 Dec 2005 17:33:43 -0800
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs question:  how to map major:minor to name under /sys
Message-ID: <20051216013343.GD23832@kroah.com>
References: <17312.57214.612405.261796@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17312.57214.612405.261796@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:14:06PM +1100, Neil Brown wrote:
> 
> Hi,
>  I have a question about sysfs related usage.
> 
>  Suppose I have a major:minor number for a block device - maybe from
>  fstat of a filedescriptor I was given, or stat of a name in /dev.
>  How do I find the directory in /sys/block that contains relevant
>  information? 
> 
>  It seems to me that there is no direct way, and maybe there should
>  be. (I can do a find of 'dev' file and compare, which is fine in a
>  one-off shell script, but sub-optimal in general).

So you want this info from userspace, not from within the kernel, right?

>  The most obvious solution would be to have a directory somewhere full
>  of symlinks:
>         /sys/block_dev/8:0 -> ../block/sda
>  or whatever.
>  Is this reasonable?  Should I try it?

It seems a bit md specific to add a lot of kernel code for something
that can be solved with a userspace shell script :)

But if you want to try it, use a class, and a class_device for this, not
raw kobjects.  It should be a bit easier that way.

thanks,

greg k-h
