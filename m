Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSLMRXt>; Fri, 13 Dec 2002 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSLMRXt>; Fri, 13 Dec 2002 12:23:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44036 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261433AbSLMRXs>;
	Fri, 13 Dec 2002 12:23:48 -0500
Date: Fri, 13 Dec 2002 09:29:56 -0800
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: dmfs for 2.5.51
Message-ID: <20021213172956.GB27800@kroah.com>
References: <20021213012618.GH23509@kroah.com> <20021213093745.GB1117@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213093745.GB1117@reti>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 09:37:45AM +0000, Joe Thornber wrote:
> Greg,
> 
> On Thu, Dec 12, 2002 at 05:26:19PM -0800, Greg KH wrote:
> > Here's a patch against 2.5.51 with a updated dmfs.
> 
> I've split out your two changes into seperate patches (patches 21 and
> 22) and made them available here:
> 
> http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.51/2.5.51-dmfs-1/

Thanks.

> > with the following modifications:
> > 	- fixed compile time warnings with the dbg() macro (something
> > 	  better should be used here, I just commented it out...)
> 
> I'm not seeing any warnings, which compiler version are you using ?

The latest for Red Hat 7.2: gcc-2.96-112.7.2
Are you using 3.2?

> > 	- changed the dev file to print out the kdev value, not be the
> > 	  actual block device.
> 
> Should we really be exporting a kdev_t to userland, why not just print out
> 
> <major>:<minor>

No, look at the other dev files in sysfs, I stayed consistant with them.

> > With regards to the last change, I didn't follow the way the other files
> > operate with their complex page creation structure, as this is only a
> > simple one line file.  If the lvm developers want me to change this, I
> > will.
> 
> What you've done looks fine to me, though allocating a whole page to
> hold a single number seems overkill.  Why don't you just snprintf into
> a char[] held on the stack ?

Because I forgot you could do copy_to_user() with data on the stack :)
Good point, I'll change it...

> > If not, I would argue that a number of the other files created
> > should be changed to use this simpler format.  Or is there some reason
> > for creating these lists of pages that I'm missing?
> 
> The files can be larger than a single page, which complicates things
> somewhat.

Hm, then using the seq_file interface might be easier.  I'll look into
this.

thanks,

greg k-h
