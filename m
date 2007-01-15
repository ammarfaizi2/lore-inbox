Return-Path: <linux-kernel-owner+w=401wt.eu-S1750729AbXAOVYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAOVYb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbXAOVYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:24:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54179 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXAOVY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:24:29 -0500
Subject: Re: allocation failed: out of vmalloc space error treating and
	VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
From: Arjan van de Ven <arjan@infradead.org>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
Cc: David Moore <dcm@mit.edu>, linux1394-devel@lists.sourceforge.net,
       theSeinfeld@users.sourceforge.net, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
In-Reply-To: <59ad55d30701151306q492e07aep9c640afd7b6c442f@mail.gmail.com>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org> <45ABC1A2.90109@tmr.com>
	 <1168885223.3122.304.camel@laptopd505.fenrus.org>
	 <1168890881.10136.29.camel@pisces.mit.edu>
	 <59ad55d30701151306q492e07aep9c640afd7b6c442f@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 15 Jan 2007 13:24:17 -0800
Message-Id: <1168896257.3122.577.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, what I'd really like to do is to leave it to user space to
> allocate the memory as David describes.  In the transmit case, user
> space allocates memory (malloc or mmap) and loads the payload into
> that buffer.

there is a lot of pain involved with doing things this way, it is a TON
better if YOU provide the memory via a custom mmap handler for a device
driver.
(there are a lot of security nightmares involved with the opposite
model, like the user can put any kind of memory there, even pci mmio
space)

>   Then is does an ioctl() on the firewire control device

ioctls are evil ;) esp an "mmap me" ioctl

> It's not too difficult from what I'm doing now, I'd just like to give
> user space more control over the buffers it uses for streaming (i.e.
> letting user space allocate them).  What I'm missing here is: how do I
> actually pin a page in memory?  I'm sure it's not too difficult, but I
> haven't yet figured it out and I'm sure somebody knows it off the top
> of his head.

again the best way is for you to provide an mmap method... you can then
fill in the pages and keep that in some sort of array; this is for
example also what the DRI/DRM layer does for textures etc...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

