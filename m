Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSLMFlL>; Fri, 13 Dec 2002 00:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSLMFlL>; Fri, 13 Dec 2002 00:41:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:65298 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261495AbSLMFlK>;
	Fri, 13 Dec 2002 00:41:10 -0500
Date: Thu, 12 Dec 2002 21:47:23 -0800
From: Greg KH <greg@kroah.com>
To: Larry Kessler <kessler@us.ibm.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Werner Almesberger <werner@almesberger.net>,
       James Keniston <kenistoj@us.ibm.com>
Subject: Re: Proposal:  Alan Cox dev_printk() with advanced logging support
Message-ID: <20021213054723.GC25099@kroah.com>
References: <3DF93A71.15678A95@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF93A71.15678A95@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:40:01PM -0800, Larry Kessler wrote:
> 
> The version of dev_printk() being proposed here is essentially a
> generalized version of these macros, with a small change to Alan's 
> version so that driver name and bus_id are prepended to the 
> message...
> 
>   #define dev_printk(sev, dev, format, arg...) \
>       printk(sev "%s %s: " format, (dev).driver->name, (dev).bus_id, ##arg)
>  
> Then the logging macros in device.h can be re-written like this...
>    #define dev_err(dev, format, arg...)           \
>          dev_printk(KERN_ERR, (dev), format, ## arg)
> ..and so on.  

I'd gladly accept a patch to add dev_printk() like this right now, if
you want.  But make sure you get the proper spacing to work properly on
older versions of gcc.  Your above macros are incorrect with regards to
that :)

> What is _not_ addressed by this proposal are a number of other issues raised
> in the past, that still need addressing.  For example...
> 
> 1) (from Jeff Garzik) There's little or no stanardization of messages across
>    different (but similar) devices.
> 
> 2) (from Jeff Garzik and Greg KH) There's little or no guidance about what device
>    specific details are most useful for Problem Determination, Sys Administration,
>    etc.
> 
>    However, consistently identifying which device, plus state info from the device
>    struct, plus other info. like source file, function name, and line number,
>    provided with event logging, should certainly be useful in some cases. 
>    As the device struct continues to evolve, it will become more clear which
>    device attributes are appropriate to log.

I really feel strongly that these questions need to be answered properly
before we start adding the larger event logging stuff to the main kernel
tree.

Oh yeah, patches to actually _use_ these dev_*() functions would also be
appreciated.  It looks like only one very tiny driver subsystem has
started to use them.  Patches from your group to change this would be
welcome.

thanks,

greg k-h
