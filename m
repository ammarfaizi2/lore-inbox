Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbTCIW54>; Sun, 9 Mar 2003 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTCIW5z>; Sun, 9 Mar 2003 17:57:55 -0500
Received: from mailhost.tue.nl ([131.155.2.4]:64261 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262661AbTCIW5r>;
	Sun, 9 Mar 2003 17:57:47 -0500
Date: Mon, 10 Mar 2003 00:08:24 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309230824.GA3842@win.tue.nl>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org> <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303092310470.32518-100000@serv>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:18:24PM +0100, Roman Zippel wrote:
> On Sun, 9 Mar 2003, Andries Brouwer wrote:
> 
> > [I already submitted the patch throwing it out, but someone,
> > maybe it was Roman Zippel, complained that that was going
> > in the wrong direction. In the very long run that may be true
> > (or not), but for 2.6 I do not see the point of this dead code.]
> 
> My main question here is whether that code hurts in any way? Does it 
> prevent other cleanups? Sure this code needs more work to be really 
> useful, but as long as it only wastes a bit of space, I'd prefer to keep 
> it.

Yes, dead code always hurts.
In a global change - should this dead code also be updated?
To do what?

Andries


=====
        if (driver->flags & TTY_DRIVER_INSTALLED)
                return 0;
 
-       error = register_chrdev(driver->major, driver->name, &tty_fops);
+       error = register_chrdev_region(driver->major, driver->minor_start,
+                                      driver->num, driver->name, &tty_fops);
        if (error < 0)
                return error;
        else if(driver->major == 0)
=====
+int register_chrdev(unsigned int major, const char *name,
+                   struct file_operations *fops)
+{
+       return register_chrdev_region(major, 0, 256, name, fops);
+}
=====

