Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131409AbRCWUEb>; Fri, 23 Mar 2001 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131411AbRCWUEO>; Fri, 23 Mar 2001 15:04:14 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:53729 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131400AbRCWUDn>; Fri, 23 Mar 2001 15:03:43 -0500
Message-Id: <l0313030eb6e156f24437@[192.168.239.101]>
In-Reply-To: <3ABB9CF2.E7715667@evision-ventures.com>
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Mar 2001 19:45:26 +0000
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It would make much sense to make the oom killer
>leave not just root processes alone but processes belonging to a UID
>lower
>then a certain value as well (500). This would be:
>
>1. Easly managable by the admin. Just let oracle/www and analogous users
>   have a UID lower then let's say 500.

That sounds vaguely sensible.  However, make it a "much less likely" rather
than an "impossible", otherwise we end up with an unkillable runaway root
process killing everything else in userland.

I'm still in favour of a failing malloc(), and I'm currently reading a bit
of source and docs to figure out where this should be done and why it isn't
done now.  So far I've found the overcommit_memory flag, which looks kinda
promising.

>1. Processes with a UID < 100 are immune to OOM killers.
>2. Processes with a UID >= 100 && < 500 are hard for the OOM killer to
>take on.
>3. Processes with a UID >= 500 are easy targets.

As I said above, "immune" can be dangerous.  "Extremely hard" would be
better terminology and behaviour.  It also helps that the current weighting
in badness() appears to leave getty processes alone, since they don't
consume much and normally have long uptimes - also I believe init would try
to restart them anyway.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


