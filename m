Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWFBWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWFBWrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFBWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:47:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932365AbWFBWrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:47:14 -0400
Date: Fri, 2 Jun 2006 15:44:35 -0700
From: Greg KH <gregkh@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: lcapitulino@mandriva.com.br, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
Message-ID: <20060602224435.GA26061@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br> <1149217398434-git-send-email-lcapitulino@mandriva.com.br> <20060602205014.GB31251@suse.de> <20060602154121.d3f19cbe.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602154121.d3f19cbe.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 03:41:21PM -0700, Pete Zaitcev wrote:
> On Fri, 2 Jun 2006 13:50:14 -0700, Greg KH <gregkh@suse.de> wrote:
> > On Fri, Jun 02, 2006 at 12:03:14AM -0300, Luiz Fernando N.Capitulino wrote:
> 
> > >   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
> > >      documentation says that that method must not sleep, but I couldn't find
> > >      where in the Serial Core code it's called in atomic context. So, is this
> > >      still true? Isn't the Serial Core's documentation out of date?
> > 
> > If this is true then we should just stop the port right now, as the USB
> > devices can not handle this.  They need to be able to sleep to
> > accomplish this functionality.
> > 
> > Russell, is this a requirement of the serial layer?  Why?
> 
> Shouldn't it be all right to schedule the change at the moment of
> that call and have it happen later? Resisting a temptation to abuse
> keventd and schedule_work and using a tasklet may help with latency
> enough to make this tolerable.

Some devices require more than one usb message to set all of the proper
termios bits in the device.  Creating a way to queue them up and fire
them off later, and handle errors if something happened in the middle,
after we told userspace the termios change succeeded, might get quite
messy :(

thanks,

greg k-h
