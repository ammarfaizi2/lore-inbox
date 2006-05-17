Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWEQXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWEQXuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWEQXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWEQXuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:50:20 -0400
Date: Wed, 17 May 2006 16:49:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Avuton Olrich <avuton@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFT] major libata update
In-Reply-To: <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605171643510.10823@g5.osdl.org>
References: <20060515170006.GA29555@havoc.gtf.org>
 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
 <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
 <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org> <87ves44qrs.fsf@duaron.myhome.or.jp>
 <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 May 2006, Linus Torvalds wrote:
> 
> I think Neil already reported that it fixed a lost interrupt problem for 
> him, but I'm worried that it might result in interrupt storms for others. 

Of course, we could just decide to try to switch from level to 
edge-triggered if the irq storm thing ever triggers. Right now we disable 
the irq entirely, which means that _if_ it was just due to a polarity 
error, we're screwed even if it should have been easy to fix by just 
turning it into edge-high.

The code to do that should be trivial: make __report_bad_irq() try to 
switch to edge mode if it's not edge already. Hmm?

		Linus
