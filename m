Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRHTVLU>; Mon, 20 Aug 2001 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRHTVLK>; Mon, 20 Aug 2001 17:11:10 -0400
Received: from [213.4.18.231] ([213.4.18.231]:23826 "EHLO fulanito.nisupu.com")
	by vger.kernel.org with ESMTP id <S269404AbRHTVK5>;
	Mon, 20 Aug 2001 17:10:57 -0400
Message-ID: <009501c129bc$75724ca0$0414a8c0@10>
From: =?iso-8859-1?Q?Carlos_Fern=E1ndez_Sanz?= 
	<cfs-lk@fulanito.nisupu.com>
To: "Ignacio Vazquez-Abrams" <ignacio@openservices.net>,
        =?iso-8859-1?Q?Carlos_Fern=E1ndez_Sanz?= 
	<cfs-lk@fulanito.nisupu.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108201659080.11734-100000@terbidium.openservices.net>
Subject: Re: Fw: select(), EOF...
Date: Mon, 20 Aug 2001 23:09:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a strace shows it works differently

nanosleep({1, 0}, {1, 0})               = 0
fstat(3, {st_mode=S_IFREG|0600, st_size=227128, ...}) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [RT_0], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [RT_0], NULL, 8) = 0

the file is opened just once (as I expected), and tail sleeps in nanosleep
() until the file grows. I think strace isn't showing more nanosleep() as it
should be looping there. BTW what's the reason for the sigprocmask, etc?

----- Original Message -----
From: "Ignacio Vazquez-Abrams" <ignacio@openservices.net>
To: "Carlos Fernández Sanz" <cfs-lk@fulanito.nisupu.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, August 20, 2001 11:00 PM
Subject: Re: Fw: select(), EOF...


> On Mon, 20 Aug 2001, Carlos Fernández Sanz wrote:
>
> > How come the process is never runnable unless there's new data in the
file?
> > If it was opening and closing the file continously it would be using
lots of
> > CPU, while it's 0 if there's no data coming.
>
> It sleep()s between close() and open().
>
> --
> Ignacio Vazquez-Abrams  <ignacio@openservices.net>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

