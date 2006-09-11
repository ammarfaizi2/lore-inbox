Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWIKH7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWIKH7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWIKH7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:59:46 -0400
Received: from gw.goop.org ([64.81.55.164]:21202 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751209AbWIKH7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:59:45 -0400
Message-ID: <4505176B.6030803@goop.org>
Date: Mon, 11 Sep 2006 00:59:39 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
References: <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org> <20060911073649.GA3188@elte.hu>
In-Reply-To: <20060911073649.GA3188@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> yes - but loading a null selector is a special-case: you dont have to 
> invalidate/reload the shadow, you just have to turn access off. This 
> might or might not make a difference on modern CPUs (it makes a 
> difference with older CPUs) - but it's worth a try nevertheless. You 
> measured a 9 cycles degradation with the %gs method, we could recover 
> some of that.
>   

It's a worthwhile experiment.  The gain would be the NULL selector load, 
but the loss would be an additional segment reload on context switch and 
TLS ABI incompatibility (which is more difficult to quantify).

First step is to make sure the PDA is set up before hitting C code...

    J
