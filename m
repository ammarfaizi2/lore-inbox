Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030780AbWKOR71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbWKOR71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030782AbWKOR71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:59:27 -0500
Received: from gw.goop.org ([64.81.55.164]:60565 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030781AbWKOR70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:59:26 -0500
Message-ID: <455B557C.7020602@goop.org>
Date: Wed, 15 Nov 2006 09:59:24 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu> <455B4E2F.7040408@goop.org> <20061115173252.GA24062@elte.hu>
In-Reply-To: <20061115173252.GA24062@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i said this before: using segmentation tricks these days is /insane/. 
> Segmentation is not for free, and it's not going to be cheap in the 
> future. In fact, chances are that it will be /more/ expensive in the 
> future, because sane OSs just make no use of them besides the trivial 
> "they dont even exist" uses.
>   

Many, many systems use %fs/%gs to implement some kind of thread-local
storage, and such usage is becoming more common; the PDA's use of it in
the kernel is no different.  I would agree that using all the obscure
corners of segmentation is just asking for trouble, but using %gs as an
address offset seems like something that's going to be efficient on x86
32/64 processors indefinitely.

> so /at a minimum/, as i suggested it before, the kernel's segment use 
> should not overlap that of glibc's. I.e. the kernel should use %fs, not 
> %gs.

Last time you raised this I did a pretty comprehensive set of tests
which showed there was flat out zero difference between using %fs and
%gs.  There doesn't seem to be anything to the theory that reloading a
null segment selector is in any way cheaper than loading a real
selector.  Did you find a problem in my methodology?

    J
