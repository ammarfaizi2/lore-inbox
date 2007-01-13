Return-Path: <linux-kernel-owner+w=401wt.eu-S1161188AbXAMCAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbXAMCAa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 21:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbXAMCAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 21:00:30 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22639 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161190AbXAMCA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 21:00:29 -0500
Message-ID: <45A83D37.2010807@tls.msk.ru>
Date: Sat, 13 Jan 2007 05:00:23 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: /sys/$DEVPATH/uevent vs uevent attributes
References: <45A7E23A.6000100@tls.msk.ru> <20070113004817.GA4870@kroah.com>
In-Reply-To: <20070113004817.GA4870@kroah.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jan 12, 2007 at 10:32:10PM +0300, Michael Tokarev wrote:
>> (No patch at this time, -- just asking about an.. idea ;)
> 
> Let's see what such a patch looks like to see if it would be workable or
> not.

Umm.. it's definitely workable, and even almost trivial.

Just splitting kobject_uevent() routine into two parts, one to format
the environment variables, and one to actually send things over netlink
and executing the hotplug_helper if defined, and using the first part
to format the content of `uevent' file will do the trick.

I don't know how to do the last part.

> And no one forces you to use udev, I have machines with a static /dev
> that work just fine :)

It has less and less chances to work correctly.  For example, this dynamic
sdX thing, when I don't know anymore which sdX is which, without some help
from /dev/disk/by-XXX/.

And more and more software requires udev, at least as packages by distos.
For example, today I've got rid of udev on one of our servers, which has
been installed (debian) due to xen-utils having Depends: udev.  Even when
it doesn't *really* *require* udev, -- i replaced the whole thing with a
5-line shell script.

/mjt
