Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUJYTuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUJYTuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUJYP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:59:00 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:7691 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261986AbUJYPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:42:00 -0400
Message-ID: <417D21C8.30709@techsource.com>
Date: Mon, 25 Oct 2004 11:54:48 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Some discussion points open source friendly graphics [was: HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still trying to digest all the feedback I've been getting.  It's 
overwhelming and gratifying, and I want to offer my gratitude for all 
the discussion and ideas.

It's been pointed out that some of this discussion may be getting 
off-topic for LKML.  My addition to that is that soon, it will get very 
specialized in graphics math, and it would be best to move to a list 
where people actually talk about this on a regular basis.

To that end, I'd appreciate it people could point me to some other 
appropriate mailing lists.  Not just the names, but URL's to the FAQ's 
which explain exactly how to subscribe, please.

Also, I'm thinking of starting my own yahoo groups list specifically for 
this chip.  Is that a good idea?

Next, I'm getting lots of ideas from people.  Some of them are core to 
the product, and some of them would be nice for follow-on products.  For 
instance, dual-video would not be on the first model released.  However, 
it is important that analog output always have crisp rise and fall times 
and be free of noise in order to maximize display quality.

The reprogramability of the FPGA has many advantages, but 
reprogramability is not its primary purpose.  The primary reason to use 
an FPGA is to minimize NRE for manufacturing.  However, as a result, 
users will be able to download updates.  Additionally, those who are 
dedicated enough to reprogram it completely will find the necessary 
documentation to do so.  Finally, it is my desire that we would release 
the source code to the FPGA for obsoleted products, however, it's too 
early to make promises.


Ok, now on to some design stuff:

The picture I have in my head at this time expands on the idea of the 
setup engine seen in most GPU's.  What I'm thinking is that the setup 
engine will be general-purpose-ish CPU with special vector and matrix 
instructions.  This way, the transformation stage will occur in 
"software" executed by a specialized processor.  Additionally, the 
lighting phase might be done here as well.

The setup engine would produce triangle parameters which are fed to a 
rasterizer which does Gouraud shading and texture-mapping.  That feeds 
pixels into something that handles antialiasing and alpha blending, etc.

The advantages are:

- The community can customize the setup engine as they please, just by 
writing code.
- This also includes the 2D emulation
- Anything "missing" can be emulated.

The disadvantages are:

- Triangle rate limited by speed of processor
- T&L is serialized, rather than being parallelized in dedicated hardware
- Phong shading and bump mapping may be impossible or too slow

It's been a while since I read about phong shading and bump mapping.  As 
I understand it, some of the lighting phase is pushed into the 
rasterizer.  With gouraud shading, colors are interpolated between the 
virtexes.  With phong shading, the surface normals are interpolated 
across the triangle, and that's used to compute lighting.  Bump mapping 
is like phong shading where the normals are specified in a bitmap.

What I don't know is how important bump-mapping and phong shading are.


