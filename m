Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUDPQqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDPQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:46:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:62633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263442AbUDPQqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:46:37 -0400
Date: Fri, 16 Apr 2004 09:40:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Timothy Miller <miller@techsource.com>
Cc: benh@kernel.crashing.org, felix-kernel@fefe.de,
       linux-kernel@vger.kernel.org
Subject: Re: radeonfb broken
Message-Id: <20040416094038.5ae1bc52.rddunlap@osdl.org>
In-Reply-To: <4080047E.9050804@techsource.com>
References: <20040415202523.GA17316@codeblau.de>
	<407EFB08.6050307@techsource.com>
	<1082079792.2499.229.camel@gaston>
	<4080047E.9050804@techsource.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 12:06:22 -0400 Timothy Miller wrote:

| 
| BTW, now that we're on the topic of Radeon, could someone tell me how to 
| tell the kernel the default resolution to use when initializing the 
| console?
| 
| When using a CRT, it defaults to 640x480.  When I use my Planar PQ191 
| 19" 1280x1024 monitor, it defaults to 1024x768.  I want it to default to 
| 1280x1024.  There's a tool, fbset or something like that, which I can 
| use AFTER bootup, but trying to put that into init causes all sorts of 
| conflicts.  I need to be able to tell the kernel, either at compile time 
| or on the boot command line.

See <Documentation/fb/modedb.txt> for a little help: <quote>

Valid mode specifiers (mode_option argument):

    <xres>x<yres>[-<bpp>][@<refresh>]
    <name>[-<bpp>][@<refresh>]

with <xres>, <yres>, <bpp> and <refresh> decimal numbers and <name> a string.
Things between square brackets are optional.
</quote>


I haven't done this, but I've seen emails using syntax like so:

(from /etc/lilo.conf:)

append="video=radeonfb:1024x768-32@100"

or:
append="video=radeonfb radeonfb.mode_option=1280x1024-32@60"

or:
append="video=radeonfb:1024x768-32@100"


Looking at the driver source code, I'd guess that the middle
one above is closest to correct.

ISTM that Documentation/kernel-parameters.txt needs a paragraph
about syntax for specifying parameters for built-in modules vs.
loadable modules....


| Moving off topic, my cries for help from the XFree86 people also seem to 
| have gotten lost in the flow of hundreds of usenet messages.  Try as I 
| might, I cannot seem to get XFree86 to talk to my monitor at anything 
| other than 60Hz.  Even though LCD monitors have a persistent image, 
| increasing the frame rate CAN reduce motion blur slightly.


--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
