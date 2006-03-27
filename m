Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWC0UhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWC0UhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWC0UhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:37:22 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:33157 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750989AbWC0UhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:37:21 -0500
Date: Mon, 27 Mar 2006 13:38:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Randy Vinson <rvinson@mvista.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
Message-ID: <20060327203802.GA10238@mag.az.mvista.com>
References: <20060323201030.ccded642.khali@linux-fr.org> <4423084B.1070701@mvista.com> <20060323214028.GB21477@mag.az.mvista.com> <20060324215311.8ea42d20.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324215311.8ea42d20.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 09:53:11PM +0100, Jean Delvare wrote:
> Hi Mark,
> 
> > > I've attached a similar patch that has been tested using the DS1374 on the 
> > > Freescale MPC8349MDS reference system. It is patterned after a similar 
> > > change made to the m41t00 driver. The changes work, but I am also 
> > > unfamiliar with workqueues, so my patch may not be any better.
> > 
> > I'm no expert in workqueues either; however, after reading
> > http://lwn.net/Articles/23634/, I believe that its unnecessary for an
> > rtc driver to have its own workqueue since rtc writes aren't particularly
> > time-critical.  If I am correct, then Randy's patch uses the proper wq calls.  
> > 
> > Agree?
> 
> I'm not sure. My first try was mostly similar to Randy's, using the
> shared workqueue. However, LDD3 (and, for that matter, the article you
> pointed to) says to be cautious when using the shared workqueue, not
> only because of by what others can do to you, but also because of what
> your can do to others.
> 
> ds1374_set_tlet triggers many i2c transfers, which may delay or sleep
> depending on the underlying i2c implementation, and definitely will
> take some time (at least 224 I2C clock cycles if I'm counting properly,
> that is 14 ms at 16 kHz.)
> 
> So I came to the conclusion that it wouldn't be fair to other users if
> ds1374 was using the shared workqueue. Now, I really don't know for
> sure, so I'll let workqueue experts decide what should be done here.

Hmm, you raise a good point, Jean.  I just talked to Randy and we agreed
to agree with you.  :)  Randy will make a patch for the ds1374 and I'll
rework the patches for the m41t00.  Stay tuned...

Mark
