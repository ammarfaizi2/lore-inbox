Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSKBW3Q>; Sat, 2 Nov 2002 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSKBW3Q>; Sat, 2 Nov 2002 17:29:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40456 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261464AbSKBW3K>;
	Sat, 2 Nov 2002 17:29:10 -0500
Date: Sat, 2 Nov 2002 12:42:58 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to consolidate memory allocation in many drivers
Message-ID: <20021102204258.GA22607@kroah.com>
References: <20021102112951.A6910@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102112951.A6910@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:29:51AM -0800, Adam J. Richter wrote:
> 
> 	This patch allows device drivers to tell the generic device
> code to handle allocating the per-device blob of memory that is
> normally stored in device.driver_data.  It does so by adding a new
> field device_driver.drvdata_size, with the following semantics:

Ugh, have you tried to use this patch in real life with the busses that
use driver_data today?  I didn't think so :)

In short, only the driver's individual probe function knows how big of a
data chunk it needs, and that probe function isn't known until probe()
is called.  Hm, well ok, match() could set this, but then it would have
to call into the function found by match to get the size.  By then it's
just really not worth adding this extra complexity to the code.

So in short, I don't like this, and don't really see where it buys you
anything.

But I did like your pci private data cleanup patch from the other day,
mind if I add that into the next round of pci cleanups I'm going to be
sending to Linus?

thanks,

greg k-h
