Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313176AbSDDOgF>; Thu, 4 Apr 2002 09:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDDOfp>; Thu, 4 Apr 2002 09:35:45 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:24592 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S313176AbSDDOfm>;
	Thu, 4 Apr 2002 09:35:42 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200204041412.PAA17697@gw.chygwyn.com>
Subject: Re: [PATCH 2.5.8-pre1] nbd compile fixes...
To: davej@suse.de (Dave Jones)
Date: Thu, 4 Apr 2002 15:12:27 +0100 (BST)
Cc: stelian.pop@fr.alcove.com (Stelian Pop),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020404162844.Z20040@suse.de> from "Dave Jones" at Apr 04, 2002 04:28:44 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> On Thu, Apr 04, 2002 at 02:50:25PM +0100, Steven Whitehouse wrote:
>  > > 2.4 simply does a s/queue_lock/tx_lock/ on drivers/block/nbd.c
>  > > I'll push that to Linus later today
>  > Not quite. They cover different things. The queue_lock originally covered the
>  > queue and the request sending function. There was an obscure deadlock which
>  > could occur in this case hence the split to a spin lock to cover the queue
>  > and a semaphore to cover only the request sending function (hence tx_lock
>  > rather than queue lock).
> 
> *nod* I wussed out and just took the easy bits when I forward ported
> those changes from 2.4 
> http://www.codemonkey.org.uk/linux-2.5_drivers_block_nbd.c.diff
> 
> I dropped the actual fix because it was incompatible with the bio
> changes iirc.
> 
That was my conclusion too. Since its now possible to mark requests
REQ_STARTED my current 2.5 patch does that (and leaves requests on the
request queue) rather than maintaining a separate internal queue like the 
2.4 version does, but its fairly similar other than that.

>  > I've got a 2.5 version of that patch on my patches page at the moment, but
>  > due to the block layer changes (if I've understood them correctly) the
>  > fix should be done in a slightly different way. The reason that I've not 
>  > submitted the patch for 2.5 is that it doesn't yet work and I've not had
>  > a chance to investigate properly yet (it hangs on writes sometimes). I'm
>  > sure its probably something silly that I've done but I just don't see it
>  > at the moment. Any hints or clues are welcome :-)
> 
> URL ?
> 
Sorry, I should have mentioned that earlier: 
http://www.chygwyn.com/~steve/kpatch/nbd-2.5.7-deadlock.diff

Steve.
