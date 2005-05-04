Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVEDVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVEDVpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEDVpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:45:41 -0400
Received: from [81.2.110.250] ([81.2.110.250]:50830 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261688AbVEDVpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:45:13 -0400
Subject: Re: tricky challenge for getting round level-driven interrupt
	problem: help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
In-Reply-To: <20050504205831.GF8537@lkcl.net>
References: <20050503215634.GH8079@lkcl.net>
	 <1115171395.14869.147.camel@localhost.localdomain>
	 <20050504205831.GF8537@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115243014.19844.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 04 May 2005 22:43:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-05-04 at 21:58, Luke Kenneth Casson Leighton wrote:
>  i believe i get it: you raise a level-triggered interrupt which _stays_
>  raised until such time as your fifo is empty.

Bingo. It only goes away when the chip really has nothing left to say.

>  all - that sometimes (frequently, in fact - about 1 in every
>  50 times) it hasn't got round to clearing the level-driven
>  interrupt by the time we come out of the ARM ISR (!)

So you'll poll again and find there is no pending work to do.

>  hence the redesign to do alternate read-write-read-write, and making
>  reads exclusive of writes, etc.

and maybe even turn the IRQ off and use a timer if its slow and not
sensitive to latency.. ?

>  ... so - in your opinion, alan, is the old approach we had
>  actually _on_ the right lines?

level triggered IRQ does sort of expect the other end responds promptly
to be efficient as opposed to merely reliable.

>  also, are you going to ukuug in august, it being _in_
>  aberystwyth and all :)

Its not in Aberystwyth, but I might be. Its in Swansea 8)


