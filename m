Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131770AbRCOQKC>; Thu, 15 Mar 2001 11:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131776AbRCOQJw>; Thu, 15 Mar 2001 11:09:52 -0500
Received: from mail.inup.com ([194.250.46.226]:14610 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S131770AbRCOQJp>;
	Thu, 15 Mar 2001 11:09:45 -0500
Date: Thu, 15 Mar 2001 17:09:10 +0100
From: christophe barbe <christophe.barbe@lineo.fr>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Mike A . Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
Message-ID: <20010315170910.C4921@pc8.inup.com>
In-Reply-To: <Pine.LNX.4.33.0103150720100.757-100000@asdf.capslock.lan> <Pine.LNX.4.21.0103151005210.4165-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0103151005210.4165-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on jeu, mar 15, 2001 at 14:08:50 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Rik, could you explain what you mean with "reclaim swap space when we run out".
In my (limited) understanding, when there's no more free memory (ram and swap space), the kernel starts to kill process (and the choice is a difficult point).
Are you proposing to add an API to reclaim swap instead of killing process ?

Other thing (certainly related) what is supposed to have changed between 2.2 and 2.4.

Thanks,
Christophe

On jeu, 15 mar 2001 14:08:50 Rik van Riel wrote:
> On Thu, 15 Mar 2001, Mike A. Harris wrote:
> 
> > Is the fact that we're supposed to use double the RAM size as
> > swap a permanent thing or a temporary annoyance that will get
> > tweaked/fixed in the future at some point during 2.4.x perhaps?
> >
> > What are the technical reasons behind this change?
> 
> The reason is that the Linux 2.4 kernel no longer reclaims swap
> space on swapin (2.2 reclaimed swap space on write access, which
> lead to fragmented swap space in lots of workloads).
> 
> This means that a lot of memory ends up "duplicated" in RAM and
> in swap.
> 
> I plan on doing some code to reclaim swap space when we run out,
> but Linus doesn't seem to like that idea very much. His argument
> (when you're OOM, you should just fail instead of limp along)
> makes a lot of sense, however, and the reclaiming of swap space
> isn't really high on my TODO list ...
> 
> OTOH, for people who have swap < RAM and use it just as a small
> overflow area, Linus' argument falls short, so I guess some time
> in the future we will have code to reclaim swap space when needed.
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
