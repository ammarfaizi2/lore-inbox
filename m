Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUDOV2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUDOV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:28:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:685 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263399AbUDOV2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:28:02 -0400
Date: Thu, 15 Apr 2004 14:27:32 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415212731.GA13578@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk> <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk> <20040415161942.A7909@flint.arm.linux.org.uk> <20040415161011.GB2965@kroah.com> <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk> <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 08:14:47PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> BTW, how about a new section that would
> 	a) be allocated separately at module load time
> 	b) contain a kobject with ->release() freeing that section
> 	c) be populated with structures containing kobjects and having
> no ->release(); main kobject would be pinned down by them.  Original
> refcount in each of those guys would be 1.
> 
> module_exit() would unregister all stuff we have in there and then drop
> the references to them.  No waiting for anything and when all references
> to these objects are gone, we get the section freed.  That can happen
> way after the completion of rmmod - as the matter of fact we could have
> the same module loaded again by that time.
> 
> AFAICS, that would solve the problem with static objects.  Comments?

Yes, that would be very nice to have.  It would also have to work pretty
much the same way with the code built into the kernel (with the
exception that module_exit() would never get called.

Sounds like some fun linker magic is called for here...

thanks,

greg k-h
