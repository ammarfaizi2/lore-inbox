Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992565AbWJTHfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992565AbWJTHfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992566AbWJTHfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:35:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:63170 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S2992565AbWJTHfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:35:23 -0400
Subject: Re: [PATCH] Add device addition/removal notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20061020061618.GA9432@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	 <20061020032624.GA7620@kroah.com>
	 <1161318564.10524.131.camel@localhost.localdomain>
	 <20061020044454.GA8627@kroah.com>
	 <1161322979.10524.143.camel@localhost.localdomain>
	 <20061020061618.GA9432@kroah.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 17:35:06 +1000
Message-Id: <1161329707.10524.184.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ick, I'd like to say that this is a pretty bad thing to do.  If you need
> that, then just statically link the bus into your code, or make your
> code a module and it will depend on the usb core.  I don't know...
> 
> Remember, we didn't add a type identifier to the struct device for a
> reason, comparing the string of the bus type is not a good idea (for
> USB, it will get you in trouble, because two different types of devices
> can be on that bus, who's to say other busses will not also have that
> issue?)
> 
> I think you need to re-evaluate exactly what you are needing to do
> here...

BTW. You basic saying that one should not test the bus type of a generic
struct device* makes it basically impossible to implement dma_map_* on
platforms that have various bus types with different DMA operations :)

Note that what I'm working on at the moment might make all of that
easier anyway, by having (on powerpc only for now but some of that could
be made generic once I'm finished) dma_ops having off the struct device
(or rather an extension of it).

Oh, also, right now, I re-use the firmware_data pointer there to point
to my struct device_ext, but I'd like to be better typed and avoid too
many pointer dereferences. I'm thus thinking instead of defining an
asm-*/device.h where archs can define their own struct device_ext and
have that flat in struct device (default being an empty struct). We
could even get rid of firmware_data on archs that don't use it by
putting it there :) (Among others).

Ben.


