Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbUJYUnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUJYUnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUJYUlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:41:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261997AbUJYUfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:35:04 -0400
Message-ID: <417D6365.3020609@pobox.com>
Date: Mon, 25 Oct 2004 16:34:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com>
In-Reply-To: <417D21C8.30709@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> Also, I'm thinking of starting my own yahoo groups list specifically for 
> this chip.  Is that a good idea?

In theory it's useful; in reality at you'll have to balance what's 
public and what's not, and it's easy to allow yourself to get bogged 
down into "digesting", so much so that the "doing" is put off.

My only request is that you (a) make the graphics interface as simple 
and high level as feasible and (b) you publish the hardware interface 
specification as soon as possible, so that driver work can occur in 
parallel.


> Next, I'm getting lots of ideas from people.  Some of them are core to 
> the product, and some of them would be nice for follow-on products.  For 
> instance, dual-video would not be on the first model released.  However, 
> it is important that analog output always have crisp rise and fall times 
> and be free of noise in order to maximize display quality.

Once you have a core design, it's easier to dicker about specific 
features.  I would put this stuff on the "worry about it later" list.


> The reprogramability of the FPGA has many advantages, but 
> reprogramability is not its primary purpose.  The primary reason to use 
> an FPGA is to minimize NRE for manufacturing.  However, as a result, 
> users will be able to download updates.  Additionally, those who are 

Will the capability to apply these updates be included with the base card?
Will users need to purchase additional "update FPGA" hardware to do the 
reprogramming?


> Ok, now on to some design stuff:
> 
> The picture I have in my head at this time expands on the idea of the 
> setup engine seen in most GPU's.  What I'm thinking is that the setup 
> engine will be general-purpose-ish CPU with special vector and matrix 
> instructions.  This way, the transformation stage will occur in 
> "software" executed by a specialized processor.  Additionally, the 
> lighting phase might be done here as well.
> 
> The setup engine would produce triangle parameters which are fed to a 
> rasterizer which does Gouraud shading and texture-mapping.  That feeds 
> pixels into something that handles antialiasing and alpha blending, etc.
> 
> The advantages are:
> 
> - The community can customize the setup engine as they please, just by 
> writing code.
> - This also includes the 2D emulation
> - Anything "missing" can be emulated.
> 
> The disadvantages are:
> 
> - Triangle rate limited by speed of processor
> - T&L is serialized, rather than being parallelized in dedicated hardware
> - Phong shading and bump mapping may be impossible or too slow

Well, I certainly like it :)

I think that a more generic approach allows you to recognize performance 
bottlenecks, and update the IP core to support instructions specific to 
(say) triangles.

Random closing notes:

* data movement will be an everpresent issue

* in graphics you really have a number of data types (16-bit float, 
etc.) that are specific to graphics.  Supporting these natively should 
be quite helpful, if not an already-obvious prerequisite

	Jeff


