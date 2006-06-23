Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWFWN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFWN5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWFWN5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750721AbWFWNp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:45:56 -0400
Date: Fri, 23 Jun 2006 09:39:12 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-5.boston.redhat.com
To: Robert Hancock <hancockr@shaw.ca>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
In-Reply-To: <449B42B3.6010908@shaw.ca>
Message-ID: <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no> <449B42B3.6010908@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2006, Robert Hancock wrote:

> Jason Baron wrote:
> > Currently, if i mmap() a file PROT_WRITE only and then first read from it
> > and then write to it, i get a SEGV. However, if i write to it first and then
> > read from it, i get no SEGV. This seems rather inconsistent.
> > 
> > The current implementation seems to be to make PROT_WRITE imply PROT_READ,
> > however it does not quite work correctly. The patch below resolves this
> > issue, by explicitly setting the PROT_READ flag when PROT_WRITE is
> > requested.
> 
> I would disagree.. the kernel is enforcing the permissions specified where the
> CPU architecture allows it. There is no sense in breaking this everywhere just
> because we can't always enforce it. By that logic we should be making
> PROT_READ imply PROT_EXEC because not all CPUs can enforce them separately,
> which makes no sense at all.
> 
> > 
> > This might appear at first as a possible permissions subversion, as i could
> > get PROT_READ on a file that i only have write permission to...however, the
> > mmap implementation requires that the file be opened with at least read
> > access already. Thus, i don't believe there is any issue with regards to
> > permissions.
> > 
> > Another consequenece of this patch is that it forces PROT_READ even for
> > architectures that might be able to support it, (I know that x86, x86_64 and
> > ia64 do not) but i think this is best for portability.
> 
> That makes little sense to me.. if you want portability, and you're reading
> from the file, you better request PROT_READ. Any app that doesn't do that is
> inherently broken and non-portable regardless of what you do to the kernel.
> 
> 


hi,

So if i create a PROT_WRITE only mapping and then read from first and then 
writte to it a get a SEGV. However, if i write to it first and then read 
from it, i don't get a SEGV...Why should the read/write ordering matter? 

thanks,

-Jason 

