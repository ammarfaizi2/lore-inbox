Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUHTIMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUHTIMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTIJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:09:55 -0400
Received: from imap.gmx.net ([213.165.64.20]:6318 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264278AbUHTII5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:08:57 -0400
Date: Fri, 20 Aug 2004 10:08:56 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Possible dcache BUG
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <19800.1092989336@www41.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find that memtest86 [1] does a great job of checking memory, especially
since you can boot the available ISO image.

Perhaps worth a try here?

--- [1]

http://www.memtest86.com/

---

There is still that possibility Marcelo.  Someone recommended I get 
cpuburn and memburn, and before fixing the scanf statement (it was 
broken) in memburn, I had compiled it for a 512 meg test the first 
time, and a 768 meg test the next couple of runs.

All exited with errors like this:
Passed round 133, elapsed 4827.19.
FAILED at round 134/14208927: got ff00, expected 0!!!

REREAD: ff00, ff00, ff00!!!

[root@coyote memburn]# vim memburn.c
[root@coyote memburn]# gcc -o memburn memburn.c
[root@coyote memburn]# ./memburn
Starting test with size 768 megs..

Passed round 0, elapsed 44.36.
Passed round 1, elapsed 74.13.
Passed round 2, elapsed 105.12.
FAILED at round 3/25777183: got 2b00, expected 0!!!

REREAD: 2b00, 2b00, 2b00!!!

I've now rebuilt it with a better printf format string, and its 
running over 768 megs again.  But this time the round counter is up 
to 90 and still going...

Interesting too is that memburn has now allocated a 768 meg wide block 
5 times, and still no Oops.  Over a hundred megs in swap, but its 
still running.

I lost the BUG_ON patches in fs/buffer.c, this is now 2.6.8.1-mm2 (but 
I can go back if this fails of course)

Or can I just copy that 2.6.8-rc4/fs/buffer.c file over this one?

-- 
Daniel J Blueman

NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

