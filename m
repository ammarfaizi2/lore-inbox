Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbQJaAxH>; Mon, 30 Oct 2000 19:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129993AbQJaAw5>; Mon, 30 Oct 2000 19:52:57 -0500
Received: from duracef.shout.net ([204.253.184.12]:63505 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S129969AbQJaAwq>; Mon, 30 Oct 2000 19:52:46 -0500
Date: Mon, 30 Oct 2000 18:52:08 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200010310052.SAA21366@duracef.shout.net>
To: hch@ns.caldera.de, torvalds@transmeta.com
Subject: Re: test10-pre7
Cc: jgarzik@mandrakesoft.com, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me see if I have all this straight:

(1) Change Rules.make to use "new style" variables as its native form.
    (1A) Add a "Compat.make" for old style Makefiles, and
    (1B) Continue to convert all the remaining old style Makefiles.

(2) Go with the "export-objs" style of declaring source files that need
    to be run through genksyms.  Files never get built just because they
    are in $(export-objs); $(export-objs) just determines who gets
    processed by genksyms at compile time.

(3) No LINK_FIRST / LINK_LAST.  Whatever is in the Makefile gets linked
    in that order.  We won't use $(sort ...) to eliminate duplicates
    (we will continue to handle them another way).

(4) When a multi is built into the resident kernel, the whole multi goes in,
    with no splitting into component parts.

Is that your plan, Linus?

I disagree with (3) because I think that initialization order requirements
should be spelled out and documented.  But I accept it.

Historical note on (4): as Keith said, I had to split up the multi's in
order to get the components into the OX_OBJS list.  But with a more
thorough implementation of (2), this becomes unnecessary.

Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
