Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289384AbSAODVl>; Mon, 14 Jan 2002 22:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSAODVb>; Mon, 14 Jan 2002 22:21:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289384AbSAODV1>;
	Mon, 14 Jan 2002 22:21:27 -0500
Date: Tue, 15 Jan 2002 03:21:26 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk> <20020112133122.I1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020112133122.I1482@inspiron.school.suse.de>; from andrea@suse.de on Sat, Jan 12, 2002 at 01:31:22PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:31:22PM +0100, Andrea Arcangeli wrote:
> On Wed, Jan 09, 2002 at 07:56:07PM +0000, Joel Becker wrote:
> > min(I/O alignment, s_blocksize) is used as the effective
> > blocksize.  eg:
> > 
> > I/O alignment	s_blocksize	final blocksize
> > 8192		4096		4096
> > 4096		4096		4096
> > 512		4096		512
> 
> this falls in the same risky category of the vary-I/O patch from Badari
> (check the discussion on l-k) for rawio, so to make it safe it also will

	How so?  All I/O is at the computed blocksize.  In every
request, the size of each I/O in the kiovec is the same.  The
computation is done upon entrance to generic_file_direct_IO, and it is
kept that way.  You don't have bh[0]->b_size = 512; bh[1]->b_size =
4096;
	Hmm, maybe you mean things like that rumoured 3-ware issue.  I
dunno.  I do know that this code seems to work just fine with ide,
aha7xxx, and the qlogic driver.  Certain software really wants to use
O_DIRECT, and they align I/O on 512byte boundaries.  So any scheme that
fails this when it doesn't have to is a problem.

> aligned I/O, but still large I/O) So I suggest you to check Badari's
> stuff and the thread on l-k and to make a new patch incremental with his

	I've added myself to that thread as well.

Joel

-- 

"Vote early and vote often." 
        - Al Capone

			http://www.jlbec.org/
			jlbec@evilplan.org
