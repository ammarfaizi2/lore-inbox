Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJaOhK>; Thu, 31 Oct 2002 09:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJaOhK>; Thu, 31 Oct 2002 09:37:10 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:55303 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262198AbSJaOhH>; Thu, 31 Oct 2002 09:37:07 -0500
Date: Thu, 31 Oct 2002 15:43:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
In-Reply-To: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0210311452531.13258-100000@serv>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 31 Oct 2002, Matthew Wilcox wrote:

> I'm just looking over the new arch/parisc/Kconfig trying to make sure that
> it got translated correctly, but I can't find any documentation.

http://www.xs4all.nl/~zippel/lc/

>  Some of
> the Kconfig files refer to "the Configure script" -- what Configure
> script?  Some of them refer to Documentation/kbuild/config-language.txt
> -- which describes the old one.  Most don't tell you where to find
> the description.

The comments are still the same as before and need to be corrected 
manually.

> What's the difference between `help' and `---help---'?

None. Actually you can insert lots of '---' as separators almost anywhere 
you want. The converter used ---help--- for large help texts to separate 
them a bit better from the other options.

> What's the new idiom for define_bool?

Here a small howto for CML1 users.

cml1:
bool/tristate/int/... /prompt/ /symbol/ /word/

kconfig:
config /symbol/
	bool /prompt/
	default /word/

(bool/tristate have now defaults as well.)

cml1:
define_bool /symbol/ /word/

kconfig:
config /symbol/
	bool
	default /word/

cml1:
dep_bool /prompt/ /symbol/ /dep/ ...

kconfig:
config /symbol/
	bool /prompt/
	depends on /dep/=y && ...

cml1:
dep_mbool /prompt/ /symbol/ /dep/ ...
dep_int...

kconfig:
config /symbol/
	bool /prompt/
	depends on /dep/ && ...

cml1:
choice /prompt/ /word/ /word/

kconfig:
choice
	prompt /prompt/
	default /symbol/

config
	....

endchoice

Especially the choice statement became much more powerful. Multiple 
defaults are possible, every choice value can have further dependencies 
and it can be tristate.

Dependencies are very close to the old behaviour with only some small 
differences, e.g. '-a'/'-o' are simply '&&'/'||', "CONFIG_FOO"="y" becomes 
FOO=y and only FOO has the same meaning as in dep_tristate.  Important 
here is that the undefined state is gone and kconfig will soon start 
emit warnings for undefined symbols used in expressions.

bye, Roman

