Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbTCQI0Y>; Mon, 17 Mar 2003 03:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbTCQI0Y>; Mon, 17 Mar 2003 03:26:24 -0500
Received: from krynn.axis.se ([193.13.178.10]:1945 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S262409AbTCQI0X>;
	Mon, 17 Mar 2003 03:26:23 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB01CAF576@mailse01.se.axis.com>
From: Jonas Holmberg <jonas.holmberg@axis.com>
To: "'Joern Engel'" <joern@wohnheim.fh-wedel.de>,
       David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Fix stack usage for amd_flash.c
Date: Mon, 17 Mar 2003 09:36:38 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 14 March 2003 16:05:10 +0000, David Woodhouse wrote:
> > On Fri, 2003-03-14 at 15:46, Joern Engel wrote:
> > 
> > Urgh. That should never have been on the stack in the first 
> place. Make
> > it static. The comment about being deallocated when the 
> probe is done is
> > bogus -- where do we think we get the contents of the table 
> from when
> > _entering_ the probe function anyway? It's elsewhere in the kernel
> > image.

My bad, sorry.

> > Also note that all but the CFI-based drivers are deprecated. We have
> > old-style probes which allow us to use the CFI back-end drivers with
> > non-CFI chips anyway.
> 
> Right. But since 2.[567] is going towards 4k kernel stack, those
> drivers should be fixed or revomed. If you don't remove it, I'll try
> to fix it. :)

We're still using the amd_flash-driver a lot because I haven't got time
to try out the jedec_probe since the toggle-bit stuff was added in the
CFI driver. I made some rough tests just before that, and jedec_probe +
CFI driver turned out to be much slower than amd_flash. But then the CFI
driver was modified... I'll try to get some time to test them again soon
and maybe even do something about it.

/Jonas
