Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWGHQCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWGHQCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGHQCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:02:08 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:53778 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S964876AbWGHQCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:02:07 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.17-mm6
Date: Sat, 8 Jul 2006 17:02:16 +0100
User-Agent: KMail/1.9.3
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <20060706201108.GA493@kroah.com> <200607072148.08567.s0348365@sms.ed.ac.uk>
In-Reply-To: <200607072148.08567.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081702.16589.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 July 2006 21:48, Alistair John Strachan wrote:
[snip]
> > > I don't think it's John's code. I commented out the sysfs registration
> > > code from timekeeping_init_device() and the kernel gets further, where
> > > it crashes on kmem_cache_create. SLAB also complains about "losing its
> > > name" and being "of size 0".
> > >
> > > This happens identically on 2.6.18-rc1, and 2.6.17-mm6. Greg, could it
> > > be anything you've changed recently? I considered bisectioning -mm, but
> > > there's been a lot of RAID problems and I'm using RAID5.
> >
> > Please bisect 2.6.18-rc1 if you have git, as the problem is there, and
> > would be good to track down.
>
> I tried this, but it's extremely difficult when the kernel boots
> successfully one every four times. I've already been thrown off the scent
> twice, bringing my bisection count to 25..
>
> I think I'll try an allnoconfig on this machine, hopefully that will boot,
> then I just start enabling things again until it breaks.

Sorry, this turned out to be my fault.

GCC had just recently been upgraded to 4.1.1, which apparently silently 
generates bad kernels with the version of H. J. Lu's binutils I had 
installed. I figured it out when going back to 2.6.17 didn't help. Why the 
crashes were sporadic I will never truly understand.

Going back to GNU binutils 2.17 and rebuilding GCC 4.1.1 fixed it. At least I 
learnt how to use Git, which is a truly superb tool. I'm now happily 
running -mm6.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
