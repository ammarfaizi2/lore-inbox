Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUCaAfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUCaAfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:35:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:58069 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262952AbUCaAfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:35:24 -0500
Date: Tue, 30 Mar 2004 16:33:27 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040331003327.GB10262@kroah.com>
References: <20040330151637.6f5a688b.akpm@osdl.org> <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 06:56:27PM -0500, Alan Stern wrote:
> On Tue, 30 Mar 2004, Andrew Morton wrote:
> 
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > I think we need to do this now, as it is not a correct fix, and causes
> > > more problems than good at this time.
> > 
> > But the patch was correct.  sysfs retains a pointer to the kobject, it
> > should take a ref on it?
> > 
> > >  I suggest you try to fix the oops
> > > you were seeing in either another way, or in a way that does not break
> > > other things :)
> > 
> > Didn't we demonstrate that the code which broke was already broken?  And
> > that it has other problems regardless of the kobject pinning fix, such as the
> > userpace-holding-a-file-open-wedges-khubd problem?
> > 
> > Worried that this is all heading in the wrong direction...
> 
> There are two problems to consider:
> 
>     (1) sysfs retains pointers to kobjects long after they have been
> 	unregistered because of the negative dentrys.

That is now taken care of with the patch I just sent to Linus by taking
out this patch.

>     (2) khubd blocks when removing configurations.

That was fixed by the patch from you, undoing your previous patch which
blocked.

So everyone is happy now, right?  :)

thanks,

greg k-h
