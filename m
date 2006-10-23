Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWJWV3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWJWV3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWJWV3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:29:51 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:51777 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752017AbWJWV3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:29:51 -0400
Date: Mon, 23 Oct 2006 23:29:46 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Yinghai Lu <yinghai.lu@amd.com>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Message-ID: <20061023212946.GA4354@rhun.haifa.ibm.com>
References: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com> <m1ac3nvyhi.fsf@ebiederm.dsl.xmission.com> <20061023204519.GJ3502@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023204519.GJ3502@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:45:19PM +0200, Adrian Bunk wrote:
> On Mon, Oct 23, 2006 at 09:32:57AM -0600, Eric W. Biederman wrote:
> > "Yinghai Lu" <yinghai.lu@amd.com> writes:
> > 
> > > in phys flat mode, when using set_xxx_irq_affinity to irq balance from
> > > one cpu to another,  _assign_irq_vector will get to increase last used
> > > vector and get new vector. this will use up the vector if enough
> > > set_xxx_irq_affintiy are called. and end with using same vector in
> > > different cpu for different irq. (that is not what we want, we only
> > > want to use same vector in different cpu for different irq when more
> > > than 0x240 irq needed). To keep it simple, the vector should be resued
> > > from one cpu to another instead of getting new vector.
> > >
> > > Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
> > 
> > YH.  I think the concept is sound.  I don't think this is a bug fix, just
> > an optimization so this may not be 2.6.19 material.  But we are thrashing
> > things so much it may make sense to include it, and it likely to keeps
> > us from running into problems, so it can be called a bug preventative :)
> >...
> 
> Is this patch intended as fix for the 2.6.19-rc regression described 
> in [1]?

No, that regression is fixed by the two x86-64 patches Eric sent in
http://marc.theaimsgroup.com/?t=116157840300001&r=1&w=2.

Cheers,
Muli
