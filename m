Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWIKHbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWIKHbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIKHbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:31:52 -0400
Received: from gw.goop.org ([64.81.55.164]:37041 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750892AbWIKHbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:31:51 -0400
Message-ID: <450510E0.8080906@goop.org>
Date: Mon, 11 Sep 2006 00:31:44 -0700
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
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu>
In-Reply-To: <20060911051028.GA10084@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> another thing about i386-pda: why did you pick the %gs selector to store 
> the PDA in? %fs would be a better choice because %gs is used by glibc so 
> the saving/restoring of %fs would likely be near zero-cycles cost. 
> (instead of the current 9 cycles for saving/restoring %gs)
>   

Why would saving/restoring %fs be quicker?  The main reason I chose %gs 
was so that it didn't add anything to the context switch time (since %gs 
needed to be switched anyway), and it leaves open the possibility of 
using gcc's TLS support in the kernel (I have a working demonstration of 
this, but Rusty and I are still working out the module details).

    J
