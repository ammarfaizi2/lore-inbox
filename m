Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSKFVCN>; Wed, 6 Nov 2002 16:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266099AbSKFVCN>; Wed, 6 Nov 2002 16:02:13 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:47235 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266095AbSKFVCL>;
	Wed, 6 Nov 2002 16:02:11 -0500
Date: Wed, 6 Nov 2002 16:11:08 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@suse.cz>, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: yet another update to the post-halloween doc.
Message-ID: <20021106161108.GK316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@suse.cz>, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org
References: <20021106140844.GA5463@suse.de> <Pine.LNX.4.33.0211061526580.573-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211061526580.573-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 03:37:10PM +0100, Jaroslav Kysela wrote:
> On Wed, 6 Nov 2002, Dave Jones wrote:
> 
> > PnP layer
> > ~~~~~~~~~
> > - Support for plug and play devices such as early ISAPnP cards has
> >   improved a lot in the 2.5 kernel. You should no longer need to
> >   futz with userspace tools to configure IRQ's and the likes.
> > - This code is very young, and needs more work, but is more
> >   actively maintained than the previous ISAPnP work.
> > - Report any regressions in plug & play functionality to
> >   Adam Belay <ambx1@neo.rr.com>
> 
> Please, correct some mistakes:
> 
> - old ISA PnP code does not require user space tools, too
> - the new code is mostly based on idea to make behaviour same as for PCI 
>   devices (probe, remove etc. callbacks) and to merge the PnP BIOS 
>   access code
> - maintaince? the code was nearly complete, almost all device drivers were 
>   converted to support ISA PnP (thus autoconfiguration which has moved to 
>   the new PnP layer); I don't know what you mean that the code is more 
>   actively maintained; it was maintained to satisfy my goals 
>
> 						Jaroslav

I agree with Jaroslav's statements.  The PnP Layer Rewrite does not modify
much ISA PnP code.  It does, however, make substantial improvements to the
PnP BIOS code.  This protocol required user level tools to change resource
configurations prior to my work.  The PnP BIOS is used to detect non-isa
system devices, such as serial ports.

The reason ISA PnP drivers have to be modified is primarily that the PnP
Layer integrates PnP protocols into the driver model.  Before this drivers
would call the protocols individually.  Each protocol would have unique
functions to activate and disable devices.  Actually this is not entirely
true becuase pnp bios was not used at all in earlier 2.5 kernels.  Any way,
one of the major benifits of the PnP Layer is that it offers an expandible
PnP interface that is not dependent on PnP Protocol.  This will make it
easier to intigrate new PnP protocols such as ACPI.

In conclusion, the PnP Layer work is independent of ISAPNP and acts as a
unified interface for all plug and play devices.  PnP BIOS improvements
were made in order to fully support the PnP Layers capabilities.

I am primarily maintaining the PnP Layer and the PnP BIOS protocol.  I
will also be converting old ISAPnP drivers and supporting ISAPnP as needed.
Please all mainainers with PnP drivers or drivers with PnP capable devices
convert your drivers to the new PnP Layer.

Thanks for maintaining this feature list.

-Adam


P.S.: Many drivers have been converted already.  I'm working on the ALSA 
sound blaster driver now and I have made a patch for the gamemport driver
that I will be releasing soon.
