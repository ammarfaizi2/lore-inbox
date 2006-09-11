Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWIKHln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWIKHln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIKHln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:41:43 -0400
Received: from gw.goop.org ([64.81.55.164]:40603 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751123AbWIKHln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:41:43 -0400
Message-ID: <45051330.5050205@goop.org>
Date: Mon, 11 Sep 2006 00:41:36 -0700
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
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu>
In-Reply-To: <20060911072959.GA2322@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> because userspace does not use it normally, while with %gs we'd switch 
> between glibc's descriptor [which must be shadowed by the CPU] and the 
> kernel's descriptor [which must be shadowed by the CPU too] - hence 
> causing a constant reloading of the shadow register.
>   

Well, that means the only operation which would be different would be 
the pop %fs at the end, since only it would end up loading a null 
selector.  All the other operations would presumably take just as long.

    J
