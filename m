Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271733AbTHHSad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTHHSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:30:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62182 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271733AbTHHSa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:30:28 -0400
Date: Fri, 8 Aug 2003 20:30:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Surprising Kconfig depends semantics
Message-ID: <20030808183020.GD16091@fs.tum.de>
References: <20030808144408.GX16091@fs.tum.de> <Pine.LNX.4.44.0308081708390.714-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081708390.714-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 05:13:48PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Fri, 8 Aug 2003, Adrian Bunk wrote:
> 
> > CONFIG_SERIO=m with CONFIG_KEYBOARD_ATKBD=y shouldn't be a valid 
> > combination.
> > 
> > The correct solution is most likely a
> > 	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> > 	default m if INPUT!=n && INPUT_KEYBOARD!=n && SERIO!=n
> 
> This is probably the easiest solution:
> 
> 	default INPUT_KEYBOARD && SERIO
> 
> (INPUT_KEYBOARD already depends on INPUT)

I'll send a
  default INPUT && INPUT_KEYBOARD && SERIO
patch (to address the things James said, in any cases it doesn't do any 
harm).

But it stays strange that a default can assign a value that isn't 
allowed by the depends, and you therefore have to write the depends 
twice in this case:

config KEYBOARD_ATKBD
        tristate "AT keyboard support" if EMBEDDED || !X86 
        default INPUT && INPUT_KEYBOARD && SERIO
        depends on INPUT && INPUT_KEYBOARD && SERIO


> > The semantics that in
> > 
> > config FOO
> > 	tristate
> > 	default y if BAR
> > 
> > FOO will be set to y if BAR=m is a bit surprising.
> 
> Why?

On a first thought I'd have expected it to be equivalent to
  default y if BAR=y

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

