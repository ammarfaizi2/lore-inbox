Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbVLGSIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbVLGSIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVLGSIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:08:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750872AbVLGSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:08:54 -0500
Date: Wed, 7 Dec 2005 18:08:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: dtor_core@ameritech.net, Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207180842.GG6793@flint.arm.linux.org.uk>
Mail-Followup-To: dtor_core@ameritech.net, Greg KH <greg@kroah.com>,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 12:59:09PM -0500, Dmitry Torokhov wrote:
> On 12/7/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Monday 05 December 2005 15:27, Russell King wrote:
> > > On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > > > The name parameter of platform_device_register_simple should be of
> > > > type const char * instead of char *, as we simply pass it to
> > > > platform_device_alloc, where it has type const char *.
> > > >
> > > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > >
> > > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > >
> > > However, I've been wondering whether we want to keep this "simple"
> > > interface around long-term given that we now have a more flexible
> > > platform device allocation interface - I don't particularly like
> > > having superfluous interfaces for folk to get confused with.
> >
> > Now that you made platform_device_alloc install default release
> > handler there is no need to have the _simple interface. I will
> > convert input devices (main users of _simple) to the new interface
> > and then we can get rid of it.
> >
> 
> I have started moving drivers from the "_simple" interface and I found
> that I'm missing platform_device_del that would complement
> platform_device_add. Would you object to having such a function, like
> we do for other sysfs objects? With it one can write somthing like
> this:

Greg and myself discussed that, and we decided that it was adding
unnecessary complexity to the interface.  Maybe Greg's view has
changed?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
