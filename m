Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWB1RCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWB1RCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWB1RCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:02:25 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:48794 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751068AbWB1RCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:02:24 -0500
Message-ID: <44048211.2070906@comcast.net>
Date: Tue, 28 Feb 2006 12:02:09 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net> <4403C30A.6070704@comcast.net> <Pine.LNX.4.63.0602281123410.15105@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0602281123410.15105@cuia.boston.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Rik van Riel wrote:
> On Mon, 27 Feb 2006, John Richard Moser wrote:
> 
>> Hmm, I can't see where the kernel checks to see which pages are least
>> used. . . . anyone good with the VM can point me in the right direction?
> 
> Not completely written yet, but take a look at:
> 
> 	http://linux-mm.org/PageOutKswapd
> 

Wow nice.  Confusing, but nice.

I'm currently peeking around vmscan.c, though I can't seem to tell quite
how the kernel knows what's hot and cold.  I heard somewhere that when a
process doesn't use memory for like 5 days, the kernel knows better to
swap that instead of something it used 10 minutes ago.  I'm not sure how
though, I don't think the kernel debugs memory access.  My best guess is
when the page falls out of process TLB, the kernel is notified about it
and keeps these in order; and when it's faulted back into TLB, the
kernel is notified and moves it up to more recently used.  Of course,
this would mean the kernel never invalidates stuff in the process' TLB
(working set), which doesn't make sense.  Either way the inner workings
don't matter much to me; what I'm worried about is where it accounts for
this and more importantly what APIs it provides to query this information.

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBIIQhDd4aOud5P8RAnxaAKCOreOPFYNokQzECFPpSAOCbzJsQgCggWav
AIZ+oU4AMRkdMGjp62xdqP0=
=TkEA
-----END PGP SIGNATURE-----
