Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTEONOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTEONOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:14:00 -0400
Received: from smtp2.server.rpi.edu ([128.113.2.2]:64396 "EHLO
	smtp2.server.rpi.edu") by vger.kernel.org with ESMTP
	id S264012AbTEONN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:13:56 -0400
Mime-Version: 1.0
Message-Id: <p0521061dbae942d9af19@[128.113.24.47]>
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEDODAAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCAKEDODAAA.Riley@Williams.Name>
Date: Thu, 15 May 2003 09:26:26 -0400
To: "Riley Williams" <Riley@Williams.Name>, "Russ Allbery" <rra@stanford.edu>,
       "Linus Torvalds" <torvalds@transmeta.com>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: RE: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Cc: "Jan Harkes" <jaharkes@cs.cmu.edu>, "David Howells" <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:04 AM +0100 5/15/03, Riley Williams wrote:
>Hi Russ.
>
>  > If a single process is in possession of multiple sets of
>  > credentials at the same time, how does the file system code
>  > in the kernel know which ones to use for a given operation
>  > with a network file system?
>
>I am in possession of multiple sets of credentials - my driving
>licence, my passport, my works pass, my bank cards, my store
>cards, to name just a few. How does the entity I am interacting
>with know which one they are interested in, I wonder...

You have this analogy at the wrong level.  I must admit that I
have not looked at the code which everyone is discussing, so
maybe it is the code which is confusing people who have not
dealt with a PAG before.

Yes, you (as a person) have multiple credentials, but they are
from different "cells".  A PAG can contain multiple credentials
from different AFS cells, but it can only contain one credential
from any one cell.  So, for instance, you have a driver's license,
and a dozen other cards.  However, if the police pull you over and
you hand them two different driver's license from the same state,
and those licenses have different names, and you say "I am both of
these people", then you are probably going to find yourself in
some pretty serious trouble.

The credential we're talking about here is your AFS userid (that
is the credential which is stored in a PAG --> NOTE that it is
*not* the pag itself, the pag is just a collection of credentials).
So, having multiple AFS userids from a single cell at the same
moment is exactly the same as saying a single process is two
different unix userids at the same moment.

Please realize that actually I'd love to have a way to be two
AFS userids at the same moment, and one might get some ideas
from the unix notion of setuid() vs seteuid().  But that is
the set of questions that you'd need to answer if you want a
single PAG to hold more than one token-from-a-single-cell at
the exact same moment.  Some process is going to open a single
file, and it will have to make access-checks when opening that
single file, and you want those access checks to see "two
different people" at the same moment -- even though those two
people may have explicitly different access to the file.

>Best wishes from Riley.

Best wishes in return.  Cheerio.

Unfortunately I'm late for meeting right now, so I have to run.
I should be back in, uh, about eight or nine hours.  I hate days
like this...

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
