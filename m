Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbVIZRMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbVIZRMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbVIZRMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:12:35 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:1158 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1751688AbVIZRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:12:34 -0400
Date: Mon, 26 Sep 2005 19:12:20 +0200
From: Luca <kronos@kronoz.cjb.net>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipw2200 only works as a module?
Message-ID: <20050926171220.GA9341@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4338122C.9000901@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keenan Pepper <keenanpepper@gmail.com> ha scritto:
> With CONFIG_IPW2200=y I get:
> 
> ipw2200: ipw-2.2-boot.fw load failed: Reason -2
> ipw2200: Unable to load firmware: 0xFFFFFFFE
> 
> but with CONFIG_IPW2200=m it works fine. If it doesn't work when built into the 
> kernel, why even give people the option?
> 
> BTW, a better error message than "Reason -2" would be nice. =)

-2 is -ENOENT (no such file or directory). ipw2000 requests its firmware
using a hotplug event, but when the driver is compiled into the kernel
it gets loaded _before_ the root fs is mounted and of course the hotplug
system and the firmware are not available.

I suggest to stick with modular driver, otherwise you must create an
initrd with hotplug + firmware.

More on firmware loading here: http://lwn.net/Articles/32997/

Luca
-- 
Home: http://kronoz.cjb.net
"L'amore consiste nell'essere cretini insieme." -- P. Valery
