Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVAFTft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVAFTft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAFTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:35:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27627 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262997AbVAFTfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:35:23 -0500
Date: Thu, 6 Jan 2005 11:35:20 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>, linux-usb-devel@lists.sourceforge.net
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106193520.GA5481@kroah.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106175342.GA28889@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 06:53:42PM +0100, Andi Kleen wrote:
> [cc list trimmed]
> 
> On Thu, Jan 06, 2005 at 06:26:13PM +0100, Petr Vandrovec wrote:
> > > Why are you issuing 64bit ioctls from 32bit applications? 
> > 
> > There are three reasons (main reason is that vmware is 32bit app, but it is how
> > things are currently laid out; even if there will be 64bit app, 32bit versions are
> > already in use and people wants to use them on 64bit kernels):
> > 
> > * USB.  usbfs API is written in a way which does not allow you to safely wrap
> > it in "generic" 32->64 layer, and attempts to do it in non-generic way in usbfs
> > code itself did not look feasible year ago.  Even on current 64bit kernels it is not
> > possible to issue raw USB operations from 32bit apps, and I do not believe that
> > it is going to change - after all, just issuing ioctl through 64bit path from application
> > which is aware of 64bit kernel is quite simple, much simpler than any attempt to
> > make kernel dual-interface.
> 
> Agree that's a problem. We just need an alternative interface here
> or I try to come up with an x86-64 specific hack (I think it's possible
> to do the compatibility x86-64 specific, just not in compat code for
> all architectures who have truly separated user/kernel address spaces) 
> 
> I hope the USB people will eventually add a better interface here.
> Greg?

Yes, we've been talking about a usbfs2 for a long time now, but no one
has stepped up and done the work.  It would look a lot like gadgetfs,
which only has a limited number of ioctls needed for its operation.

But I don't see where the problem is unique to usbfs here, don't we
properly use the 32->64bit ioctl conversion code to solve this kind of
issue?  Are we using it incorrectly?

thanks,

greg k-h
