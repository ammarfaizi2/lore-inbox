Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270350AbRHMR4h>; Mon, 13 Aug 2001 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270343AbRHMR43>; Mon, 13 Aug 2001 13:56:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37902 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270347AbRHMR4M>;
	Mon, 13 Aug 2001 13:56:12 -0400
Date: Mon, 13 Aug 2001 14:55:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Roy C. Bixler" <rcb@press-gopher.uchicago.edu>
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu>
Message-ID: <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CALL FOR VOLUNTEERS
---------------------
On Mon, 13 Aug 2001, Roy C. Bixler wrote:

> I have just inadvertantly encountered a VM lockup with Linux 2.4.8.  The
> KDE kspread application couldn't handle one spreadsheet I gave it and it
> ran away consuming all memory in the system.  When I first ran into the
> trouble, my machine has 384 Meg. RAM and 184 Meg. of swap.  I tried
> 2.4.8pre8 and the lockup still occurs.  I have increased my swap to 768
> Meg. and 2.4.8 still locks up.  I tried 2.4.7 and it doesn't lockup - it
> correctly OOM kills the runaway process.

Ouch, I only did a quick test with the OOM killer and the
swap space reclaim patch and it worked in my quick test.

This means the OOM killer should be tuned, or more precisely,
the code deciding when the OOM killer kicks in should be tuned.

The code involved is very easy, so I'll explain it a bit and
ask for volunteers to tweak the code and fix the OOM behaviour.

The functions/places you may want to tweak are:

mm/vmscan.c::kswapd()
	else if (out_of_memory()) {
		oom_kill()

mm/oom_kill.c::out_of_memory()


regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

