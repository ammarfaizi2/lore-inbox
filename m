Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSDPTOY>; Tue, 16 Apr 2002 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSDPTOX>; Tue, 16 Apr 2002 15:14:23 -0400
Received: from mailg.telia.com ([194.22.194.26]:35838 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S312983AbSDPTOW>;
	Tue, 16 Apr 2002 15:14:22 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Date: Tue, 16 Apr 2002 21:14:09 +0200
X-Mailer: KMail [version 1.4.5]
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <rxxadshj1rh.fsf@synapse.t30.physik.tu-muenchen.de> <20020416165358.E29747@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204162114.09589.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 April 2002 16.53, Andrea Arcangeli wrote:
> The reason hd is faster is because new algorithm is much better than the
> previous mainline code. Now the reason the DVDRAM hangs the machine
> more, that's probably because more ram can be marked dirty with those
> new changes (beneficial for some workload, but it stalls much more the
> fast hd, if there's one very slow blkdev in the system). You can try
> decrasing the percent of vm dirty in the system with:
>
>
>         echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush
>
>
> hope this helps,
>
>
> Right fix is different but not suitable for 2.4.
>
>
> Andrea

In an other recent thread "PROMBLEM: CD burning at 16x uses excessive CPU, 
although DMA is enabled" it was found out that writing to CD-R did not use 
DMA. This resulted in lots of wasted CPU cycles.

>From a main by Anssi Saari
> cdrdao simulate -n --speed 8 foo.cue  2.62s user 3.37s system 1% cpu 6:41
> cdrdao simulate -n --speed 12 foo.cue  2.78s user 29.91s system 12% cpu 4:31
> cdrdao simulate -n --speed 16 foo.cue  2.67s user 128.8s system 52% cpu 4:11

> But even though 50% is quite high, CPU load is not the problem as such,
> the problem is getting data to the writer fast enough. And it's not
> happening. Even a single audio track that is completely cached so that
> there is no HD access has problems. It's like somehow accessing the CD
> writer hogs the system for such long periods that there is insufficient
> time to fill the writing program's buffer.

Might this be part of the problem in this case too? Moritz please time your 
commands and use vmstat too... (time spent in interrupt while running the
idle process - does not always show up)


/RogerL

-- 
Roger Larsson
Skellefteå
Sweden


