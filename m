Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271876AbRHUV4i>; Tue, 21 Aug 2001 17:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271872AbRHUV4U>; Tue, 21 Aug 2001 17:56:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271871AbRHUVz6>; Tue, 21 Aug 2001 17:55:58 -0400
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
To: ranma@gmx.at (Tobias Diedrich)
Date: Tue, 21 Aug 2001 22:59:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010821223724.A588@router.ranmachan.dyndns.org> from "Tobias Diedrich" at Aug 21, 2001 10:37:24 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZJYE-0000N8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> usb stopped working. I'm using an usb mouse (MS Intellimouse Explorer).
> The mouse is not getting initialized at boot. Reconnecting does not
> help either.  
> Board is an ASUS P2B (Intel BX chipset)
> Processor is a Celeron 433A (In slotket adapter)

Looks like the change int he usb_start_wait_urb code is a problem. 

I suspect either you need to add wmb() and rmb() to stop misoptimisations
on done (along with making it (!timeout && !awd.done)

Or

there is a signal related problem - if so  making it set the state
to TASK_UNINTERRUPTIBLE might cure it

