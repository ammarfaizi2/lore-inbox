Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbTFNIk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbTFNIk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:40:28 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26037 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265645AbTFNIk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:40:27 -0400
Date: Sat, 14 Jun 2003 10:54:12 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, OverrideX <overridex@punkass.com>,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 hangs on boot
Message-ID: <20030614105412.B12208@ucw.cz>
References: <1055466518.29294.10.camel@nazgul> <20030613214944.GA10406@suse.de> <20030614001209.E10851@ucw.cz> <20030613221922.GA11121@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613221922.GA11121@suse.de>; from davej@codemonkey.org.uk on Fri, Jun 13, 2003 at 11:19:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:19:22PM +0100, Dave Jones wrote:
> On Sat, Jun 14, 2003 at 12:12:09AM +0200, Vojtech Pavlik wrote:
> 
>  > > This really wants fixing badly. The source of this problem seems to be
>  > > people taking 2.4 configs (where CONFIG_INPUT=m was fine), and it all
>  > > going pear-shaped when people make oldconfig.  I'm aware of the problems
>  > > that oldconfig can't override variables set in .config, so how about 
>  > > just renaming CONFIG_INPUT to something else ?
>  > 
>  > I'm considering CONFIG_INPUT_ADVANCED, which would default to 'n', like
>  > with the font and parition config and if set to 'n', all the modules
>  > needed for 2.4 functional compatibility would be automatically built in.
>  > What do you think?
> 
> I don't see how this helps the situation. CONFIG_INPUT=m from a 2.4
> config will still make CONFIG_VT not show up in the 2.5 config.

I was thinking this:

if CONFIG_INPUT_ADVANCED
	config INPUT_MOUSEDEV
		tristate "Mouse interface"
        	default y
        	depends on INPUT
	config INPUT_MOUSEDEV_PSAUX
		bool "Provide legacy /dev/psaux device"
		default y
		depends on INPUT_MOUSEDEV
else
	config INPUT_MOUSEDEV
		tristate
		default y
	config INPUT_MOUSEDEV_PSAUX
		bool
		default y
endif

Same for CONFIG_VT and the other stuff that needs to be there to be
working. CONFIG_INPUT_ADVANCED is in no 2.4 kernel config and thus will
be 'n' for unsuspecting people doing 'make oldconfig'.

Then the Kconfig will define all the VT and INPUT and SERIO stuff to 'y'
without asking.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
