Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVCSTKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVCSTKR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVCSTJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:09:42 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:36797
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261739AbVCSTJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:09:33 -0500
Message-ID: <423C78E8.3040200@ev-en.org>
Date: Sat, 19 Mar 2005 19:09:28 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Relayfs question
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> according to the relayfs description on opersys.com,
> 
> |As the Linux kernel matures, there is an ever increasing number of facilities
> |and tools that need to relay large amounts of data from kernel space to user
> |space. Up to this point, each of these has had its own mechanism for relaying
> |data. To supersede the individual mechanisms, we introduce the "high-speed
> |data relay filesystem" (relayfs). As such, things like LTT, printk, EVLog,
> |etc.
> 
> This sounds to me like it would obsolete most character-based devices, e.g.
> random and urandom.
> 
> What do the relayfs developers say to this?

I'm not a relayfs developer, just a happy user...

The latest relayfs versions are slimmed down of the original and are 
unlikely to be useful as a character-based device, but are much better 
as a data-transport facility.

There is no longer any interface for character based reading so it can't 
be used for the device replace purposes.

The current method is to just manage buffers and enable applications to 
mmap the buffers to read them with some signalling on when a buffer is 
to be read and when the kernel can overwrite it.

A character device is unlikely to need such interface since you do want 
16 bytes of random data and not several pages of mapped random numbers. 
If you really need a lot of random numbers you need something in 
user-space anyway since you'll deplete the kernel entropy pool pretty 
fast anyway.

If you have a device that needs to transfer lots of data doesn't mind it 
being batched and doesn't really need the character device interface 
then relayfs could be useful.

Baruch
