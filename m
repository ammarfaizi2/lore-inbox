Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUJ3XVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUJ3XVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUJ3XUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:20:06 -0400
Received: from baikonur.stro.at ([213.239.196.228]:65493 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261424AbUJ3XT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:19:29 -0400
Date: Sun, 31 Oct 2004 01:19:12 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Margit Schubert-While <margitsw@t-online.de>,
       kernel-janitors@lists.osdl.org, mcgrof@studorgs.rutgers.edu,
       prism54-devel@prism54.org, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org, hvr@gnu.org
Subject: Re: [KJ] Re: [patch 2.4] back port msleep(), msleep_interruptible()
Message-ID: <20041030231912.GC1456@stro.at>
Mail-Followup-To: Nish Aravamudan <nish.aravamudan@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	Margit Schubert-While <margitsw@t-online.de>,
	kernel-janitors@lists.osdl.org, mcgrof@studorgs.rutgers.edu,
	prism54-devel@prism54.org, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org, hvr@gnu.org
References: <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at> <41841886.2080609@pobox.com> <29495f1d041030155953a9a776@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d041030155953a9a776@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Nish Aravamudan wrote:

> On Sat, 30 Oct 2004 18:41:10 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > maximilian attems wrote:
> > > diff -puN include/linux/delay.h~add-msleep-2.4 include/linux/delay.h
> > > --- a/include/linux/delay.h~add-msleep-2.4    2004-10-30 22:48:46.000000000 +0200
> > > +++ b/include/linux/delay.h   2004-10-30 22:48:46.000000000 +0200
> > > @@ -34,4 +34,12 @@ extern unsigned long loops_per_jiffy;
> > >       ({unsigned long msec=(n); while (msec--) udelay(1000);}))
> > >  #endif
> > >
> > > +void msleep(unsigned int msecs);
> > > +unsigned long msleep_interruptible(unsigned int msecs);
> > > +
> > > +static inline void ssleep(unsigned int seconds)
> > [...]
> > > +static inline unsigned int jiffies_to_msecs(const unsigned long j)
> > 
> > > +static inline unsigned int jiffies_to_usecs(const unsigned long j)
> > 
> > > +static inline unsigned long msecs_to_jiffies(const unsigned int m)
> > 
> > 
> > I'm pretty sure more than one of these symbols clashes with a symbol
> > defined locally in a driver.  I like the patch but we can't apply it
> > until the impact on existing code is evaluated.
> 
> More than likely much of the code cleanup that was done before I began
> my patches, like removing custom msleep()s from drivers will need to
> be done again, as Jeff points out.
> 
> -Nish

thanks Jeff for your quick response,
ooh i seee libata is defining an msleep().
so there seems to be need for it.

ok we'll come up with tougher patchset.

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

