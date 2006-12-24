Return-Path: <linux-kernel-owner+w=401wt.eu-S1751976AbWLXOmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWLXOmt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWLXOms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:42:48 -0500
Received: from ms-smtp-06.tampabay.rr.com ([65.32.5.136]:41585 "EHLO
	ms-smtp-06.tampabay.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751976AbWLXOmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:42:47 -0500
Message-ID: <458E91D0.5090807@cfl.rr.com>
Date: Sun, 24 Dec 2006 09:42:24 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
CC: James Courtier-Dutton <James@superbug.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <45811AA6.1070508@superbug.co.uk> <458E6B46.2060201@cfl.rr.com> <20061224082207.dcc0b955.seanlkml@sympatico.ca>
In-Reply-To: <20061224082207.dcc0b955.seanlkml@sympatico.ca>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:
> On Sun, 24 Dec 2006 06:57:58 -0500
> Mark Hounschell <dmarkh@cfl.rr.com> wrote:
> 
> 
>> Hum. We open sourced our drivers 2 years ago. Now one is 'changing' them
>> for us. The only way that happens is if they can get in the official
>> tree. I know just from monitoring this list that our drivers would never
>> be acceptable for inclusion in any "functional form". We open sourced
>> them purely out of respect for the way we know the community feels about
>> it.
> 
> That shows some class, thanks.
> 
>> It would cost more for us to make them acceptable for inclusion than it
>> does for us to just maintain them ourselves. I suspect that is true for
>> most vendor created drivers open source or not.
>>
>> So kernel developers making the required changes as the kernel changes
>> is NO real incentive for any vendor to open source their drivers. Sorry.
>>
>> If it were knowingly less difficult to actually get your drivers
>> included, that would be an incentive and then you original point would
>> hold as an additional incentive.
> 
> Out of curiosity what specific technical issues in your driver code make
> you think that it would be too expensive to whip them into shape for
> inclusion?
> 
> Cheers,
> Sean
> 

Well just off the top of my head, one of our drivers directly mucks with
all the irq affinities (irq_desc) via a provided user land library call.
This single call forces all 'other' irqs to be serviced by all the
'other' processors. I know this would never fly in kernel. User land
/proc manipulation is not an option for us  here.

We have another that absolutely requires the Bigphysarea patch. We
refuse to use "MEM=xxxx" and use a fixed address. Every installation
would require a special configuration and our 'end users' would have to
have some understanding of all that. We are also maintaining that patch
internally also. So this product (for full functionality with our not so
open source application) requires a special kernel to begin with. Other
than that this one might have a chance of inclusion. It only requires
the bigphysarea when used with this application. It will actually build
and work (basically) with or without it.

Another is actually somewhat tied to the one mentioned above in that
this one has to facilitate the ability of its card being able to to PIO
reads and writes to 'special locations' in userspace and to the SRAM
memory of the above card. Even when on different pci busses. I've looked
at some of the V4L drivers that also do this sort of thing and I'm
confused by how they are doing it so I'm almost certain that what we are
doing would be considered 'wrong'.

Then there is probably the biggest one of all. The coding style issue.
Don't get me wrong I understand and agree with what I've read about it.
Our drivers were written by hardware people. Or I should say they were
written by OUR hardware people. I can offend them because I am among
them. No offense intended to any of you invaluable hardware guys.

I see 6 months of full time work before I could even sanely ask what I
needed to do for inclusion. It seems easier to just try to keep up with
the changes.

I'm certain our company is not the only one in this situation. I see
many GPL external kernel drivers. Why?

Mark
