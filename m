Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSCEXki>; Tue, 5 Mar 2002 18:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCEXk2>; Tue, 5 Mar 2002 18:40:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26263 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293489AbSCEXjs>; Tue, 5 Mar 2002 18:39:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Tue, 5 Mar 2002 18:40:46 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com> <20020305215759.21E623FFD3@smtp.linux.ibm.com> <87vgcazl4a.fsf@devron.myhome.or.jp>
In-Reply-To: <87vgcazl4a.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305233943.F157B3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 05:48 pm, OGAWA Hirofumi wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> > > > @@ -153,13 +155,18 @@
> > > >                               if(last_pid & 0xffff8000)
> > > >                                     last_pid = 300;
> > > >                               next_safe = PID_MAX;
> > > > +                             goto repeat;
> > > >                         }
> > > > -                       goto repeat;
> > > > +                       if(unlikely(last_pid == beginpid))
> > > > +                             goto nomorepids;
> > > > +                       continue;
> > >
> > > You changed it. No?
> >
> > Yes, we changed but only the logic that once a pid is busy we start
> > searching for every task again. This is exactly the O(n**2) problem.
> > Run the program and you'll see.
>
> Run the attached file.
>
> Result,
> 	new pid: 301, 300: pid 300, pgrp 301
>
> new pid == task(300)->pgrp. This get_pid() has bug.
> I'm missing something?

Yipp you are right. 
I stay corrected, we are missing something. Will work on it and see
whether we can correct it, either way we should be able to
get ride of the o(n**2) effect.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
