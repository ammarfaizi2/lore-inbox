Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSAMNeb>; Sun, 13 Jan 2002 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288010AbSAMNeV>; Sun, 13 Jan 2002 08:34:21 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:20237 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288012AbSAMNeN>; Sun, 13 Jan 2002 08:34:13 -0500
Message-ID: <3C418CCC.3854D76E@linux-m68k.org>
Date: Sun, 13 Jan 2002 14:34:04 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZQA-0003fl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> disable_irq only blocks _one_ interrupt line, spin_lock_irqsave locks the
> interrupt off on a uniprocessor, and  50% of the time off on a
> dual processor.
> 
> If I use a spin lock you can't run a modem and an NE2000 card together on
> Linux 2.4. Thats why I had to do that work on the code. Its one of myriads
> of basic obvious cases that the pre-empt patch gets wrong

I wouldn't say it gets it wrong, the driver also has to take a non irq
spinlock anyway, so the window is quite small and even then the packet
is only delayed.
But now I really have to look at that driver and try a more optimistic
irq disabling approach, otherwise it will happily disable the most
important shared interrupt on my Amiga for ages.

bye, Roman
