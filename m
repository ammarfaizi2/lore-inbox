Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUBICzM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUBICzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:55:11 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:5021 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S264879AbUBICzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:55:06 -0500
Date: Sun, 8 Feb 2004 20:55:05 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: Fab Tillier <ftillier@infiniconsys.com>
Cc: "'Greg KH'" <greg@kroah.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040209025505.GX11222@kalmia.hozed.org>
References: <20040208162946.GA2531@kroah.com> <08628CA53C6CBA4ABAFB9E808A5214CB017C1A11@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A11@mercury.infiniconsys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Why do you want to run your code in both places?  Does this mean that it
> > doesn't even really need to be in the kernel as it works just fine in
> > userspace?

> The user-mode IBAL library depends on the kernel mode IBAL driver to setup
> InfiniBand resources for use, and for the operations that can't be
> offloaded, like memory registrations.  Further, the kernel IBAL driver
> tracks user-mode resources on a per-process basis to ensure they are freed
> if an application seg faults.  This is a must so that things like memory
> registrations get cleaned up and the associated memory unlocked even in
> abnormal application termination situations.

We really *do* want to share code. We want both the user and kernel
code to use the same code paths for direct access to infiniband storage
devices, for example.

What I think is really needed is a mechanism for user level code to
call code provided by the loaded kernel module. I suspect this could be
done with some proper memory mappings and small user-level shim layers,
but I know there is something I'm forgetting.


-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
