Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTIHXj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTIHXj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:39:26 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:7080
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263758AbTIHXjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:39:24 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16221.4899.461679.378288@wombat.chubb.wattle.id.au>
Date: Tue, 9 Sep 2003 09:39:15 +1000
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Newsgroups: mail.linux-kernel
In-Reply-To: <bjimht$9dr$1@gatekeeper.tmr.com>
References: <20030903040327.GA10257@work.bitmover.com>
	<3F55907B.1030700@cyberone.com.au>
	<27780000.1062602622@[10.10.2.4]>
	<20030903153901.GB5769@work.bitmover.com>
	<bjimht$9dr$1@gatekeeper.tmr.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "bill" == bill davidsen <davidsen@tmr.com> writes:

> In article <20030903153901.GB5769@work.bitmover.com>, Larry
> McVoy <lm@bitmover.com> wrote:

Larry> It's really easy to claim that scalability isn't the problem.
Larry> Scaling changes in general cause very minute differences, it's
Larry> just that there are a lot of them.  There is constant pressure
Larry> to scale further and people think it's cool.  You can argue
Larry> you all you want that scaling done right isn't a problem but
Larry> nobody has ever managed to do it right.  I know it's 
Larry> politically incorrect to say this group won't either but there
Larry> is no evidence that they will.

bill> I think that if the problem of a single scheduler which is
bill> "best" at everything proves out of reach, perhaps in 2.7 a
bill> modular scheduler will appear, which will allow the user to
bill> select the Nick+Con+Ingo responsiveness, or the default pretty
bill> good at everything, or the 4kbit affinity mask NUMA on steroids
bill> solution.

Well, as I see it it's not processor but memory scalability that's the
problem right now.  Memories are getting larger (and for NUMA systems,
sparser), and the current linux solutions don't scale particularly
well --- particularly when, for architectures like PPC or IA64, you
need two copies in different formats, one for the hardware to look up,
and one for the OS.

I *do* think that pluggable schedulers are a good idea --- I'd like to
introduce something like the scheduler class mechanism that SVr4 has
(except that I've seen that code, and don't want to get sued by SCO)
to allow different processes to be in different classes in a cleaner
manner than the current FIFO or RR vs OTHER classes.  We should be
able to introduce isochronous, gang, lottery or fairshare schedulers
(etc) at runtime, and then tie processes severally and indivdually to
those schedulers, with a well defined idea of what happens when
scheduler priorities overlap, and well defined APIs to adjust
scheduler parameters.  However, this will require more major
infrastructure changes, and a better separation of dispatcher from
scheduler than in the current one-size-fits-all scheduler.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.


