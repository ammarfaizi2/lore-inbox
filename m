Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266593AbUBDV22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUBDV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:26:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266593AbUBDVYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:24:39 -0500
Message-ID: <40216306.2010602@pobox.com>
Date: Wed, 04 Feb 2004 16:24:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] unsafe reset in ac97_codec.c
References: <1075822947.5204.506.camel@cearnarfon>
In-Reply-To: <1075822947.5204.506.camel@cearnarfon>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Girdwood wrote:
> /* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00
> (reset) should 
> * be read zero.
> *
> * FIXME: is the following comment outdated?  -jgarzik 
> * Probing of AC97 in this way is not reliable, it is not even SAFE !!
> */
> codec->codec_write(codec, AC97_RESET, 0L);
> 
> 
> IMO, this is unsafe because it can also reset the codec into it's
> default power state which can be "power down". This is not normally a
> problem for PC's, but some battery powered devices have the default
> codec state as "power down" to conserve power.
> 
> Was this introduced as a workaround for some buggy device ?
> If no one objects I'll submit a patch.


In general it's important for Linux to be able to reset a device 
reliable.  Where in Other Operating Systems one must reboot the 
computer, Linux users can just re-load the driver quite often.

So I think there are two comments here:

* I can certainly see -probing- being unreliable (but not necessarily reset)

* If the default state for some devices is power-down, the driver should 
be aware of that -anyway-, and we should power up on startup or on-demand.

	Jeff



