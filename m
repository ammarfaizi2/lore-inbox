Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRKAAWy>; Wed, 31 Oct 2001 19:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276639AbRKAAWo>; Wed, 31 Oct 2001 19:22:44 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:18700 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S276628AbRKAAWd>; Wed, 31 Oct 2001 19:22:33 -0500
Date: Thu, 1 Nov 2001 01:23:02 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011031165609.T16554@lynx.no>
Message-ID: <Pine.LNX.4.30.0111010107200.31315-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Andreas Dilger wrote:

> I would say that (excluding stability issues because of jiffies wrap)
> that this is ready for submission to Linus.  He may be of the mind that
> he would rather fix the wrap issues sooner rather than later, or he
> may want to minimize disruption during the "VM stabilize" period (there
> are still a couple of hang issues apparently).
>

I'd rather object for now. I've had a couple of hard freezes within
minutes to hours after jiffies wraparound. Also some KDE applications
behave strange, the KDE panel and kterm need approx 2 min to appear
even before the wraparound (so it seems to be a sign issue rather than
wraparound). I don't want to see this in a stable kernel.

However, I would be pleased if widespread intentional use of the patch
would help to solve the remaining wraparound issues.

> > +u64 get_jiffies64(void)
> > +{
> > +	static unsigned long jiffies_hi = 0;
> > +	static unsigned long jiffies_last = INITIAL_JIFFIES;
> > +	static unsigned long jiffies_tmp;
>         ^^^^^^ jiffies_tmp doesn't need to be static.

Yes, cut and paste error, sorry. And I wanted this patch to be final for
today...

>
> One suggestion someone had was to put dummy "get_jiffies64()" calls
> in some other infrequently used areas to ensure jiffies_hi is valid
> if we don't call uptime for 1.3 years after the first wrap.  I don't
> know if that matters or not.
>

I don't have enough knowledge of the kernel to find good places.
Any suggestions?


Tim

