Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbQLVSYo>; Fri, 22 Dec 2000 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbQLVSYe>; Fri, 22 Dec 2000 13:24:34 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:25873 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S130879AbQLVSYS>; Fri, 22 Dec 2000 13:24:18 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2.19pre3
Date: 22 Dec 2000 17:54:06 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <9204fu$ghe$3@enterprise.cistron.net>
In-Reply-To: <20001222173228.A1424@elektroni.ee.tut.fi> <Pine.LNX.3.95.1001222104908.791A-100000@chaos.analogic.com>
X-Trace: enterprise.cistron.net 977507646 16942 195.64.65.67 (22 Dec 2000 17:54:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1001222104908.791A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>alias kwhich='type -path' in ~./bashrc should fix.

Hmm? Smells like a stupid bug to me. The script is called as:

CCFOUND :=$(shell $(CONFIG_SHELL) scripts/kwhich kgcc gcc272 cc gcc)

So how can bash ever decide to replace scripts/kwhich (OBVIOUSLY
a call to a non-internal command) with an alias or builtin?

Are you sure this is in fact the bug?

Couldn't it be the games with IFS in the scripts/kwhich script?

Try this patch:

--- linux-2.2.19pre3/scripts/kwhich.orig	Tue Dec 19 23:16:52 2000
+++ linux-2.2.19pre3/scripts/kwhich	Fri Dec 22 19:02:47 2000
@@ -7,7 +7,7 @@
         exit 1
 fi
 
-IFS=:
+IFS=":$IFS"
 for cmd in $*
 do
         for path in $PATH


Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
