Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136769AbRBWUiS>; Fri, 23 Feb 2001 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130333AbRBWUgu>; Fri, 23 Feb 2001 15:36:50 -0500
Received: from mail.zmailer.org ([194.252.70.162]:49671 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129975AbRBWUgo>;
	Fri, 23 Feb 2001 15:36:44 -0500
Date: Fri, 23 Feb 2001 22:36:27 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Testing EZMLM-alike tricks at this list..
Message-ID: <20010223223627.B15688@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For reasons seen earlier today, I implemented ways to produce
individual SMTP-level MAIL FROM envelope addresses per recipient.
Idea for it is partially from EZMLM, but details (location of
the devil, as saying goes) are different.

Because we really like the normal operation where each message
thru a list gets expanded into *very few* internal messages, and
thus consumes very little of local disk space, this EZMLM-alike
method won't be kept running constantly.

Consider, list gets email of 60 kB with some log, or large patch
(a few each week).  Our normal case expands it to 1-3 sub-files
for 3000+ recipients total.  Production of individual MAIL FROM-
addresses mandates that we generate, route, and deliver 3000+ copies
of the message.  (Gee momma, who blew away 180 MB diskspace ?)

Hmm..  Indeed I see a way to do things smarter, but the MAIL FROM
mungling needs to be moved to SMTP speakers, which needs complicated
signaling from list-expander thru the entire MTA to the SMTP output
subsystem...  Not quite trivial -- at least not tonight.

After I have seen that this message goes thru with appropriate
manglings, I turn things back into old mode.  List-Owner(s) will
have their tools for pathology hunting, if they choose to turn
them on.

/Matti Aarnio - co-postmaster of vger.kernel.org

PS: If you care about the coding, it is: linux-kernel-owner+RCPTMUNGLE
    where the mungle has plain characters, and '=' characters following
    with two HEX digits, just like with Quoted-Printable encoding.
    Decode  =HH  parts, and you should see your own address.
