Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933472AbWKNSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933472AbWKNSra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933473AbWKNSra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:47:30 -0500
Received: from smtp-out.google.com ([216.239.33.17]:31774 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933472AbWKNSr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:47:29 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=xj4uLNEK10sas3nGOHe4Y1rl2VVIPVZVL20nJXE7sFm40ReZRpKBn3DkiD1Xo2yVX
	Y7jTLUL3TIFRwrViF9bNg==
Message-ID: <8f95bb250611141047k2f879893g7ea42768247e576@mail.gmail.com>
Date: Tue, 14 Nov 2006 10:47:20 -0800
From: "Aaron Durbin" <adurbin@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH for 2.6.19] [6/9] x86_64: Update MMCONFIG resource insertion to check against e820 map.
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox" <matthew@wil.cx>
In-Reply-To: <p73irhhdgau.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061114508.445749000@suse.de>
	 <20061114160856.D02D113C69@wotan.suse.de>
	 <p73irhhdgau.fsf@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Nov 2006 19:38:49 +0100, Andi Kleen <ak@suse.de> wrote:
> Andi Kleen <ak@suse.de> writes:
>
> > From: "Aaron Durbin" <adurbin@google.com>
> > Check to see if MMCONFIG region is marked as reserved in the e820 map before
> > inserting the MMCONFIG region into the resource map. If the region is not
> > entirely marked as reserved in the e820 map attempt to find a region that is.
> > Only insert the MMCONFIG region into the resource map if there was a region
> > found marked as reserved in the e820 map.  This should fix a known regression
> > in 2.6.19 by not reserving all of the I/O space on misconfigured systems.
>
>
> [...]
>
> Before anyone complains. This one patch is actually not in, because
> Linus' decision was it instead to revert the mcfg reservation
> code for .19. He already did it for i386 and i followed on x86-64.
> But this patch went into the posted patchkit by mistake.
> Will be probably revisited for .20.

I would like to know what others think regarding this area. I think it
would be a good
idea to converge the mmconfig.c implementations for both x86-64 and i386. Is
this not feasable for some reasons I am unaware of?  It should lead to more
code reuse and allow for a more unified stance in how both architectures handle
the PCI memory-mapped config space.

What is everyone's thoughts and ideas on such a suggestion?

I think the resource allocation can be addressed in the future after we have
tackled a unified approach.


-Aaron
