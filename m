Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWDEScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWDEScj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWDEScj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:32:39 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43489
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751319AbWDEScj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:32:39 -0400
Date: Wed, 5 Apr 2006 11:31:54 -0700
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model and character devices
Message-ID: <20060405183154.GB2466@kroah.com>
References: <44322A6F.4000402@yandex.ru> <20060404164823.GA31398@kroah.com> <44337759.4040507@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44337759.4040507@yandex.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 11:52:57AM +0400, Artem B. Bityutskiy wrote:
> Greg KH wrote:
> >Because "struct device" generally is not related to a major:minor pair
> >at all.  That is what a struct class_device is for.  Lots of struct
> >device users have nothing to do with a char device, and some have
> >multiple char devices associated with a single struct device.
> Well, OK, but AFAIK, your long-term plan is to merge class_device and 
> device, so in the long-term perspective it does not matter. And those 
> who do not need a character device support may have a possibility to 
> disable it.

Yes, that's my goal in the long term, and I have a patch availble that
starts to do that:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-class.patch

but we have a lot of work to get there.

And even then, a struct device will be separate from a char device.  For
one example, the cdev structure is used by the kernel to look up the
device properly, which has nothing to do with struct device (or struct
class_device) at all at this time.

thanks,

greg k-h
