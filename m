Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSJHV2M>; Tue, 8 Oct 2002 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJHV2M>; Tue, 8 Oct 2002 17:28:12 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:25097 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261643AbSJHV2L>;
	Tue, 8 Oct 2002 17:28:11 -0400
Date: Tue, 8 Oct 2002 14:30:08 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
Message-ID: <20021008213007.GA10193@kroah.com>
References: <Pine.LNX.4.44.0210081005320.16276-100000@cherise.pdx.osdl.net> <Pine.GSO.4.21.0210081616120.5897-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210081616120.5897-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 04:47:49PM -0400, Alexander Viro wrote:
> > 
> > The only timing issue is when the device structures are reused. And, it 
> > seems that that is inherently racy anyway with hotpluggable devices. 
> 
> BS.  Neither SCSI, nor USB nor PCI are reusing the structures in question.
> They are, however, freeing them.
> 
> Again, USB disconnect when you are holding a reference to struct device
> will leave you with pointer to kfree'd area.

This is a USB (and PCI) bug.  I'll fix them, they should be using the
release() callback that Pat has provided.  With that callback, which
gets called when the device really wants to be cleaned up, I don't see
any races in the USB code (well theoretical races, there's still some
bugs in the current implementation that I'm trying to track down...)

thanks,

greg k-h
