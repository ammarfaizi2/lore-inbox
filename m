Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVAQBr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVAQBr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 20:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVAQBrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 20:47:35 -0500
Received: from opersys.com ([64.40.108.71]:28676 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262664AbVAQBr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 20:47:26 -0500
Message-ID: <41EB1AEC.3000106@opersys.com>
Date: Sun, 16 Jan 2005 20:54:52 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>	 <41E8543A.8050304@am.sony.com>	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>	 <41E9EC5A.7070502@opersys.com> <1105919017.13265.275.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105919017.13265.275.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> This implies to seperate 
> 
> - infrastructure 
> - event registration
> - transport mechanism

Like I said in my first response: we can't be everything for everbody,
the requirements are just too broad. ISO tried it with OSI. Have a
look at net/* for the result.

Currently, LTT provides the first two in one piece, and relayfs
provides the third. Like I acknowledged earlier, there is room for
generalizing the transport mechanism, and I'm thinking of amending
the relayfs API proposal further and rename the modes to make them
more straight-forward:
- Managed (locking or lockless.)
- Ad-Hoc (which works like Ingo, yourself, and others have requested.)

If you really want to define layers, then there are actually four
layers:
1- hooking mechanism
2- event definition / registration
3- event management infrastructure
4- transport mechanism

LTT currently does 1, 2 & 3. Clearly, as in the mail I refered to
earlier, there is code in the kernel that already does 1, 2, 3,
and 4 in very hardwired/ad-hoc fashion and there isn't anyone asking
for them to remove it. We're offering 4 separately and are putting
LTT on top of it. If you want to get 1 & 2 separately, have a look
at kernel hooks and genevent:
http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/
http://www.listserv.shafik.org/pipermail/ltt-dev/2003-January/000408.html

We'd gladly take a serious look at using the former if it was
included, and there is work in progress being conducted on getting
the latter being the standard way for declaring LTT events instead
of using a static ltt-events.h.

Five years ago, there was a discussion about integrating GKHI into
the kernel (the kernel hooks ancestor). Have a look for yourself
as to the response to this suggestion (basically people weren't
ready to accept a generalized hooking mechanism without a defined
set of hooks, and then others didn't like the idea at all because
creating general hooks in the kernel which anybody can register
to creates legal and maintenance problems ... basically it's a
can of worms):
http://marc.theaimsgroup.com/?l=linux-kernel&m=97371908916365&w=2

There's only so much we can push into the kernel in the same time.
Not to mention that before you can be generic, you've got to have
some specific implementation to start working off on. I believe
that what we've ironed out through the discussion of the past
two days is a good basis.

There is some irony in all this. For years, we were told that we
couldn't make it into the kernel because we were perceived as
providing a kernel debugging tool, and now that we're starting
to get our things seriously reviewed we're being told that maybe
it ain't really that useful because those who want to do kernel
debugging can't use it as-is ... go figure.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
