Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTIJTsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbTIJTsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:48:13 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:11784 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265691AbTIJTsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:48:09 -0400
Date: Wed, 10 Sep 2003 21:48:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [BK PATCHES] kbuild/kconfig
Message-ID: <20030910194806.GB5723@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org> <20030910203425.J30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910203425.J30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 08:34:25PM +0100, Russell King wrote:
> 
> I'd much rather we keep our current scheme because it makes 100% sense
> for ARM since there is no "generic" configuration which covers a subset
> of configurations.

What has changed is only the steps needed.
Old way:
make anakin_config	=> copied def-configs/ankin to .config
make oldconfig		=> required to make a consistent config

New way
make anakin_defconfig	=> Creates a consistent config in one step

The patch just introduced a generic method to fetch a given
configuration and to make that configuration consistent.
Similar to running "make oldconfig".

See, no new funtionality, just a different way to achieve the same.
OK?

> To illustrate this fact, here's some statistics on the symbolic usage
> between all the default configurations on ARM:
> 
> - 414 configuration symbols are only defined on one default configuration
>   file.
> - 281 configuration symbols occur in between 2 and 9 inclusive files.
> - 122 configuration symbols occur between 10 and 46 files.
> - 3 configuration symbols occur in all 47 default configuration files.
> 
> I'm far from happy doing any conversions to make this work.  The current
> system was fine and fit our needs exactly.

As outlined in a private mail, the only thing needed for arm to do
is to rename 48 files and one directory. And to delete ~10 lines form a
makefile.
That is an acceptable price to pay for getting generic support for something
that will see wider use by other architectures (my prediction).

	Sam
