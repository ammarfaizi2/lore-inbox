Return-Path: <linux-kernel-owner+w=401wt.eu-S1750934AbWLNRE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWLNRE0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWLNREZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:04:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39970 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbWLNREZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:04:25 -0500
Date: Thu, 14 Dec 2006 09:03:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <458171C1.3070400@garzik.org>
Message-ID: <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
 <458171C1.3070400@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Jeff Garzik wrote:
> 
> For the record, I also disagree with the sneaky backdoor way people want to
> add EXPORT_SYMBOL_GPL() to key subsystems that drivers will need.

I actually think the EXPORT_SYMBOL_GPL() thing is a good thing, if done 
properly (and I think we use it fairly well).

I think we _can_ do things where we give clear hints to people that "we 
think this is such an internal Linux thing that you simply cannot use this 
without being considered a derived work".

It's really just a strong hint about what we consider to be internal. The 
fact is, "intent" actually does matter, and as such our _intent_ in saying 
"these are very deep and internal interfaces" is actually meaningful - 
even in a court of law.

So I personally don't see EXPORT_SYMBOL_GPL() to be a "technical measure", 
I see it as being "documentation".

That said, I think that some people seem to be a bit over-eager to use it. 
And I actually think that weakens the rest of them too (imagine a lawyer 
saying in front of a judge:

  "Look, they marked 'strcpy()' as a symbol that requires us to be GPL'd, 
   but look, it's a standard function available everywhere else too, and 
   you can implement it as one line of code, so a module that uses it 
   clearly is NOT a derived work, so EXPORT_SYMBOL_GPL is obviously not 
   something that means anything"

So this is why I've actually argued in the past for some 
EXPORT_SYMBOL_GPL's to be demoted to "normal" EXPORT_SYMBOL's. Exactly 
because over-using them actually _weakens_ them, and makes them pointless 
both from a documentation _and_ from a legal standpoint.

Btw, I've actually had a lawyer tell me that EXPORT_SYMBOL_GPL makes legal 
sense and has actually made people happier, for what its worth. Of course, 
you can get <n*2> different opinions from <n> lawyers, so that may not be 
all that meaningful ;)

				Linus
