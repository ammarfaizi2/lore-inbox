Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSKYVgm>; Mon, 25 Nov 2002 16:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSKYVgm>; Mon, 25 Nov 2002 16:36:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22031 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265564AbSKYVgl>;
	Mon, 25 Nov 2002 16:36:41 -0500
Date: Mon, 25 Nov 2002 13:36:17 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, perex@suse.cz
Subject: Re: [PATCH] Module alias and table support
Message-ID: <20021125213617.GA25269@kroah.com>
References: <20021120082330.GD22408@kroah.com> <20021125003005.2AB4B2C0BF@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125003005.2AB4B2C0BF@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:34:16AM +1100, Rusty Russell wrote:
> > > +        /* not matched against */
> > > +        kernel_long     driver_info;
> > 
> > Or is it because of "kernel_long"?  I'm pretty sure this field is only
> > used within the kernel, and userspace does not care at all about it.
> 
> It sucks to reproduce this, yes.  But you need to know the size of the
> structure to grab it out of the object file.  At least this way it's
> in the kernel source where we can change it.

But can't we still just use the structure from the kernel header and not
have to retype it here?  If needed, we can change the type of
driver_info into something more portable than what it is today.  That
would be much easier in the long run.

> > Why are you doing this "preprocessing" of the flags and the different
> > fields?  If you do this, you mess with the logic of the current
> > /sbin/hotplug tools a lot, as they expect to have to do this.
> 
> 	The plan was that /sbin/hotplug will gather all the fields for
> whatever device has been inserted and create the modprobe string, eg:
> 
> 		system("modprobe usb:v0506p4601dl01dh01dc01dsc01dp01ic01isc01ip01");
> 
> 	Which will simply match the alias such as:
> 		usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*

Ah, you never told me about this plan :)

Yes, that would be very nice to have, pushing the logic out of the
/sbin/hotplug code and into modprobe doesn't bother me.  That just saved
a _whole_ bunch of space in diethotplug, so you've made up for making
the size smaller.

How would modprobe know which driver to load based on the above line?
Are you going to scan all module files, or rely on something like the
modules.*map files of today?


> > Also realize that if you do this, you can't generate the existing
> > modules.*map files from the exported values.
> 
> 	Hmm, I thought about enhancing this code to generate the .map
> files as well (where it has all the information).  BTW, did I break
> the current depmod map-generating code?

I don't know, I haven't looked into that.  Just realize that if you
pre-process the information like you are proposing to do, you can't get
it back later, which changes the way things work.

thanks,

greg k-h
