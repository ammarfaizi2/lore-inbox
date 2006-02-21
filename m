Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWBUXBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWBUXBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWBUXBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:01:01 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36746
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161196AbWBUXBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:01:00 -0500
Date: Tue, 21 Feb 2006 15:00:45 -0800
From: Greg KH <gregkh@suse.de>
To: Tilman Schmidt <t.schmidt@phoenixsoftware.de>
Cc: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: advice on using dev_info(), dev_err() and friends (was: [PATCH 2/9] isdn4linux: Siemens Gigaset drivers - common module)
Message-ID: <20060221230045.GA21027@suse.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de> <20060215032659.GB5099@suse.de> <43FB475A.5050108@phoenixsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB475A.5050108@phoenixsoftware.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 06:01:14PM +0100, Tilman Schmidt wrote:
> Hello Greg,
> 
> thank you for your comments. Just a few follow-up questions.
> 
> On 15.02.2006 04:27, Greg KH wrote:
> > On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
> > 
> >>--- linux-2.6.16-rc2/drivers/isdn/gigaset/gigaset.h	1970-01-01 01:00:00.000000000 +0100
> >>+++ linux-2.6.16-rc2-gig/drivers/isdn/gigaset/gigaset.h	2006-02-11 15:20:26.000000000 +0100
> [...]
> >>+#undef info
> >>+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
> > 
> > Care to use the dev_info(), dev_err() and other dev_* friends instead of
> > rolling your own?  It gives you a much easier and standardised way of
> > identifying the driver and individual device that the message is
> > happening for.
> 
> This turns out to be surprisingly tricky, as these macros take a device
> pointer argument which mustn't be NULL either.
> 
> Could you please advise how to use these when I do not have a device
> pointer available (ie. before the probe method has been called)

That's very hard, and I would not worry about that situation.

> or when there is a risk of it being no longer valid (ie. the USB
> device has been unplugged)? 

If it's been unplugged, and you already saved a reference to it with a
call to "usb_get_dev()" you are safe, and can use the pointer.  If you
have not called it, then your code needs to be fixed :)

thanks,

greg k-h
