Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUFOQOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUFOQOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUFOQOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:14:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:30087 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265743AbUFOQOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:14:40 -0400
Date: Tue, 15 Jun 2004 09:13:08 -0700
From: Greg KH <greg@kroah.com>
To: Shaun Colley <shaunige@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c device driver bugs
Message-ID: <20040615161307.GA13722@kroah.com>
References: <20040614212130.GA3292@kroah.com> <20040615153920.24928.qmail@web25105.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615153920.24928.qmail@web25105.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:39:20PM +0100, Shaun Colley wrote:
> Hi Greg,
> 
> > Please let us know exactly what kernel version you
> > see this in.  It
> > looks to me that it is fixed in the latest 2.4 and
> > 2.6 versions.  If you
> > do not think so, please let us know.
> 
> I was actually looking at a fairly old version of the
> source tree (2.4.19, 2.4.20) -- it appears that a
> quick fix fixed this vulnerability in 2.4.21:
> 
> http://lxr.linux.no/diff/drivers/i2c/i2c-dev.c?diffval=2.4.21;diffvar=v
> 
> If you scroll down a bit, you should see:
> 
> ---
> if (rdwr_arg.nmsgs > 42)
>           return -EINVAL;
> ---
> 
> It looks like a quick sanity check was added in the
> 'I2C_RDWR' option, to fix the issue.
> 
> I'm downloading the 2.4.21 patch to check if the
> fixing of this was recorded, or whether it was
> silently fixed (looks like it was).
> 
> Confirmed.  2.4.21 fixed the bug:

What do you mean "silent"?  I got fixed 15 months ago with the following
changeset:
	http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/i2c/i2c-dev.c@1.8

It was then fixed even better with the following change:
	http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/i2c/i2c-dev.c@1.9
almost a whole year ago.

> It's also fixed in all versions of 2.6...
> 
> However, the vulnerbility seems to still be present in
> 2.5 -- latest version.  

Heh, 2.5 development is dead, no one uses that kernel, just like no one
uses the most recent 2.3 kernel tree.

> So, to sum it up:
> 
> - Not present in 2.2, because the driver wasn't
> implemented as fully as it is now.
> - Present in 2.4 versions 2.4.20 and below.
> - Present in 2.5
> - Not present in 2.6

Yes, this was a security issue a year ago, but has been fixed since
then.  Vendors have released kernels that fix this issue for their 2.4
kernels.  If not, I suggest you contact your vendor.

thanks again,

greg k-h
