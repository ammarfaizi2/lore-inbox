Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRLQMIb>; Mon, 17 Dec 2001 07:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLQMIR>; Mon, 17 Dec 2001 07:08:17 -0500
Received: from [195.66.192.167] ([195.66.192.167]:27148 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285098AbRLQMHz>; Mon, 17 Dec 2001 07:07:55 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sean Hunter <sean@dev.sportingbet.com>
Subject: Re: [PATCH] kill(-1,sig)
Date: Mon, 17 Dec 2001 14:06:31 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl> <01121712412100.02022@manta> <20011217115344.C14112@dev.sportingbet.com>
In-Reply-To: <20011217115344.C14112@dev.sportingbet.com>
MIME-Version: 1.0
Message-Id: <01121714063106.02146@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 09:53, Sean Hunter wrote:
> > Hmm. Looking at killall5 source I see
> >
> > kill(-1, STOP);
> > for(each proc with p.sid!=my_sid) kill(proc, sig);
> > kill(-1, CONT);
> >
> > I guess STOP will stop killall5 too? Not good indeed.
> >
> > We have two choices: either back it out or find a sane way to implement
> > killall5 with new kill -1 behaviour.
>
> Couldn't it just do:
>
> sigset_t new;
> sigset_t savemask;
> sigfillset (&new);
> sigprocmask (SIG_BLOCK, &new, &savemask);
>
> kill(-1, STOP);
> for(each proc with p.sid!=my_sid) kill(proc, sig);
> kill(-1, CONT);
>
> sigprocmask (SIG_SETMASK, &savemask, (sigset_t *) 0);
>
> ... in other words, block signals, do the killing, then unblock?

STOP cannot be blocked or trapped AFAIK.
--
vda
