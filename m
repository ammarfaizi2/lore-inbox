Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131717AbRCORVR>; Thu, 15 Mar 2001 12:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131715AbRCORVH>; Thu, 15 Mar 2001 12:21:07 -0500
Received: from mail.inup.com ([194.250.46.226]:39186 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S131712AbRCORUx>;
	Thu, 15 Mar 2001 12:20:53 -0500
Date: Thu, 15 Mar 2001 18:20:19 +0100
From: christophe barbe <christophe.barbe@lineo.fr>
To: Rik van Riel <riel@conectiva.com.br>
Cc: christophe barbe <christophe.barbe@lineo.fr>,
        "Mike A . Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
Message-ID: <20010315182019.A5231@pc8.inup.com>
In-Reply-To: <20010315170910.C4921@pc8.inup.com> <Pine.LNX.4.33.0103152025340.1320-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0103152025340.1320-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on ven, mar 16, 2001 at 00:26:35 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I understand better now.
So when we swap in, the place is still reserved in swap for the next time we swap off the same memory part.
The swap is freed only when the owner terminates.
Then when we need more memory, we need to swap off but we don't use the duplicated part.
I understand that it is to avoid fragmentation but this can lead to false OOM situation (false because we have free memory in swap but it's reserved to avoid fragmentation).

Christophe

On ven, 16 mar 2001 00:26:35 Rik van Riel wrote:
> On Thu, 15 Mar 2001, christophe barbe wrote:
> 
> > Please Rik, could you explain what you mean with "reclaim swap
> > space when we run out". In my (limited) understanding, when
> > there's no more free memory (ram and swap space), the kernel
> > starts to kill process (and the choice is a difficult point).
> > Are you proposing to add an API to reclaim swap instead of
> > killing process ?
> 
> When we swap something in from swap, it is in effect "duplicated"
> in memory and swap. Freeing the swap space of these duplicates
> will mean we have, effectively, more swap space.
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
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
