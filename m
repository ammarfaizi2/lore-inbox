Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSLMFTj>; Fri, 13 Dec 2002 00:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSLMFTj>; Fri, 13 Dec 2002 00:19:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62226 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261401AbSLMFTi>;
	Fri, 13 Dec 2002 00:19:38 -0500
Date: Thu, 12 Dec 2002 21:25:51 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: dmfs for 2.5.51
Message-ID: <20021213052551.GB25099@kroah.com>
References: <20021213012618.GH23509@kroah.com> <3DF93CC9.979CA988@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF93CC9.979CA988@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:50:01PM -0800, Andrew Morton wrote:
> Greg KH wrote:
> > 
> > ..
> > +Examples
> > +--------
> > +
> > +Example commands will make things a bit clearer:
> 
> hm.  The whole thing seems hokey to me.  Not sure why.

I agree.  It doesn't feel right.  I mean, doing a mkdir(1) to create a
device, which causes files to be created automagically in that
directory?  Something needs to change here, and I proposed a single file
to write to that creates the device, but was shot down by the author.

Anyone else have any ideas?

> > ...
> > +  echo -e "0 56 linear /dev/hda3 0\n56 102344 linear /dev/hda4 0" > table
> 
> Maybe this is why.

Heh, yeah, welcome to parsers in the kernel :)
But the dm code today does much the same thing with ioctls, passing a
string down to the loaded modules below it.  So there is a bit of
president.  Even if it is ugly :)

> > ...
> > +static struct page *find_page(struct dmfs_file *f, loff_t len, int fill)
> 
> This is called under spinlock.
> 
> > ...
> > +                       void *addr = (void *) __get_free_page(GFP_KERNEL);
> 
> whoops.

Nice catch.  I'm not sure that the find_page(), __io() and friends
functions are really needed at all.

Thanks for looking at this.  I hope the dm authors can help explain
more.

greg k-h
