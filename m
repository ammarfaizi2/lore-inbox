Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUKVQpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUKVQpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKVQon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:44:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:35504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbUKVQ1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:27:54 -0500
Date: Mon, 22 Nov 2004 08:27:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <je7joeywfk.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0411220823581.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
 <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org> <je7joeywfk.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Andreas Schwab wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > IMHO, this is a nice cleanup, and it also means that I can actually debug 
> > my "program from hell":
> 
> Does it also work when trying to single step over it?  I guess all bets
> are off then.

If you single-step over the "popfl", then you need to generate the
SIGTRAP's by hand too. IOW, it's _possible_ to emulate the behaviour from
within the debugger, but it gets really really nasty very quickly.

I think the nastyness in that case is at least acceptable, since if you 
single-step, you actually _see_ what is happening, and thus you have a 
chance in hell of figuring it out. Practical? No. But debuggable at least 
in theory, which it really wasn't before.

		Linus
