Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUCPTpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUCPTmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:42:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:8152 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261541AbUCPTlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:41:06 -0500
Date: Tue, 16 Mar 2004 11:40:39 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
Message-ID: <20040316194039.GA21702@kroah.com>
References: <1AajM-5vw-21@gated-at.bofh.it> <1Abpq-6Av-1@gated-at.bofh.it> <1Aj3K-5Fn-9@gated-at.bofh.it> <1AjwZ-65D-15@gated-at.bofh.it> <m3brmwojk8.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3brmwojk8.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 05:14:47PM +0100, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> >
> > eh?  If there is any argument against this code it is that it is so simple
> > that the thing which it abstracts is not worth abstracting.  But given that
> > it is so unwasteful, this seems unimportant.
> 
> The bloat argument was about the additional pointer in the dynamic 
> data structure (on a 64bit architecture it costs 12 bytes) 

Well balance that out against every usb driver re-implemeting the same
get/put logic with an atomic counter and that "bloat of a pointer" just
got lost in the noise of the extra kernel code size increase :)

> Better would be to pass the callback to kref_put(), but then it would
> be even better to just test the return value (callbacks are obfuscation
> and should be avoided when not needed)

You don't always have the same chunk of code doing the last kref_put()
as the one where we know the release function is at.  See the
kobject/driver model code for an example of this.

thanks,

greg k-h
