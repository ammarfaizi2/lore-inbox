Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbTEOQIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTEOQIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:08:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264068AbTEOQIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:08:46 -0400
Date: Thu, 15 May 2003 09:20:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dean Anderson <dean@av8.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-Reply-To: <Pine.LNX.4.44.0305150957210.4983-100000@commander.av8.net>
Message-ID: <Pine.LNX.4.44.0305150913130.1841-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 May 2003, Dean Anderson wrote:
>
> Pardon me if I'm wrong, but doesn't the PAG already allow for multiple
> credentials?

Yes, but the patch did not allow for

 -  partial sharing (keys are bound to _one_ PAG, and one PAG only)

    This makes "revoke" pretty much useless, since you have a damn hard 
    time finding all the keys, since you have to copy them around instead 
    of sharing one instance.

    It also makes grouping very hard. 

 - the name space is so limited that you _have_ to consider the PAG ID's 
   temporary, which means that you have to add a whole new layer of 
   maintenance in user space.

Neither of these are apparently problems in the AFS world, because there 
is only one entity that gives out keys, so that one entity can keep track 
of every key ever allocated.

But look at the big picture. What happens when you have multiple sources 
of keys that have nothing to do with each other. How do you maintain 
sanity in that kind of world, when the numbers don't have any meaning, and 
one of the key maintainers doing a  "join" operation will throw away 
all the work that the other key maintainers did.

>	  Linus seems to be arguing for multiple PAGs, like multiple
> GIDs. But I think that functionality is really there, inside the PAG.

No it isn't. You can't do independent joins, since as it is, the code has
an "all or nothing" approach.

Again, this works in a single-use environment, where there is central 
control. It _sucks_ if you want to have a generic "bunch of keys" model.

		Linus

