Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVALXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVALXRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVALXOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:14:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:8064 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261524AbVALW6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:58:33 -0500
Date: Wed, 12 Jan 2005 14:58:19 -0800
From: Greg KH <greg@kroah.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       gordon.jin@intel.com, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112225819.GB14590@kroah.com>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112221309.GW8098@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112221309.GW8098@schnapps.adilger.int>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 03:13:09PM -0700, Andreas Dilger wrote:
> On Jan 12, 2005  13:29 -0800, Greg KH wrote:
> > On Wed, Jan 12, 2005 at 10:36:06PM +0200, Michael S. Tsirkin wrote:
> > > To make life bearable for out-of kernel modules, the following patch
> > > adds 2 macros so that existance of unlocked_ioctl and compat_ioctl
> > > can be easily detected.
> > >  
> > > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> > > 
> > > diff -puN include/linux/fs.h~ioctl-rework include/linux/fs.h
> > > --- 25/include/linux/fs.h~ioctl-rework	Thu Dec 16 15:48:31 2004
> > > +++ 25-akpm/include/linux/fs.h	Thu Dec 16 15:48:31 2004
> > > @@ -907,6 +907,12 @@ typedef struct {
> > >  
> > >  typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);
> > >  
> > > +/* These macros are for out of kernel modules to test that
> > > + * the kernel supports the unlocked_ioctl and compat_ioctl
> > > + * fields in struct file_operations. */
> > > +#define HAVE_COMPAT_IOCTL 1
> > > +#define HAVE_UNLOCKED_IOCTL 1
> > 
> > No, we do not do that in the kernel today, and I'm pretty sure we don't
> > want to start doing it (it would get _huge_ very quickly...)
> > 
> > Please don't apply this.  Remember, out-of-the-tree modules are on their
> > own.
> 
> Gee, thanks.  It's not like some out-of-tree code doesn't _want_ to go
> into the core kernel, but usually the time between some code being
> developed and when it is included is lengthy (i.e. "this feature won't
> be accepted until lots of people use it").

I understand that, but for stuff like that, isn't it easier to just test
for VERSION?  Or use autoconf?

> You can't claim that this has never been done (e.g. KERNEL_HAS_O_DIRECT,
> KERNEL_HAS_DIRECT_FILEIO in 2.4 kernels).

That was because of the backport mess that 2.4 went through and vendor
kernels, right?

> For code that needs to handle
> multiple kernel versions this makes life far easier and doesn't actually
> hurt anything.  It used to be that you could use LINUX_VERSION_CODE for
> this kind of check, but that breaks down quickly with vendor kernels and
> the long development cycle.

What long development cycle?  The out-of-the-tree stuff?  Or the kernel
development stuff?

My main issue is when would we ever be able to remove such HAS macros?

And who specifically will be testing for these HAVE_COMPAT_IOCTL and
HAVE_UNLOCKED_IOCTL macros?  Will that code make it into the main tree
ever?  If not, why not?

thanks,

greg k-h
