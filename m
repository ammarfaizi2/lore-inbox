Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFKAwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFKAwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFKAwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:52:45 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:40836 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261502AbVFKAwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:52:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 10:52:02 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <1118449942l.11603l.0l@werewolf.able.es> <200506111048.50169.kernel@kolivas.org>
In-Reply-To: <200506111048.50169.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111052.03541.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005 10:48, Con Kolivas wrote:
> On Sat, 11 Jun 2005 10:32, J.A. Magallon wrote:
> > On 06.11, Con Kolivas wrote:
> > > Here is what the patch _should_ have been. (*same warnings with this
> > > patch about math demonstration and untested as should have been posted
> > > with the earlier one*)
> > >
> > > +	if (idle == NOT_IDLE || rq->nr_running > 1) {
> > > +		unsigned long prio_bias = 1;
> > > +		if (rq->nr_running)
> > > +			prio_bias = rq->prio_bias / rq->nr_running;
> > > +		source_load *= prio_bias;
> > > +	}
> >
> > Again... sorry, I don't try to be picky, just want to know if its worth
> > or not...
> >
> > Would not be better something like:
> >
> > 	if (idle == NOT_IDLE || rq->nr_running > 1) {
> > 		if (rq->nr_running)
> > 			source_load = (source_load*rq->prio_bias) / rq->nr_running;
> > 	}
>
> I understand your concern, but by definition rq->nr_running will always be
> a factor of rq->prio_bias so integer math should be fine. Either will do.

Hmm. No you are right and I'm smoking crack, but integer math should still be 
accurate enough here. Let me think about the accuracy before spraying more 
patches like a fool.

Cheers,
Con
