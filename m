Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281570AbRKUKNG>; Wed, 21 Nov 2001 05:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUKM5>; Wed, 21 Nov 2001 05:12:57 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:8201 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281563AbRKUKMo>; Wed, 21 Nov 2001 05:12:44 -0500
Date: Wed, 21 Nov 2001 11:12:43 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: copy to user
Message-ID: <20011121111243.B2196@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt> <XFMail.20011121094325.mathijs@knoware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20011121094325.mathijs@knoware.nl>; from mathijs@knoware.nl on Wed, Nov 21, 2001 at 09:43:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I suppose now you can understand why SIGSTOP won't work. Hope you can help
> > me :)
> 
> how about making a signal handler for SIGUSR1 that checks a global variable and
> loops. an other signal handler for SIGUSR2 to clear the variable so the SIGUSR1
> handler can exit.
> 
> All in user space. (to delay execution kill -USR1 $pid, to continue: kill -USR2
> $pid)

The same is possible within the kernel too! Add default handler to some
unused signals (there are more user-defineable signals than SIGUSR[12]
and noone cares to install handler for them) to do the loop in kernel.
Just make sure, that you call shedule() from time to time in that loop,
because in kernel you can't be preempted as you would in user-space.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
