Return-Path: <linux-kernel-owner+w=401wt.eu-S1751259AbXAPUG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbXAPUG5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAPUG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:06:57 -0500
Received: from smtp-out.google.com ([216.239.45.13]:26151 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXAPUG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:06:56 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=rM/uJQWFebfJpkGs16RzDJYm00GC/qvkDuWIpW2IzzYTROunYQTo0MEoBpCRgqNV1
	hc5PxP59xvSIfLeMldnSw==
Message-ID: <6599ad830701161206w7dff0fa8y34f1e74f94ab9051@mail.gmail.com>
Date: Tue, 16 Jan 2007 12:06:50 -0800
From: "Paul Menage" <menage@google.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [RFC 8/8] Reduce inode memory usage for systems with a high MAX_NUMNODES
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       "Andi Kleen" <ak@suse.de>, "Paul Jackson" <pj@sgi.com>,
       "Dave Chinner" <dgc@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701161152450.2780@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com>
	 <6599ad830701161152q75ff29cdo7306c9b8df5c351b@mail.gmail.com>
	 <Pine.LNX.4.64.0701161152450.2780@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/07, Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 16 Jan 2007, Paul Menage wrote:
>
> > On 1/15/07, Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > > This solution may be a bit hokey. I tried other approaches but this
> > > one seemed to be the simplest with the least complications. Maybe someone
> > > else can come up with a better solution?
> >
> > How about a 64-bit field in struct inode that's used as a bitmask if
> > there are no more than 64 nodes, and a pointer to a bitmask if there
> > are more than 64 nodes. The filesystems wouldn't need to be involved
> > then, as the bitmap allocation could be done in the generic code.
>
> How would we decide if there are more than 64 nodes? Runtime or compile
> time?

I was thinking runtime, unless MAX_NUMNODES is less than 64 in which
case you can make the decision at compile time.

>
> If done at compile time then we will end up with a pointer to an unsigned
> long for a system with <= 64 nodes. If we allocate the nodemask via
> kmalloc then we will always end up with a mininum allocation size of 64
> bytes.

Can't we get less overhead with a slab cache with appropriate-sized objects?

Paul
