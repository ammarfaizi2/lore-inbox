Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUJ3XCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUJ3XCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUJ3XBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:01:41 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:21241 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261413AbUJ3W7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:59:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iNp7QaqKFbmFWCI9y2c02qURNJvpBTqIvV/jBQuA4t3B9iVWEznKjo0nmncbMAfrBzMroz55l33n1Np7CzuaWuNvstMGBmgyzQsTQ0kWGMFEJ+J85FZfdxWvyqF5MlZs2hOC9ypdJ9lp6kbJgmLSrIULrOf4S+isLyMdu0/LW+w=
Message-ID: <29495f1d041030155953a9a776@mail.gmail.com>
Date: Sat, 30 Oct 2004 15:59:20 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [KJ] Re: [patch 2.4] back port msleep(), msleep_interruptible()
Cc: maximilian attems <janitor@sternwelten.at>, netdev@oss.sgi.com,
       Margit Schubert-While <margitsw@t-online.de>,
       kernel-janitors@lists.osdl.org, mcgrof@studorgs.rutgers.edu,
       prism54-devel@prism54.org, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org, hvr@gnu.org
In-Reply-To: <41841886.2080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040923221303.GB13244@us.ibm.com>
	 <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de>
	 <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at>
	 <41841886.2080609@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 18:41:10 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> maximilian attems wrote:
> > diff -puN include/linux/delay.h~add-msleep-2.4 include/linux/delay.h
> > --- a/include/linux/delay.h~add-msleep-2.4    2004-10-30 22:48:46.000000000 +0200
> > +++ b/include/linux/delay.h   2004-10-30 22:48:46.000000000 +0200
> > @@ -34,4 +34,12 @@ extern unsigned long loops_per_jiffy;
> >       ({unsigned long msec=(n); while (msec--) udelay(1000);}))
> >  #endif
> >
> > +void msleep(unsigned int msecs);
> > +unsigned long msleep_interruptible(unsigned int msecs);
> > +
> > +static inline void ssleep(unsigned int seconds)
> [...]
> > +static inline unsigned int jiffies_to_msecs(const unsigned long j)
> 
> > +static inline unsigned int jiffies_to_usecs(const unsigned long j)
> 
> > +static inline unsigned long msecs_to_jiffies(const unsigned int m)
> 
> 
> I'm pretty sure more than one of these symbols clashes with a symbol
> defined locally in a driver.  I like the patch but we can't apply it
> until the impact on existing code is evaluated.

More than likely much of the code cleanup that was done before I began
my patches, like removing custom msleep()s from drivers will need to
be done again, as Jeff points out.

-Nish
