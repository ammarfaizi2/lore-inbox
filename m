Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWFHQMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWFHQMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWFHQMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:12:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63459 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964900AbWFHQMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:12:24 -0400
Date: Thu, 8 Jun 2006 18:11:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060608161130.GA6869@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> >   &ni->mrec_lock  - a spinlock protecting a particular inode's MFT data. 
> >                     (finegrained lock for the MFT record) It is 
> >                     typically taken by map_mft_record() and released by 
> >                     unmap_mft_record().
> 
> Correct, except s/spinlock/semaphore/ (that really should become a 
> mutex one day).

yeah - it's in fact a mutex already.

> No it is not as explained above.  Something has gotten confused 
> somewhere because the order of events is the wrong way round...

did my second trace make more sense? The dependency that the validator 
recorded can be pretty much taken as granted - it only stores 
dependencies that truly trigger runtime. What shouldnt be taken as 
granted is my explanation of the events :-)

there is a wide array of methods and APIs available to express locking 
semantics to the validator in a natural and non-intrusive way [for cases 
where the validator gets it wrong or simply has no way of auto-learning 
them] - but for that i'll first have to understand the locking semantics
:-)

	Ingo
