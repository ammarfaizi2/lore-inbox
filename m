Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288641AbSADOYw>; Fri, 4 Jan 2002 09:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288646AbSADOYc>; Fri, 4 Jan 2002 09:24:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:48399 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288641AbSADOY3>;
	Fri, 4 Jan 2002 09:24:29 -0500
Date: Fri, 4 Jan 2002 15:24:09 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: vanl@megsinet.net, andihartmann@freenet.de, riel@conectiva.com.br,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020104152409.0fd8a101.skraw@ithnet.com>
In-Reply-To: <20020104151438.M1561@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com>
	<3C2F04F6.7030700@athlon.maya.org>
	<3C309CDC.DEA9960A@megsinet.net>
	<20011231185350.1ca25281.skraw@ithnet.com>
	<3C351012.9B4D4D6@megsinet.net>
	<20020104151438.M1561@athlon.random>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 15:14:38 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> On Fri, Jan 04, 2002 at 01:33:21PM +0100, Stephan von Krawczynski wrote:
> > On Thu, 03 Jan 2002 20:14:42 -0600
> > "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> > 
> > And there is another difference here:
> > 
> > +       if (max_mapped <= 0 && nr_pages > 0)
> > +               swap_out(priority, gfp_mask, classzone);
> > +
> > 
> > It sounds reasonable _not_ to swap in case of success (nr_pages == 0).
> > To me this looks pretty interesting. Is something like this already in -aa?
> > This patch may be worth applying in 2.4. It is small and looks like the
right> > thing to do.
> 
> -aa swapout as soon as max_mapped hits zero. So it basically does it
> internally (i.e. way more times) and so it will most certainly be able
> to sustain an higher swap transfer rate. You can check with the mtest01
> -w test from ltp.

Hm, but do you think this is really good in overall performance, especially the
frequent cases where no swap should be needed _at all_ to do a successful
shrinking? And - as can be viewed in Martins tests - if you have no swap at
all, you seem to trigger OOM earlier through the short path exit in shrink,
which is a obvious nono. I would state it wrong to fix the oom-killer for this
case, because it should not be reached at all.

?

Regards,
Stephan


