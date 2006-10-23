Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWJWSbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWJWSbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWJWSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:31:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:27078 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965001AbWJWSbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:31:12 -0400
Date: Mon, 23 Oct 2006 11:30:48 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, davidz@redhat.com,
       mjg59@srcf.ucam.org, len.brown@intel.com, sfr@canb.auug.org.au,
       benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061023183048.GA13804@kroah.com>
References: <1161627633.19446.387.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161627633.19446.387.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 07:20:33PM +0100, David Woodhouse wrote:
> At git://git.infradead.org/battery-2.6.git there is an initial
> implementation of a battery class, along with a driver which makes use
> of it. The patch is below, and also viewable at 
> http://git.infradead.org/?p=battery-2.6.git;a=commitdiff;h=master;hp=linus
> 
> I don't like the sysfs interaction much -- is it really necessary for me
> to provide a separate function for each attribute, rather than a single
> function which handles them all and is given the individual attribute as
> an argument? That seems strange and bloated.

It is, but no one has asked for it to be changed to be like the struct
device attributes are.  In fact, why not just use the struct device
attributes here instead?  That will be much easier and keep me from
having to convert your code over to use it in the future :)

> I'm half tempted to ditch the sysfs attributes and just use a single
> seq_file, in fact.

Ick, no.  You should use the hwmon interface, and standardize on a
proper battery api just like those developers have standardized on other
sensor apis that are exported to userspace.  Take a look at
Documentation/hwmon/sysfs-interface for an example of what it should
look like.

> The idea is that all batteries should be presented to userspace through
> this class instead of through the existing mess of PMU/APM/ACPI and even
> APM _emulation_.

Yes, I agree this should be done in this manner.

> I think I probably want to make AC power a separate 'device' too, rather
> than an attribute of any given battery. And when there are multiple
> power supplies, there should be multiple such devices. So maybe it
> should be a 'power supply' class, not a battery class at all?

That sounds good to me.

Jean, I know you had some ideas with regards to this in the past.

thanks,

greg k-h
