Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWBTWfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWBTWfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBTWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:35:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:52665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932680AbWBTWfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:35:54 -0500
Date: Mon, 20 Feb 2006 14:24:49 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <lethal@linux-sh.org>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220222449.GC28042@kroah.com>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219185254.GA13391@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 08:52:54PM +0200, Paul Mundt wrote:
> On Sun, Feb 19, 2006 at 09:56:23AM -0800, Greg KH wrote:
> > Note that Pat isn't the sysfs maintainer anymore :)
> > 
> My mistake, I'll check MAINTAINERS instead of the file comments next
> time.
> 
> > On Sun, Feb 19, 2006 at 07:17:48PM +0200, Paul Mundt wrote:
> > > Now with relayfs integrated and the relay_file_operations exported for
> > > use by other file systems, I wonder what people think about adding in a
> > > sysfs attribute for setting up channel buffers.
> > 
> > Looks good, I like it.  This properly handles the module owner stuff,
> > too, right?
> > 
> Could you elaborate on which module owner issue you're referring to?
> struct relay_attribute encapsulates a struct attribute, and it's handled
> the same way as the other attribute types (I modelled it after
> struct bin_attribute), and I don't see any places that I missed.
> 
> When setting up the relay attribute, it's just a matter of:
> 
> 	static struct relay_attribute dev_relay_attr = {
> 		.attr	= {
> 			.owner	= THIS_MODULE,
> 			...
> 		},
> 		...
> 	};
> 
> Let me know if I've missed anything.

No, you are right, just wanted to make sure that the .owner stuff is
there.

One thing to note, a lot of people forgot to set that field for binary
attribute files, while "normal" attributes get it set "automatically"
due to the macro that was used to create them.  You might consider also
creating a macro for this struture so people can not forget to set the
field.

thanks,

greg k-h
