Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271289AbRHZPHg>; Sun, 26 Aug 2001 11:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRHZPH0>; Sun, 26 Aug 2001 11:07:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40967 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271289AbRHZPHS>;
	Sun, 26 Aug 2001 11:07:18 -0400
Date: Sun, 26 Aug 2001 12:06:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826165517.D22677@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108261158470.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Marc A. Lehmann wrote:
> On Sun, Aug 26, 2001 at 10:48:05AM -0300, Rik van Riel <riel@conectiva.com.br> wrote:

> > This paper convinced me that doing just elevator sorting
> > is never enough ;)
>
> It must be enough, unfortunately ;)

Then you'll need to change the physical structure of
your disks to eliminate seek time. ;)

> > One thing you could do, in recent -ac kernels, is make the
> > maximum readahead size smaller by lowering the value in
> > /proc/sys/vm/max-readahead
>
> Yes, this indeed helps slightly (with the ac9 kernel I don't see the
> massive thrashing going on with the linus' ones anyway). Now the only
> thing left would be to be able to to that per access

Automatic scaling of readahead window and possibly more agressive
drop-behind could help your system load.

Could you give me a few (heavy load) lines of 'vmstat 5' output
so we have an idea of what kind of system load we're facing, and
the active/inactive memory lines from /proc/meminfo ?

> It seems that I can in excess of 4MB/s (sometimes 5MB/s) when using
> large bounce-buffers and disabling read-ahead completely under ac9. So
> something with the kernel read-ahead *is* going wrong, as the default
> read-ahead of 31 (pages? 124k) is very similar to my current
> read-buffer size of 128k. And enabling read-ahead and decreasing the
> user-space buffers gives abysmal performance again.

Indeed, something is going wrong ;)

Lets find out exactly what so we can iron out this bug
properly.

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

