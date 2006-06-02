Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWFBUvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWFBUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFBUvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:51:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:22664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964856AbWFBUvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:51:08 -0400
Date: Fri, 2 Jun 2006 13:48:39 -0700
From: Greg KH <gregkh@suse.de>
To: "Luiz Fernando N.Capitulino" <lcapitulino@mandriva.com.br>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060602204839.GA31251@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 12:03:06AM -0300, Luiz Fernando N.Capitulino wrote:
> 
>  Hi folks.
> 
>  This patch series is my first attempt to port the USB-Serial layer to the
> Serial Core API. Currently USB-Serial uses the TTY layer directly, duplicating
> code and solutions from the Serial Core implementation.
> 
>  The final (ported) USB-Serial code is simpler and cleaner. Now I'd like to know
> whether I'm doing it right or not.
> 
>  Note that this is a work in progress though. I've only ported the USB-Serial
> core and one of its drivers, the pl2303 one.
> 
>  Most of my questions and design decisions are adressed in the patches, please
> refer to them for details.

Nice first cut at this.  But please try to also convert 2 other drivers
at the same time to make sure that the model is right.  I'd suggest the
io_edgeport and the funsoft drivers.  io_edgeport because it is very
complex in that it doesn't share a single bulk in/out pair for every
port, but multiplexes them all through one pipe.  And funsoft because we
want to still be able to write usb-serial drivers that are this simple.

I agree with most of Pete's comments and like the general idea of moving
the usb-serial core to be more like libata (provider of helper
functions, not getting in the middle of everything).  I'll wait for your
next cut to provide specific code comments.

thanks,

greg k-h
