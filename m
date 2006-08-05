Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWHEFhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWHEFhF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHEFhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 01:37:05 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:18820 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932615AbWHEFhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 01:37:02 -0400
Message-ID: <44D42E7D.70101@vmware.com>
Date: Fri, 04 Aug 2006 22:37:01 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>	 <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>	 <1154726800.23655.273.camel@localhost.localdomain> <1154740485.3683.161.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1154740485.3683.161.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> My take is that the VMI proposal breaks down into two pieces:
>   

This is a very accurate description of our interface.

> 1) A hypervisor ABI.  This is easy: we maintain ABIs today between libc
> and the kernel, so nothing about an ABI is inherantly GPL violating.
>   

This I think is an absolute must for any sane interpretation of the 
GPL.  Otherwise, running GPL apps on any proprietary operating system 
falls into the same situation, and you wouldn't be able to run them 
without violating the GPL.  Nor would you be able to run non-GPL 
applications on a GPL kernel.  It's really a matter of whether you 
interpret the intent of the GPL to prevent someone deriving work from 
your open source software and distributing that in binary form without 
providing the dervied work - or if you interpret the GPL as saying that 
all code must be open sourced.  The latter is a very extreme position, 
and I don't believe it is even correct with the current wording of GPL 
v2 (IANAL).

> 2) A gateway page or vDSO provided by the hypervisor to the kernel.
> This is the problematic piece, because the vDSO is de-facto linked into
> the kernel and as such becomes subject to the prevailing developer
> interpretation as being a derivative work by being linked in.  As Arjan
> pointed out, this can be avoided as long as the gateway page itself is
> GPL ... we could even create mechanisms like we use today for module
> licensing by having a tag in the VMI describing the licensing of the
> gateway page, so the kernel could be made only to load gateway pages
> that promise they're available under the GPL.
>   

Yes, this is what prompted my whole module rant.  The interesting thing 
is - Linux may link to the hypervisor vDSO.  But it may not link back 
into Linux.  This is where the line becomes very gray, as Theodore 
mentioned earlier.  Is it a license violation for a GPL app to link 
against a non-GPL library?  Surely, the other way around is a problem, 
unless the library has been made explicitly LGPL.  But if GPL apps can 
link to non-GPL libraries, what stops GPL kernels from linking to 
non-GPL modules?  This is where I think things become more interpretive 
than well defined.  And that is why it is important for us to get kernel 
developers feedback on exactly what that definition is.

> I think that if we do this tagging to load the VMI vDSO interface, then
> I'm happy that all of the legal niceties are safely taken care of.
> (Although the onus is now back on VMware to establish if they can GPL
> their VMI blob).
>   

Tagging is interesting.  You can tag modules by license.  I can't say 
today what license we will be able to use for it - it could be 
completely proprietary, some new license, BSD, or GPL.  This is the 
essence of my original rant - it would be nice to have a way to tag the 
license in the "blob" so the kernel can choose the appropriate course of 
action.  In that case, the pressure is off me to specify what the 
license is - it's there for everyone to see, and then it is just a 
matter of coming to a consensus as to what an acceptable license is for 
Linux to link to it.  What license(s) we provide is really not up to me, 
although I personally would very much like to see an open source license 
that allows everyone to see the code, fix any problems they have with 
it, and distribute those fixes (purely my own personal opinion, and in 
no way a statement, promise, or supposition in any legal or corporate 
sense for any past, present, or future work by VMware, EMC, or any other 
entity, wholly or partially owned by said corporations, and in no way 
should this be interpreted as constituting a legal opinion for the 
purposes of advice or rendering of any court decision, now, in the 
future, or in the past for legal arbiters with access to time travel 
equipment). <Now I'm covered better than Alan>.

Binary blob has been a PR disaster.  I don't know if I first said it 
unprompted, or if Cristoph cleverly baited me into using the phrase ;)  
But lets be clear on one thing - blob implies some kind of shapeless, 
fat thing.  The VMI fits in two pages of memory, and has a well defined 
interface, which gives it shape.  So I prefer binary redirection 
interface, or vDSO, or anything without the disparaged word "blob" in it.

Zach
