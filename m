Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271850AbRHUUSP>; Tue, 21 Aug 2001 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271852AbRHUUSG>; Tue, 21 Aug 2001 16:18:06 -0400
Received: from [145.254.145.253] ([145.254.145.253]:20975 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271850AbRHUUR4>;
	Tue, 21 Aug 2001 16:17:56 -0400
Message-ID: <3B82C1AF.819C52B3@pcsystems.de>
Date: Tue, 21 Aug 2001 22:16:47 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: multiply NULL pointer
In-Reply-To: <3B72BA01.34D2A67F@pcsystems.de> <3B770C04.C8FDD6E6@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hello!
> >
> > Running a p2 400 mhz box with a 3com 3c905, with
> > _very_ heavy nfs traffic and disc io the following NULL
> > pointers were produced. I attached the whole dmesg output.
> > If more informations are needed, I will send them.
> >
> > After every NULL pointer printed on the console
> > I took a new dmesg, so the one with the highest number
> > should be relevant.
> >
>
> Please tell us exactly which kernel you're using.  It appears
> to be a flavour of 2.4.7 with ext3, yes?

Yes. plain 2.4.7 + ext3 patch

> Also, please take the very first oops output which occurs
> after a reboot and feed that into
>
>         ksymoops -m System.map < oops-trace-file.txt
>
> Make sure you have the correct System.map!

I hope it was the right one (it was the only one left after
I cleaned the system some days ago )

> The fact that your bdflush and kupdate daemons have gone zombie
> suggests that the kernel died in the new buffer flushing code.
> There was a bug fixed in that area late in the 2.4.8-pre series.
>
> >From memory, the bug was a missing test for a null bh in
> fs/buffer.c:sync_old-buffers():
>
>         for (;;) {
>                 struct buffer_head *bh;
>
>                 spin_lock(&lru_list_lock);
>                 bh = lru_list[BUF_DIRTY];
>                 if (!bh || time_before(jiffies, bh->b_flushtime))
>                     ^^^^^^
>
> You should try 2.4.8.

ok. Will upgrade in the next days.

Nico

ps: ksymoops in another email

