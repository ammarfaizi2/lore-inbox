Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRCWX14>; Fri, 23 Mar 2001 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRCWX1r>; Fri, 23 Mar 2001 18:27:47 -0500
Received: from ash.lnxi.com ([207.88.130.242]:13813 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S131508AbRCWX1d>;
	Fri, 23 Mar 2001 18:27:33 -0500
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu> <l0313030eb6e156f24437@[192.168.239.101]>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 23 Mar 2001 16:26:31 -0700
In-Reply-To: Jonathan Morton's message of "Fri, 23 Mar 2001 19:45:26 +0000"
Message-ID: <m3snk4gj88.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton <chromi@cyberspace.org> writes:

> >It would make much sense to make the oom killer
> >leave not just root processes alone but processes belonging to a UID
> >lower
> >then a certain value as well (500). This would be:
> >
> >1. Easly managable by the admin. Just let oracle/www and analogous users
> >   have a UID lower then let's say 500.
> 
> That sounds vaguely sensible.  However, make it a "much less likely" rather
> than an "impossible", otherwise we end up with an unkillable runaway root
> process killing everything else in userland.
> 
> I'm still in favour of a failing malloc(), and I'm currently reading a bit
> of source and docs to figure out where this should be done and why it isn't
> done now.  So far I've found the overcommit_memory flag, which looks kinda
> promising.

Lookup mlock & mlock_all they will handle the single process case.

Of course if you OOM you still have problems but that should make
them much harder to trigger.

Eric
