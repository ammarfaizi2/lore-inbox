Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161392AbWBUGNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbWBUGNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWBUGNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:13:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:61367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161388AbWBUGNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:13:38 -0500
Date: Mon, 20 Feb 2006 22:12:58 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060221061258.GA30274@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain> <20060212053849.GA27587@kroah.com> <20060216215023.GA30417@kroah.com> <20060219004751.GE3293@localhost.localdomain> <20060219005716.GA5800@kroah.com> <20060221055039.GG3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221055039.GG3293@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:50:39PM -0600, Nathan Lynch wrote:
> Greg KH wrote:
> > On Sat, Feb 18, 2006 at 06:47:51PM -0600, Nathan Lynch wrote:
> > > Sorry for the delay.
> > > 
> > > Tested against 2.6.16-rc4-ish, and it seems to do the right thing --
> > > modprobe -r says the module is busy while the refcnt attribute is
> > > open.  The module is allowed to unload once the file is closed.
> > 
> > Great, thanks for trying it out and letting me know.
> 
> Sure -- do you plan to push this for 2.6.16?

No.

> The reason I ask is that the refcnt attribute is world-readable, so a
> malicious or silly user can keep the file open until an unwitting
> superuser unloads a module...
> 
> Far-fetched, I suppose, but I just wanted to make this scenario clear.

It's been like this for a number of kernel versions now, and module
unloading is a rare thing to happen (no tools do it automatically.)  So
I don't think it's worth 2.6.16 material.  Let it sit in -mm for a bit
to verify that I didn't break anything else, and I'll send it in for
2.6.17.

thanks,

greg k-h
