Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUEVNbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUEVNbX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 09:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUEVNbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 09:31:23 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:18340
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S261234AbUEVNbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 09:31:09 -0400
Message-ID: <40AF55AF.2020506@winischhofer.net>
Date: Sat, 22 May 2004 15:29:19 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net> <20040522125108.GB4589@devserv.devel.redhat.com>
In-Reply-To: <20040522125108.GB4589@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, May 22, 2004 at 02:39:47PM +0200, Thomas Winischhofer wrote:
> 
>>I intend using them for controlling SiS hardware specific settings like 
>>switching output devices, checking modes against output devices, 
>>repositioning TV output, scaling TV output, changing gamma correction, 
>>tuning video parameters, and the like.
> 
> 
> That doesn't in principle sound SiS specific. Sure the implementation will
> be but the interface?

Don't get me wrong.. did you ever write a driver for graphics hardware? 
Different graphics cards have widely different features and 
restrictions, for example what output devices are supported and which 
output devices can be "mapped" to what CRT controller, what modes are 
supported on what output device if it's mapped to what CRT controller, 
whether the CRTCs really are independant or of they need "cooperation" 
in specific modes (because one of the CRTCs is crippled like in my case) 
etc etc etc.

Not that this would be much of an excuse, but not even the Windows folks 
have a unique interface for vendor specific things, like setting up dual 
head, video mirroring, etc. IMHO a generic interface will 1) force 
restrictions to supported features, 2) be bloated with stuff that will 
require a ton of checks and thereby lead to a requirement of smart 
userland applications that from the beginning will need to know about 
the specific hardware and its features - again.

What we are talking here are no essential things. What I want is simply 
a few ioctls for mostly (but, granted, not exclusively) very hardware 
specific things (at least as regards the possible arguments to the 
various ioctls).

>>And rest assured, they will be 32/64 bit safe. Not sure what you mean by 
>>"ioctl interface" here but have a look at the Matrox framebuffer driver 
>>which uses some 'n' ioctls for similar stuff (which in that way do not 
>>apply to the SiS hardware which is why I can't reuse them).
> 
> 
> Ok this is exactly the point I was trying to make. Would it be possible to
> have the "new" ioctl interface be such that they CAN be used by both matrox
> and Sis ?

The framebuffer drivers are - I am trying to say this nicely - a chaos 
as regards custom implementations for ioctls and extensions to the 
standard fb ioctls. I do not intend to wait until all the 
maintainers/authors agree on a unique interface which they haven't been 
able to in years.

These ioctls I intend to implement (and partly already have implemented) 
are nothing userland will need to know much about. They are going to be 
used by stuff like DirectFB (which needs a driver for specific hardware 
anyway), my config tool and the X driver (in order to restore the 
hardware state properly, including changes done during the X server 
session while switching back to another VT).

Is 64 out of, what's that, 65536 too much to ask? Well, I could live 
with 32 as well...

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
