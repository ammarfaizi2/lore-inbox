Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUDOQKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUDOQKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:10:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:21392 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264326AbUDOQKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:10:40 -0400
Date: Thu, 15 Apr 2004 09:10:11 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Maneesh Soni <maneesh@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415161011.GB2965@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk> <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk> <20040415161942.A7909@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415161942.A7909@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 04:19:42PM +0100, Russell King wrote:
> 
> However, should I also mention about the possibility of the following
> being in the same category; they are also typically statically
> allocated...
> 
> 	struct bus_type
> 	struct class
> 	struct platform_device
> 
> I think these may be worse than struct device_driver because I don't
> see their unregister functions even doing any form of "wait until
> unused" - so rather than being deadlock prone, they're oops-prone.
> 
> Sigh, sometimes life is <insert your favourite word to describe this>. ;(

Yeah, I agree.  For 2.7, I want to make static allocation of anything
that contains a kobject or kref not allowed to help fix things like
this.

So once again we are back at the "module unload is hard" problem :)

thanks,

greg k-h
