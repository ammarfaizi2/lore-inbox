Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJCQUv>; Wed, 3 Oct 2001 12:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276452AbRJCQUn>; Wed, 3 Oct 2001 12:20:43 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:58193 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276451AbRJCQUe>; Wed, 3 Oct 2001 12:20:34 -0400
Date: Wed, 3 Oct 2001 11:20:38 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Ben Greear <greearb@candelatech.com>
cc: jamal <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBB3845.DAE47D27@candelatech.com>
Message-ID: <Pine.LNX.3.96.1011003111405.4818F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Ben Greear wrote:
> jamal wrote:
> > On Wed, 3 Oct 2001, Ben Greear wrote:
> > > jamal wrote:
> > > > No. NAPI is for any type of network activities not just for routers or
> > > > sniffers. It works just fine with servers. What do you see in there that
> > > > will make it not work with servers?
> > >
> > > Will NAPI patch, as it sits today, fix all IRQ lockup problems for
> > > all drivers (as Ingo's patch claims to do), or will it just fix
> > > drivers (eepro, tulip) that have been integrated with it?
> > 
> > Unfortunately amongst the three of us tulip seemed to be the most common.
> > Robert has a gige intel. So patches appear only for those two drivers. I
> > could write up a document on how to change drivers.
> 
> So, couldn't your NAPI patch be used by drivers that are updated, and
> let Ingo's patch be a catch-all for un-fixed drivers?  As we move foward,
> more and more drivers support your version, and Ingo's patch becomes less
> utilized.  So long as the patches are tuned such that yours keeps Ingo's
> from being triggered on devices you support, there should be no real
> conflict, eh?

The main thing for me is that jamal/robert/ANK's work has been
undergoing research and refinement for a while now, with very promising
results combined with minimal impact on network drivers.

Any of Ingo's solutions need to be tested in a variety of situations
before we can jump on it with any confidence.

For example, although Ingo dismisses shared-irq situations as
an uninteresting case, we need to take that case into account as well,
because starvation can definitely occur.

I'm all for trying out ideas and test patches, but something as core as
hard IRQ handling needs a lot of testing and research in many different
real world situations before we use it.

So far I do not agree that there is a magic bullet...

	Jeff



