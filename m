Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTICWsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTICWsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:48:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:33728
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264322AbTICWsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:48:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [PATCH]O20int
Date: Thu, 4 Sep 2003 08:55:45 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200309040053.22155.kernel@kolivas.org> <20030903191946.GB16361@matchmail.com>
In-Reply-To: <20030903191946.GB16361@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040855.46034.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 05:19, Mike Fedyk wrote:
> On Thu, Sep 04, 2003 at 12:53:10AM +1000, Con Kolivas wrote:
> > Smaller timeslice granularity for most interactive tasks and larger for
> > less interactive. Smaller for each extra cpu.
> >
> > +#ifdef CONFIG_SMP
> > +#define TIMESLICE_GRANULARITY(p) \
> > +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
> > +		num_online_cpus())
> > +#else
> > +#define TIMESLICE_GRANULARITY(p) \
> > +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
> > +#endif
> > +
>
> Don't you want to put a max(10,TIMESLICE_GRANULARITY) in there so that the
> time slice won't go below 1ms for large proc servers?  I'm not sure if it
> was you, or someone else but they did some testing to see how the
> timeslice length affected the cache warmth, and the major improvements
> stopped after 7ms, so 10 might be a good default mimimum.

That works out to 10ms minimum.

Con

