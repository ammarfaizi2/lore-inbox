Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWD1AEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWD1AEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWD1AEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:04:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751810AbWD1AEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:04:33 -0400
Date: Thu, 27 Apr 2006 17:01:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <20060427231200.GW3570@stusta.de>
Message-ID: <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org> <20060427213754.GU3570@stusta.de>
 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org> <20060427231200.GW3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Adrian Bunk wrote:
> 
> I do still not get your point.
> 
> The ABI headers will be used by C libraries.
> 
> And by some programs doing low-level Linux specific things - but these 
> are exceptions.
> 
> Normal userspace programs will simply not care about the contents of the 
> kernel ABI headers - the libc will present them pretty headers adhering 
> to all past, current and future standards.

As long as that is clear - that the kernel ABI headers are _never_ seen by 
normal programs, even indirectly #include'd from the standard include 
headers.

That means that any library implementation still needs to basically 
_duplicate_ all the kernel ABI structures etc. 

Last I heard, a lot of people wanted to avoid that duplication, and 
actually wanted the kabi headers exactly because they wanted just _one_ 
place for these things.

And I suspect a lot of people still think the kabi headers would be 
exactly that: things that get #include'd indirectly from the normal header 
files.

My point would be that we can't do that. Ever. 

As long as people realize that any kabi headers would only ever be used by 
system libraries _internally_ to build themselves (or strange system 
tools, of course), then I'm happy. I just get the feeling that people 
don't always realize that, and they really want to see it as some kind of 
"/usr/include/bits" kind of thing.

			Linus
