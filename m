Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286994AbRL1UBj>; Fri, 28 Dec 2001 15:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286999AbRL1UB3>; Fri, 28 Dec 2001 15:01:29 -0500
Received: from bitmover.com ([192.132.92.2]:18339 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286994AbRL1UBK>;
	Fri, 28 Dec 2001 15:01:10 -0500
Date: Fri, 28 Dec 2001 12:01:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228120104.B4077@work.bitmover.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228042648.A7943@havoc.gtf.org> <2705.1009532564@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2705.1009532564@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Fri, Dec 28, 2001 at 08:42:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 08:42:44PM +1100, Keith Owens wrote:
> "All" I need to do is have one server process that reads the big list
> once and the other client processes talk to the server.  Much less data
> involved means faster conversion from absolute to standardized names.

Actually, if you use the mdbm code, you can have a server process which
reads the data, stashes it in the db, touchs ./i_am_done, and exits.
"client" processes do a 

	while (!exists("i_am_done")) usleep(100000);
	m = mdbm_open("db", O_RDONLY, 0, 0);
	val = mdbm_fetch_str(m, "key");
	etc.

No sockets, no back and forth, runs at mmap speed.

If you tell me what the data looks like that needs to be in the DB, i.e.,
how to get it, I'll code you up the "server" side.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
