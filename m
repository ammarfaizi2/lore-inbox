Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTKEUpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 15:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTKEUpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 15:45:30 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:48054 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263185AbTKEUpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 15:45:23 -0500
Date: Wed, 5 Nov 2003 12:45:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: BK2CVS problem
Message-ID: <20031105204522.GA11431@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somebody has modified the CVS tree on kernel.bkbits.net directly.  Dave looked
at the machine and it looked like someone may have been trying to break in and
do it.  

We've fixed the file in question, the conversion is done back here at BitMover
and after we transfer the files we check them and make sure they are OK and 
this file got flagged.  

The CVS tree is fine, you might want to remove and update exit.c to make sure
you have the current version in your tree however.

The problem file is kernel/exit.c which has a few extra entries like so:

    revision 1.121
    date: 2003/11/04 16:44:19;  author: davem;  state: Exp;  lines: +58 -0
    Oops, I worked on the  the wrong file, fixed again.
    ----------------------------
    revision 1.120
    date: 2003/11/04 16:42:00;  author: davem;  state: Exp;  lines: +0 -58
    *** empty log message ***
    ----------------------------
    revision 1.119
    date: 2003/11/04 16:22:47;  author: davem;  state: Exp;  lines: +2 -0
    *** empty log message ***
    ----------------------------
    revision 1.118
    date: 2003/10/27 19:50:03;  author: torvalds;  state: Exp;  lines: +11 -5
    Fix ZOMBIE race with self-reaping threads.

    exit_notify() used to leave a window open when a thread
    died that made the thread visible as a ZOMBIE even though
    the thread reaped itself. This closes that window by marking
    the thread DEAD within the tasklist_lock.

    (Logical change 1.14141)
    ----------------------------

Notice how the top 3 do not have the (Logical change X.YZ) at the end?
That is a pointer so you can figure out the changeset boundaries and
it is added back here during the conversion process.  The file here is
fine which leads me to believe that someone modified the file either on
kernel.bkbits.net or managed to get in through the pserver.  Dave swears
up and down that it wasn't him so if anyone can step forward and claim
responsibility that would be nice.

It's not a big deal, we catch stuff like this, but it's annoying to the 
CVS users.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
