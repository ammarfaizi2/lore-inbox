Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263355AbTCNPNK>; Fri, 14 Mar 2003 10:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263356AbTCNPNK>; Fri, 14 Mar 2003 10:13:10 -0500
Received: from 237.oncolt.com ([213.86.99.237]:25281 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263355AbTCNPNI>; Fri, 14 Mar 2003 10:13:08 -0500
Subject: Re: devfs + PCI serial card = no extra serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3E6CD8B1.5070300@jpl.nasa.gov>
References: <200303081948.LAA05459@adam.yggdrasil.com>
	 <3E6CD8B1.5070300@jpl.nasa.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1047655430.14792.86.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 14 Mar 2003 15:23:50 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 18:25, Bryan Whitehead wrote:
> [snip]
> >       There is nothing in devfs that prevents you from registering
> > devfs devices even if they are not yet bound to specific hardware
> > (you do not need a sysfs mapping, for example).  So, you should be
> > able to register /dev/tts/0..N at initialization, where N is the
> > maximum number of serial devices you want to support.
> 
> are you saying there is a way to force devfs to make more entries in 
> /dev/tts/ without any hardware being attached to the entries? Then i can 
> use setserial? so on boot I'd have 4 entries in /dev/tts ?

Don't do this. The whole concept of opening a device node for a device
which is _absent_, then doing magic ioctls on it to make the driver
probe for the hardware, is utterly bogus.

Fix it properly instead -- disallow opening of a /dev/ttySx node with
uart type unknown, and implement a proper way to tell the serial driver
'please look for a device _here_', via sysfs or something. 

-- 
dwmw2

