Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUDVR0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUDVR0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUDVR0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:26:14 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:41405 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S264588AbUDVR0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:26:05 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Rik van Riel <riel@redhat.com>, Miles Bader <miles@gnu.org>
Subject: Re: vger.kernel.org is listed by spamcop
Date: Thu, 22 Apr 2004 19:02:41 +0300
User-Agent: KMail/1.5
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Jan De Luyck <lkml@kcore.org>,
       <linux-kernel@vger.kernel.org>, <postmaster@vger.kernel.org>
References: <Pine.LNX.4.44.0404212129510.17081-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404212129510.17081-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404221902.41419.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 04:30, Rik van Riel wrote:
> On 22 Apr 2004, Miles Bader wrote:
> > Rik van Riel <riel@redhat.com> writes:
> > > I'm certain than vger got listed on spamcop due to linux-kernel
> > > subscribers reporting to spamcop some of the spam that leaked
> > > onto lkml, through Matti's strict filters.
> >
> > Does that mean that spamcop does no verification of user reports?
>
> Indeed.

A part of the fun begins from spamcop not even trying to maintain a list 
of open relays. Spamcop attempts to maintain a list of spam sources, 
where an IP gets listed if X number of spams have been reported from IP 
Y within time period Z.
Based on my by no means complete understanding of all the issues 
involved, the problem begins with the parser, there's no way to 
distinguish legitimate mailing list servers from a spammer's mailing 
list server without user intervention. When parsing the Received 
headers, (fx. the one in the mail I'm replying to), the parser sees 
that mx1.redhat.com threw it to vger, which for some reason passed it 
on to my ISP's mail server. The spamcop engine does not know why vger 
is relaying mail from redhat to my ISP, and checking the MX records 
reveals no justification for vger to be doing this, thus, the only 
thing it can reasonably trust, is my ISP's incoming smtp server, which 
reported it received the mail from vger. The scenario"ISP1 -> ISP2" it 
might still understand, but not this "ISP1 -> ???? -> ISP2" thing.

This is why spamcop users should not report spam sent to mailing lists.

> > I was under the impression that it's fairly easy to automatically
> > check whether a particular host is an open-relay or not, so it
> > would seem kind of irresponsible for spamcop not to do this if some
> > people are relying on their lists to do blocking (even if there's a
> > disclaimer saying not to do that, clearly people are ignorant or
> > dumb, so why not play it safe?).
>
> Spamcop isn't doing any vulnerability checks I'm aware of.

There are numerous RBL's which specifically list open relays (such as 
Blitzed's OPM), and spamcop is NOT one of them. Mail administrators 
need to understand that.
Supposedly, most of the spam traffic today goes through zombied machines 
running that Other OS, on consumer broadband connections. You can throw 
any amount of open proxy / relay checking at those spam sources, and 
find nothing. There are lists which try to list these exploited boxen 
as well (such as the XBL), but spamcop is not doing that, either, and 
mail administrators need to understand that. 

The advantage of spamcop is response-time. A spam source gets quickly 
listed, and falls off the list if spam is no longer reported from that 
source, based on a fully automated reporting system. The disadvantage 
is that it's only as reliable as its weakest link: the human factor, 
its users.
Anyone using spamcop RBL for outright blocking for an entire ISP has no 
clue about what they're doing. Using any single blacklist for outright 
blocking is a bit daft, IMO.

As a side-note, for each reported spam, spamcop tries to find a best 
contact email address in attempt to contact the administrator of what 
it thinks is the spam source, with links to pages with copies of the 
spam in question and output from the spamcop parser engine... I suspect 
spamcop sent this a few levels upstream of postmaster@vger.kernel.org, 
though :(

