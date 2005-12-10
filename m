Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVLJE1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVLJE1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 23:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVLJE1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 23:27:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:28563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964910AbVLJE1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 23:27:11 -0500
Date: Fri, 9 Dec 2005 20:04:45 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051210040445.GB18452@kroah.com>
References: <20051203152339.GK31395@stusta.de> <20051204232205.GF8914@kroah.com> <4395A72E.6030006@tmr.com> <200512092016.42825.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512092016.42825.rob@landley.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 08:16:42PM -0600, Rob Landley wrote:
> As far as I can tell, what broke with udev was their embedded version of 
> "libsysfs", which is an abstraction layer I've _never_ understood the point 
> of.  (Because opening single value files in /sys is just too hard.  Nobody 
> needed a "libproc", the parsing of which is actual work, but they felt a need 
> a libsysfs.  Uh-huh...)

The original goal of libsysfs was to have a library that handled all of
the direct sysfs calls, and have it create structures that looked
something like what sysfs exported (devices, busses, etc.)

Then, if things changed in the sysfs layout or structure, only libsysfs
would need to be changed, and all apps that used it would continue to
work just fine.

But in reality, it was only used by udev, and was very fragile.  So
fragile udev is thinking of ripping it out as it has had a lot of
problems in the past.

Hope this explains things better.

thanks,

greg k-h
