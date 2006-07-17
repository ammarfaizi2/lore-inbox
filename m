Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWGQPuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWGQPuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWGQPuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:50:16 -0400
Received: from [195.23.16.24] ([195.23.16.24]:2712 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750875AbWGQPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:50:15 -0400
Message-ID: <44BBB1AA.3050703@grupopie.com>
Date: Mon, 17 Jul 2006 16:50:02 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality
 permits it
References: <200607112257.22069.a1426z@gawab.com> <200607151429.32298.a1426z@gawab.com> <1152966159.3114.19.camel@laptopd505.fenrus.org> <200607151709.45870.a1426z@gawab.com>
In-Reply-To: <200607151709.45870.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
>[...] > void fn() {
> 
> 	long i = 9999999;
> 	double x,y;
> 
> 	elapsed(1);
> 	while (i--) fn2(&x,&y);
> 	printf("%4lu ",elapsed(0));
> }

You are not initializing x and y and with -Os at least my gcc really 
uses floating point load/store operations to handle that code.

Maybe the coprocessor has a hard time normalizing certain garbage on the 
stack, but without/with randomization the data comes from other 
addresses and you're just lucky with the contents.

Does this also happens if you add a "x=0, y=0;" line to that function?

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
