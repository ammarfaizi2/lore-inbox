Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267922AbUHPUHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267922AbUHPUHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHPUHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:07:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34055 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267922AbUHPUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:07:36 -0400
Date: Mon, 16 Aug 2004 21:07:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040816210729.A25893@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <Pine.LNX.4.61.0408151932370.12687@scrub.home> <20040815174028.GM1387@fs.tum.de> <Pine.LNX.4.61.0408160043270.12687@scrub.home> <20040816195733.GZ1387@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040816195733.GZ1387@fs.tum.de>; from bunk@fs.tum.de on Mon, Aug 16, 2004 at 09:57:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 09:57:33PM +0200, Adrian Bunk wrote:
> On Mon, Aug 16, 2004 at 12:47:05AM +0200, Roman Zippel wrote:
> > The use of select is already a crotch here, so there's no real correct 
> > handling. There are a few possibilities:
> > - if you select FW_LOADER, you have to select HOTPLUG too
> > - if you select FW_LOADER, you have to depend on HOTPLUG
> > - FW_LOADER itself can select HOTPLUG
> 
> Solution 2 is what my patch tried.
> 
> Thinking about them, I'd prefer solution 3. But with solution 1 or 3, 
> I'm sure people like Russell King will scream since this will make it 
> non-trivial to de-select HOTPLUG.

Let me make my position over the use of "select" clear: I do not
oppose its appropriate use, where that is defined as selecting
another configuration option for which the user has no visibility.

In the above case, it _may_ make sense (I haven't looked deeply
into it yet) to:

- make _all_ drivers which need FW_LOADER select it
- make _all_ drivers which currently depend on HOTPLUG select it
- make FW_LOADER select HOTPLUG
- remove user questions for FW_LOADER and HOTPLUG

That means that FW_LOADER and HOTPLUG are automatically selected
whenever the configuration requires them and are automatically
deselected when it doesn't need them, and you don't have to worry
about whether you can disable them now or after finding the
thousand and one configuration symbols which need to be turned off
first.

However, keeping the option user-visible _and_ using select is
problematical to say the least.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
