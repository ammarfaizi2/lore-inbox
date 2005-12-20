Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVLTWNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVLTWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVLTWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:13:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932183AbVLTWNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:13:06 -0500
Date: Tue, 20 Dec 2005 14:09:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: James Courtier-Dutton <James@superbug.co.uk>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
In-Reply-To: <20051220211359.GA5359@stusta.de>
Message-ID: <Pine.LNX.4.64.0512201405550.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
 <20051220211359.GA5359@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Adrian Bunk wrote:
> 
> Thinking about this, what about the patch below?
> 
> I don't know whether this might break anything else, but it fixes my 
> problem.

I'd be much more worried about this than about your patch that just 
modifies one driver.

Basically, this would make _all_ sound drivers initialize before the other 
drivers, and that just makes me suspect you'll have a lot of new bugs that 
get uncovered by the fact that the configuration changed radically.

So I'd much rather either fix one single sound driver (that can't mess up 
anything else), or fix the sound _core_ to just initialize in the right 
place. Moving _all_ sound drivers earlier sounds risky as hell, for no 
good reason.

		Linus
