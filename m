Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTALWfN>; Sun, 12 Jan 2003 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTALWfN>; Sun, 12 Jan 2003 17:35:13 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4281 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267583AbTALWfJ> convert rfc822-to-8bit; Sun, 12 Jan 2003 17:35:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 23:43:41 +0100
User-Agent: KMail/1.4.3
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <200301122306.14411.oliver@neukum.name> <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301122343.41150.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Januar 2003 23:22 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 17:06, Oliver Neukum wrote:
> > Please don't do such things. The next time locking is changed and a lock
> > is needed here, some poor guy has to go through that and change all
> > back to goto.
> > This may not be applicable here, but as a general rule, don't do it.
> > I speak from experience.
> >
> > As for efficiency, that is the compiler's job.
>
> I say "please don't use goto" and instead have a "cleanup_lock" function
> and add that before all the return statements..  It should not be a
> burden.  Yes, it's asking the developer to work a little harder, but the
> end result is better code.

It's code that causes added hardship for anybody checking the locking.
It becomes impossible to see whether locks are balanced and turns into
a nightmare as soon as you need error exits from several depths of locking
or with and without memory to be freed.

Please listen to experience.

err_out_buffer:
	kfree(buffer);
err_out_nobuffer:
	up(&sem);
err_out_nolock:
	return err;

is pretty much the only readable construction.

	Regards
		Oliver

