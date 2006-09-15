Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWIONdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWIONdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWIONdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:33:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:65162 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751420AbWIONdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:33:21 -0400
Date: Fri, 15 Sep 2006 03:29:54 -0700
From: Greg KH <gregkh@suse.de>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: [Bug ??] 2.6.18-rc6-mm2 - PCI ethernet board does not seem to work
Message-ID: <20060915102954.GA7014@suse.de>
References: <450A7EC5.2090909@bull.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450A7EC5.2090909@bull.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:21:57PM +0200, Pierre Peiffer wrote:
> Hi,
> 
> My Ethernet board (Intel(R) PRO/1000) "doesn't seems" to work any more
> with this kernel, but all is ok with kernel 2.6.18-rc6-mm1.
> 
> A bisection search show this patch:
> gregkh-pci-pci-sort-device-lists-breadth-first.patch
> as being the faulty one...
> 
> But after reading the content of this patch, I understood that the order
> of the ethernet boards had changed. In fact,  I have four ethernet
> boards and now, my eth0 does not point on the same card...
> So all is now ok by changing my cable to the right board.
> 
> But is this really the expected behavior ?

Yes.  You should use a persistent name for your network devices to
prevent this from happening.

That being said, I think we need to reverse the order of this patch,
keeping the current scheme as default, and allowing it to be overridden
on the command line for those few machines where it matters to be
compatible with the old, 2.4 ordering scheme.

Matt, care to rework the patch in this manner?

thanks,

greg k-h
