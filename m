Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWIFICH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWIFICH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWIFICG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:02:06 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:64493 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751630AbWIFICE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:02:04 -0400
Date: Wed, 6 Sep 2006 10:01:29 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu> <20060906072043.GC6898@osiris.boeblingen.de.ibm.com> <20060906004724.e52d45a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906004724.e52d45a2.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 12:47:24AM -0700, Andrew Morton wrote:
> On Wed, 6 Sep 2006 09:20:43 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > I'm also wondering why the profile
> > patch contains this:
> > 
> > +       if (ret)
> > +               likeliness->count[1]++;
> > +       else
> > +               likeliness->count[0]++;
> > 
> > This isn't smp safe. Is that on purpose or a bug?
> 
> Purposeful.   This is called from all contexts, including NMI.

Why not use atomic_inc then? Or is there some architecture dependent
limitation that it can't be done in every context?
