Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313172AbSDDOOJ>; Thu, 4 Apr 2002 09:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSDDOOA>; Thu, 4 Apr 2002 09:14:00 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:22032 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S313172AbSDDONr>;
	Thu, 4 Apr 2002 09:13:47 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200204041350.OAA17473@gw.chygwyn.com>
Subject: Re: [PATCH 2.5.8-pre1] nbd compile fixes...
To: davej@suse.de (Dave Jones)
Date: Thu, 4 Apr 2002 14:50:25 +0100 (BST)
Cc: stelian.pop@fr.alcove.com (Stelian Pop),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020404160206.Y20040@suse.de> from "Dave Jones" at Apr 04, 2002 04:02:06 PM
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
> On Thu, Apr 04, 2002 at 03:58:26PM +0200, Stelian Pop wrote:
>  > In fact, since nbd.c still reference 'queue_lock' I suspect that
>  > the actual modifications to nbd.c were lost somewhere in etherspace
>  > between Dave and Linus.
> 
> Correct, there's a missing part, that came from 2.4
> 
Which I wrote and submitted with Pavel's approval a little while ago.

>  > Either provide the right fix for nbd.c or apply the attached patch,
>  > which reverts the patch to nbd.h.
> 
> 2.4 simply does a s/queue_lock/tx_lock/ on drivers/block/nbd.c
> I'll push that to Linus later today
> 
Not quite. They cover different things. The queue_lock originally covered the
queue and the request sending function. There was an obscure deadlock which
could occur in this case hence the split to a spin lock to cover the queue
and a semaphore to cover only the request sending function (hence tx_lock
rather than queue lock).

I've got a 2.5 version of that patch on my patches page at the moment, but
due to the block layer changes (if I've understood them correctly) the
fix should be done in a slightly different way. The reason that I've not 
submitted the patch for 2.5 is that it doesn't yet work and I've not had
a chance to investigate properly yet (it hangs on writes sometimes). I'm
sure its probably something silly that I've done but I just don't see it
at the moment. Any hints or clues are welcome :-)

Steve.
