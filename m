Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263538AbUJ2WZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbUJ2WZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbUJ2WYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:24:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263655AbUJ2WIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:08:11 -0400
Message-ID: <4182BF36.5040709@pobox.com>
Date: Fri, 29 Oct 2004 18:07:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andreas Steinmetz <ast@domdv.de>, linux-os@analogic.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>  <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com>  <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de> <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com> <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de> <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org> <41829C91.5030709@domdv.de> <Pine.LNX.4.58.0410291249440.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410291249440.28839@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 	popl %eax
> 	popl %ecx
> 
> should one cycle on a Pentium. I pretty much _guarantee_ that
> 
> 	lea 4(%esp),%esp
> 	popl %ecx
> 
> takes longer, since they have a data dependency on %esp that is hard to 
> break (the P4 trace-cache _may_ be able to break it, but the only CPU that 
> I think is likely to break it is actually the Transmeta CPU's, which did 
> that kind of thing by default and _will_ parallelise the two, and even 
> combine the stack offsetting into one single micro-op).


One of my favorite "optimizing for Pentium" docs is

	http://www.agner.org/assem/pentopt.pdf
		from
	http://www.agner.org/assem/

which is current through newer P4's AFAICS.

It notes on the P4 specifically that LEA is split into additions and 
shifts.  Not sure what it does on the P3, but I bet it generates more 
uops in addition to the data dependency.

	Jeff


