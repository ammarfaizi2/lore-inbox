Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUK0D3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUK0D3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbUK0D2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:28:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:59315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262851AbUK0DY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:24:57 -0500
Date: Fri, 26 Nov 2004 19:24:03 -0800
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127032403.GB10536@kroah.com>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 06:17:42PM +0000, David Woodhouse wrote:
> On Thu, 2004-11-25 at 16:54 +0000, Matthew Wilcox wrote:
> > >      (d) stdint types should be used where possible.
> > > 
> > > 		[include/user-i386/termios.h]
> > > 		struct winsize {
> > > 			uint16_t ws_row;
> > > 			uint16_t ws_col;
> > > 			uint16_t ws_xpixel;
> > > 			uint16_t ws_ypixel;
> > > 		};
> > 
> > I really hate stdint.  Can't we use __u16 instead?
> 
> We're trying to clean all this crap up. I think we'd need a better
> justification than 'I hate stdint' to use anything other than the
> standard types which the language provides.

The justification is that it doesn't properly describe the variable size
(think userspace 32 bit variable vs. kernelspace 32 bit variable.)  We
need to stick with the proper __u32 type variables for data that crosses
the userspace/kernelspace boundry.

See Linus's posts about this topic on lkml in the past for more details
about this.

thanks,

greg k-h
