Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVABAQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVABAQR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 19:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVABAQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 19:16:17 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:41906 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261190AbVABAQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:16:13 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Problems with 2.6.10
To: Fryderyk Mazurek <dedyk@go2.pl>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       gustavo@compunauta.com
Reply-To: 7eggert@gmx.de
Date: Sun, 02 Jan 2005 01:20:29 +0100
References: <fa.b02ekp9.12i8ti1@ifi.uio.no> <fa.ekat19o.emk580@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CktTx-0003bC-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fryderyk Mazurek wrote:

> At last I fixed my problem! I changed source to not enable "Host
> Protected Area". This means that on 2.6.10 I have 33,8GB disk, not
> 40GB, how on "true" 2.6.10. And now my BIOS detect my disk. But
> question is, what does "true" kernel do, and why influence to BIOS?
> Maybe this is kernel BUG?

I can see the reason why this happens: When you boot, your HDD will be in
a compatibility mode for broken BIOSes, but it will not enter compatibility
mode on reboot. (Is it supposed to work this way, or should the BIOS
completely reset the device?)

There may be two solutions for this problem:
 - Reset the drive (hdparm -w) before rebooting (just a quick workaround)
 - Remember the initial state during runtime and restore it before reboot

The first option may not work at all, I'm just guessing here.
The second option will require a feature enheancement to the IDE subsystem.

To quickly find out if option 1 is enough, you could boot a non-patched
kernel with init=/bin/sh. In the shell, enter:
# hdparm -w
# shutdown -n -r now

If it works for your problen, hdparm will probably disable propper access
to the HDD until reboot. (This could mean some other cases might be broken,
too.)

