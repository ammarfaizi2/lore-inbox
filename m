Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTIDAMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTIDAMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:12:00 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21769
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263864AbTIDAL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:11:58 -0400
Date: Wed, 3 Sep 2003 17:12:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O20int
Message-ID: <20030904001214.GH16361@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200309040053.22155.kernel@kolivas.org> <20030903191946.GB16361@matchmail.com> <200309040855.46034.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309040855.46034.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 08:55:45AM +1000, Con Kolivas wrote:
> On Thu, 4 Sep 2003 05:19, Mike Fedyk wrote:
> > On Thu, Sep 04, 2003 at 12:53:10AM +1000, Con Kolivas wrote:
> > > Smaller timeslice granularity for most interactive tasks and larger for
> > > less interactive. Smaller for each extra cpu.
> > >
> > > +#ifdef CONFIG_SMP
> > > +#define TIMESLICE_GRANULARITY(p) \
> > > +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
> > > +		num_online_cpus())
> > > +#else
> > > +#define TIMESLICE_GRANULARITY(p) \
> > > +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
> > > +#endif
> > > +
> >
> > Don't you want to put a max(10,TIMESLICE_GRANULARITY) in there so that the
> > time slice won't go below 1ms for large proc servers?  I'm not sure if it
> > was you, or someone else but they did some testing to see how the
> > timeslice length affected the cache warmth, and the major improvements
> > stopped after 7ms, so 10 might be a good default mimimum.
> 
> That works out to 10ms minimum.

With how many processors? 64? 128?
