Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHJIpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHJIpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUHJIpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:45:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48067 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262574AbUHJIoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:44:16 -0400
Date: Tue, 10 Aug 2004 10:44:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040810084411.GI26174@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408100130470.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 02:24:47AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 9 Aug 2004, Sam Ravnborg wrote:
> 
> > No - kconfig gets it wrong.
> > When selecting a config option kconfig shall secure that
> > 'depends on' are evaluated also for the selected symbol.
> 
> Which dependencies? select was more intended to select symbols without a 
> prompt (it's dependency would be simply 'n'). The selected symbol can also 
> have multiple prompts, how should these dependencies be merged?
> The current select is intentionally simple, so the calculation is 
> straightforward. Anything more complex I have to completely rethink the 
> behaviour between depencies and selects, e.g. something like this:
> 
> 	A ---selects----> C ---selects----> D
> 	B --depends on-->   --depends on--> E
> 
> If you want to change the behaviour of select how will it change the 
> behaviour of the other dependencies and selects?
>...

The current usage of select in the kernel covers many select's of 
symbols that actually have a prompt.

I assume Sam thinks in the direction to let a symbol inherit the 
dependencies off all symbols it selects.

E.g. in

config A
	depends on B

config C
	select A


C should be treated as if it would depend on B.


> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

