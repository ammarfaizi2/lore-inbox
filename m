Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVADOGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVADOGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVADOGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:06:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261647AbVADOF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:05:56 -0500
Date: Tue, 4 Jan 2005 09:05:13 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mark Williamson <maw48@cl.cam.ac.uk>
cc: xen-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
In-Reply-To: <200501040304.10128.maw48@cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0501040902400.25392@chimarrao.boston.redhat.com>
References: <20050102162652.GA12268@lkcl.net> <20050103205318.GD6631@lkcl.net>
 <1104785749.13302.26.camel@localhost.localdomain> <200501040304.10128.maw48@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Mark Williamson wrote:

>> for doing opportunistic page recycling ("I dont need this page but when
>> I ask for it back please tell me if you trashed the content")
>
> We've talked about doing this but AFAIK nobody has gotten round to it 
> yet because there hasn't been a pressing need (IIRC, it was on the todo 
> list when Xen 1.0 came out).
>
> IMHO, it doesn't look terribly difficult but would require (hopefully 
> small) modifications to the architecture independent code, plus a little 
> bit of support code in Xen.

The architecture independant changes are fine, since
they're also useful for S390(x), PPC64 and UML...

> I'd quite like to look at this one fine day but I suspect there are more 
> useful things I should do first...

I wonder if the same effect could be achieved by just
measuring the VM pressure inside the guests and
ballooning the guests as required, letting them grow
and shrink with their workloads.

That wouldn't need many kernel changes, maybe just a
few extra statistics, or maybe all the needed stats
already exist.  It would also allow more complex
policy to be done in userspace, eg. dealing with Xen
guests of different priority...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
