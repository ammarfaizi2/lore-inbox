Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTLAAJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTLAAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:09:50 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:50393 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261784AbTLAAJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:09:49 -0500
Subject: Re: FYI: My current suspend bigdiff
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3FCA280A.40805@pobox.com>
References: <20031128171323.GG303@elf.ucw.cz> <3FC7860C.2060505@gmx.de>
	 <20031128173312.GH303@elf.ucw.cz> <3FC789F5.2000208@gmx.de>
	 <20031128175503.GB18072@elf.ucw.cz> <3FC7908A.9030007@gmx.de>
	 <20031128235623.GB18147@elf.ucw.cz> <3FC8C0DB.9050107@gmx.de>
	 <20031129172537.GB459@elf.ucw.cz> <3FC9C560.2070902@gmx.de>
	 <20031130171833.GB516@elf.ucw.cz> <3FCA2742.8070107@gmx.de>
	 <3FCA280A.40805@pobox.com>
Content-Type: text/plain
Message-Id: <1070237342.683.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Dec 2003 11:09:02 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As you suspect, you want only one of the fixes.
> 
> I would probably prefer Pavel's patch over mine, as he knows the suspend 
> subsystem better than me :)

Actually, you want more than that...

You want something similar to what I did for IDE, that is pipe the
suspend/resume requests down the request queue & block the queue,
though with additional crap to deal with the libata probe thread
and the scsi error mgmnt.

I didn't yet have time for it, but basically, what is needed is
to make a scsi version of the suspend/resume code that is in the
IDE code, and then hook that on sd, sg, etc...

Then, libata would have to get in the loop as HW driver, and also
by properly translating the flush cache / standby requests

Ben.


