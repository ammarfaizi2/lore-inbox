Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbTCJRVm>; Mon, 10 Mar 2003 12:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbTCJRVm>; Mon, 10 Mar 2003 12:21:42 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:51717 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261373AbTCJRVk>;
	Mon, 10 Mar 2003 12:21:40 -0500
Date: Mon, 10 Mar 2003 18:32:19 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030310173219.GA4152@win.tue.nl>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org> <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv> <20030309230824.GA3842@win.tue.nl> <Pine.LNX.4.44.0303101100250.5042-100000@serv> <20030310120534.GA4125@win.tue.nl> <Pine.LNX.4.44.0303101620020.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303101620020.5042-100000@serv>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 05:25:49PM +0100, Roman Zippel wrote:

> On Mon, 10 Mar 2003, Andries Brouwer wrote:
> 
> > > > -       error = register_chrdev(driver->major, driver->name, &tty_fops);
> > > > +       error = register_chrdev_region(driver->major, driver->minor_start,
> > > > +                                      driver->num, driver->name, &tty_fops);
> > > 
> > > Are that much parameters really needed?
> > 
> > Yes.
> 
> Why? Problems are hardly solved by adding more parameters.
> If going to a larger number space means, that we have to add crappy 
> interfaces, we should rather keep it as it is.
> Why do you need to partition the number space like this? I looked at the 
> users in the last mail for a reason. If we're going to change the 
> interface, it should reflect what we will need in the future.

Maybe I should not react, but let me answer once more.
You do not understand the part about "small steps".

You see a future and ask why I don't jump to the future you
see. The answer is that I take small steps.

Look at the current junk in char_dev.c and cry:
        if (ret && isa_tty_dev(major)) {
                lock_kernel();
                if (need_serial(major,minor)) {
                        /* Force request_module anyway, but what for? */
                        fops_put(ret);
                        ret = NULL;
                }
                unlock_kernel();
        }
Then be happy that it is gone.

You want a different interface? My changes make it easier for you
to get there. Please go ahead.

Andries

