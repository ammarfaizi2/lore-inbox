Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbTIJTfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265523AbTIJTfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:35:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23313 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265578AbTIJTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:34:30 -0400
Date: Wed, 10 Sep 2003 20:34:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [BK PATCHES] kbuild/kconfig
Message-ID: <20030910203425.J30046@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Sep 10, 2003 at 09:14:11PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:14:11PM +0200, Sam Ravnborg wrote:
> Hi Linus.
> 
> Here are a few kbuild/kconfig related patches:
> 
> 1) kbuild: Save relevant parts of modules.txt
> 2) kconfig: Allow architectures to select board specific configs
> 3) kbuild: Build minimum in scripts/ when changing configuration
> 4) kbuild: Remove cscope.out during make mrproper 
> 5) kbuild/ppc*: Remove obsolete _config support
> 6) bk ignore scripts/bin2c
> 
> The only patch worth mention is the one allowing architectures
> to select board specific configurations. Adding a few trivial
> changes to conf.c enabled generic support for that.
> ppc* already followed the required setup.
> I did not update arm for this new scheme. Russell?

I'd much rather we keep our current scheme because it makes 100% sense
for ARM since there is no "generic" configuration which covers a subset
of configurations.

To illustrate this fact, here's some statistics on the symbolic usage
between all the default configurations on ARM:

- 414 configuration symbols are only defined on one default configuration
  file.
- 281 configuration symbols occur in between 2 and 9 inclusive files.
- 122 configuration symbols occur between 10 and 46 files.
- 3 configuration symbols occur in all 47 default configuration files.

I'm far from happy doing any conversions to make this work.  The current
system was fine and fit our needs exactly.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
