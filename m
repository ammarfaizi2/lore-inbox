Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284135AbRL1UjU>; Fri, 28 Dec 2001 15:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287014AbRL1UjN>; Fri, 28 Dec 2001 15:39:13 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:201 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284136AbRL1Ui6>; Fri, 28 Dec 2001 15:38:58 -0500
Date: Fri, 28 Dec 2001 13:38:41 -0700
Message-Id: <200112282038.fBSKcfX11474@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Larry McVoy <lm@bitmover.com>
Cc: Keith Owens <kaos@ocs.com.au>, Legacy Fishtank <garzik@havoc.gtf.org>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
In-Reply-To: <20011228120104.B4077@work.bitmover.com>
In-Reply-To: <20011228042648.A7943@havoc.gtf.org>
	<2705.1009532564@ocs3.intra.ocs.com.au>
	<20011228120104.B4077@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> On Fri, Dec 28, 2001 at 08:42:44PM +1100, Keith Owens wrote:
> > "All" I need to do is have one server process that reads the big list
> > once and the other client processes talk to the server.  Much less data
> > involved means faster conversion from absolute to standardized names.
> 
> Actually, if you use the mdbm code, you can have a server process which
> reads the data, stashes it in the db, touchs ./i_am_done, and exits.
> "client" processes do a 
> 
> 	while (!exists("i_am_done")) usleep(100000);
> 	m = mdbm_open("db", O_RDONLY, 0, 0);
> 	val = mdbm_fetch_str(m, "key");
> 	etc.
> 
> No sockets, no back and forth, runs at mmap speed.

That sounds like a better approach. I got a bit nervous when Keith
talked about a "server process". Made me think I'm going to have to
install some daemon, or I'm going to have a pile of background
processes being left behind (no matter how careful you are, you always
end up with some "leakage" of stale processes).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
