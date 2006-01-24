Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWAXFDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWAXFDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 00:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWAXFDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 00:03:54 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:27295
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964861AbWAXFDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 00:03:54 -0500
Date: Mon, 23 Jan 2006 21:03:46 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: uevent buffer overflow in input layer
Message-ID: <20060124050346.GC22848@kroah.com>
References: <1137973421.4907.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137973421.4907.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 10:43:41AM +1100, Benjamin Herrenschmidt wrote:
> Current -git as of today does this on an x86 box with a logitech USB
> keyboard:
> 
> (the $$$ is debug stuff I added to print_modalias(), size is the size
> passed in and "Total len" is the value of "len" before returning). We
> end up overflowing, thus we pass a negative size to snprintf which
> causes the WARN_ON. Bumping the uevent buffer size in lib/kobject_uevent.c
> from 1024 to 2048 seems to fix the oops and /dev/input/mice is now properly
> created and works (it doesn't without the fix, X fails and we end up back
> in console with a dead keyboard).
> 
> I'm not sure it's the correct solution as I'm not too familiar with the
> uevent code though, so I'll let you guys decide on the proper approach.

Yes, input has some big strings, I'd recommend bumping it up like you
suggest.

Care to make up a patch as you found the problem and should get the
credit?  :)

thanks,

greg k-h
