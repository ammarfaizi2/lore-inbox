Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSK0Syd>; Wed, 27 Nov 2002 13:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSK0Syd>; Wed, 27 Nov 2002 13:54:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25360 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264659AbSK0Syc>;
	Wed, 27 Nov 2002 13:54:32 -0500
Date: Wed, 27 Nov 2002 20:01:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021127190147.GA1088@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211271234560.2109-100000@serv> <12497.1038399540@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12497.1038399540@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 11:19:00PM +1100, Keith Owens wrote:

> Bullshit.  It was fully documented in kbuild 2.5.  Just because Kai
> dropped the docs when he stole bits from kbuild 2.5 does not make
> .force_default into an undocumented feature.

I never seen this as a standalone patch from you - something i missed?

I do not remember exactly but I may have been the person
extracting this from kbuild-2.5 and feeding this patch to Kai,
in which case you should blaim me, not Kai.
If you were not properly attributed at that point in time, sorry for that.


If kconfig are extended with functionality similar to .force_default
then the file containing the defaults shall NOT be hidden.
There is no good reason to hide for the user that some options
are forced to a specific value.

IIRC the old implementation only impacted "make oldconfig", so
doing something like:
echo CONFIG_HOTPLUG=y > .force_default
make oldconfig
make menuconfig, enable HOTPLUG
Manually tweak .config and run make oldconfig
then I would behind my back loose the hotplug setting, without
any warning.

If implemented defaults should be effective in all frontends, not only
make oldconfig. Forced defaults should be unchangable in the frontends.
It is not intuitive for the user that at one point something is forced
enabled, and then later the user are anyway allowed to change it
without further notice.

	Sam
