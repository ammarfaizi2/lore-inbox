Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVAFWtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVAFWtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFWtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:49:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46511 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263090AbVAFWsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:48:14 -0500
Date: Thu, 6 Jan 2005 14:48:03 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Petr Vandrovec <vandrove@vc.cvut.cz>, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, mst@mellanox.co.il,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [linux-usb-devel] Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106224803.GA17646@kroah.com>
References: <20050106145356.GA18725@infradead.org> <20050106210921.GK5772@vana.vc.cvut.cz> <20050106212424.GA6465@kroah.com> <200501061359.25719.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501061359.25719.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 01:59:25PM -0800, David Brownell wrote:
> On Thursday 06 January 2005 1:24 pm, Greg KH wrote:
> > > P.S.: ?When designing new API, please do not make it unnecessary complicated.
> > > USB video needs rather large bandwidth and low latency, so please no ASCII
> > > strings, and scatter-gather aware API helps a bit...
> > 
> > In measurements published on linux-usb-devel, pure userspace calls using
> > the current usbfs code generated almost full bandwidth usage (within the
> > hardware limits). ?So adding the scatter-gather api interface to usbfs
> > wouldn't really provide that much benefit.
> 
> Actually, the measurements I recall were using that
> nasty usbfs-specific async API ... or using huge
> buffers with the synchronous/blocking calls, so
> the hiccups added by scheduling latencies didn't
> kick in very often.

Ah, yeah, that's true.

> > And, we can always use help in designing such an API, if you could find
> > someone at your company to help us out in doing so... :)
> 
> Or just doing something like gadgetfs, where the standard
> Linux "libaio" calls work just fine.  I was certainly able
> to stream 24 Mbyte/sec isochronous transfers (that's the
> top speed possible with one high speed ISO endpoint).
> 
> The key point is that one userspace IOCB should map directly
> to one URB in the kernel; and one userspace file (descriptor)
> should map to one USB endpoint.  For a host side API, it turns
> out that isochronous URBs already have limited scatter/gather
> style support -- each one maps to several packets.
> 
> I think it'd be best to use the existing AIO support rather
> than have usbfs2 create yet another USB-specific thing.

I completely agree.

greg k-h
