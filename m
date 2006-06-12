Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWFLOiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWFLOiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWFLOiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:38:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:38165 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751827AbWFLOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:38:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eb+SDlHqEXBWKvHNJjznVzeXj2UdZHhvg7FncvwytC0S/1y2V56DKjYLe8p880JbIwC2cyMe8BP0atRXT46WV6YJ1A/eABbH7Qw8eh0a53wKymeeD3ykHqmwJ1AO8/SuQtwAhWcWfFeNUzmH9AnJbQk/7+nEKX9q5gAMttJJeNg=
Message-ID: <b0943d9e0606120738h3d39326ex54e7cc2ea28fc5ea@mail.gmail.com>
Date: Mon, 12 Jun 2006 15:38:21 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612131209.GB17463@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
	 <20060612113637.GA14136@elte.hu>
	 <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
	 <20060612131209.GB17463@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> * Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> > > >   - arch/i386/kernel/setup.c:
> > > >     False positive because res pointer is stored in a global instance of
> > > >     struct resource.
> > >
> > > there's no good way around this one but to annotate it in one way or
> > > another.
> >
> > Scanning bss and data sections is too expensive, I guess.  I would
> > prefer we create a separate section for gc roots but what you're
> > suggesting is ok as well.
>
> kmemleak does scan global data sections. I dont know why we dont
> discover this particular pointer though: the resource pointer ought to
> be accessible via the iomem_resource.parent/sibling/child sorted list.
> Hm.

Maybe it only appeared in the initial versions of kmemleak due to bugs
in the tool and I never removed it. I'll check it again this evening
on my home machine (that's where I got it). However, if
request_resource() returns -EBUSY, that's a real leak.

-- 
Catalin
