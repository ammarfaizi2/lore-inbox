Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVGFTw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVGFTw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGFTu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:50:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35220 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262347AbVGFPHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:07:16 -0400
Message-ID: <42CBF3A1.1020508@pobox.com>
Date: Wed, 06 Jul 2005 11:07:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aric Cyr <acyr@alumni.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: sata_sil 3112 activity LED patch
References: <20050706025136.GA15493@alumni.uwaterloo.ca>
In-Reply-To: <20050706025136.GA15493@alumni.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aric Cyr wrote:
> After finally getting fed up with not having my activity light working
> for my SATA drives, I came up with a small patch (more like hack) to
> make it work.  It works quite well, but I'm afraid that there are many
> restriction that this patch does not check for that it probably
> should... so consider this a work-in-progress.  My information is
> based on a document from Silicon Image that appears to no longer be
> available on their website (Sil-AN-0082-E; 8112-0082.pdf).  I still
> have a copy if anyone is interested.
> 
> There are two restrictions that are not checked:
> 
> 1) Is the chip a 3112 or 3114?  I assume that this would only work on
>    a 3112, but whether it is "a bad thing" on a 3114 I do not know.
> 
> 2) BAR5 + 0x54 is apparently used for the flash memory address and
>    data lines.  However for most motherboards (i.e. not add-on cards)
>    with the chip, like my EPOX 8RDA3+, there is no flash memory, so
>    these lines are hijacked as LED GPIO.  I assume that this is a
>    common practice for motherboard makers using the sil3112 since
>    Silicon Image went out of their way to produce the above mentioned
>    document.  Anyways, the problem is that this patch does not check
>    if flash memory is installed or not before twiddling with the GPIO
>    lines.  This could be extremely bad for people running the 3112
>    from add-on cards (or any implementation with flash memory
>    installed).
> 
> Setting the low 8bits at BAR5+54h seems to enable the LED circuit.  It
> seems that this circuit is patched through into the motherboard as it
> lights the regular hard drive light on the front of my case.  Setting
> bits [8:15] at BAR5+54h clears the bits, disabling the LED.  I hooked
> this logic into the ata_bmdma_start and ata_bmdma_stop which were made
> into simple wrapper functions in sata_sil.c that just set the GPIO
> bits and calls ata_bmdma_*.

I don't think its ugly, necessarily.  I do worry about the flash memory 
stuff, though, which is why I don't want to merge this upstream for now.

For your patch specifically, it would be nice to follow the coding style 
that is found in the rest of the driver (single-tab indents, etc., read 
CodingStyle in kernel source tree).

	Jeff



