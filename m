Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRECTDJ>; Thu, 3 May 2001 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRECTC7>; Thu, 3 May 2001 15:02:59 -0400
Received: from alpo.casc.com ([152.148.10.6]:32159 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S132395AbRECTCq>;
	Thu, 3 May 2001 15:02:46 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.40883.552559.174275@gargle.gargle.HOWL>
Date: Thu, 3 May 2001 14:13:07 -0400
To: esr@thyrsus.com
Cc: David Mansfield <lkml@dm.ultramaster.com>,
        Alexander Viro <viro@math.psu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503115848.F31960@thyrsus.com>
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de>
	<Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu>
	<20010503054349.C28728@thyrsus.com>
	<3AF17135.F52C889D@dm.ultramaster.com>
	<20010503115848.F31960@thyrsus.com>
X-Mailer: VM 6.90 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric> David Mansfield <lkml@dm.ultramaster.com>:
>> If so, given the above ruleset involving symbols A, B and C, and given
>> that such a ruleset is violated for some reason (you don't even care
>> why), use the following approach:
>> 
>> set C to 'n' -> are we ok?
>> set B to 'n' -> are we ok?
>> set A to 'n' -> are we ok?
>> 
>> Inform the user of each change.  In a massively broken configuration you
>> could end up with a lot of stuff set to 'n' ultimately, but I think that
>> this generally would just end up shutting off troublesome configuration
>> settings, and requiring that the user then reset them manually.

Eric> Actually this is the best idea I've seen yet, because the single
Eric> "known-good" configuration is almost all n values.  

Darnit!  Someone else beat me to this idea, though David did a much
better job of describing the solution here.  *grin*

What Eric has been arguing about with the 3^n problem of finding the
correct constrained state is interesting (and mathematically over my
head), I wanted to point out that our real world setting here has some
easy to do fixes, but just turning stuff off (and telling the user you
did so!) and then letting the user turn stuff back on.

Keith Owens also had a good comment on how to deal with an broken
config.

A) go interactive!  Don't dump the user to vi, just put them in and
tell them to fix their constraints themselves.  This was my original
beef with CML2, it didn't continue interactive so I could fix the
problem, I had to hack it by hand.

For the non-interactive, setting stuff to 'n' should prune away
problem states by the *ton* drastically simplifying the set of
constraints to be satisfied.

Thanks for everyone chipping in here, it's been a interesting
discussion to follow, and I'm hoping to see that we can prune back the
problem easily enough to handle most cases of broken configs by
working towards the known good config of mostly 'n' answers.

John
