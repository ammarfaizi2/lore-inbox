Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131762AbQK0CKA>; Sun, 26 Nov 2000 21:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132444AbQK0CJu>; Sun, 26 Nov 2000 21:09:50 -0500
Received: from ns1.hack.gr ([62.200.201.128]:6925 "HELO ns1.hack.gr")
        by vger.kernel.org with SMTP id <S131762AbQK0CJg>;
        Sun, 26 Nov 2000 21:09:36 -0500
Date: Mon, 27 Nov 2000 03:36:41 +0200 (EET)
From: Mastoras <mastoras@hack.gr>
To: rtl@rtlinux.org, linux-kernel@vger.kernel.org
Subject: RTlinux & Linux Question
Message-ID: <Pine.BSF.4.21.0011270332160.9529-100000@papari.hack.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

        I'm trying to use RTlinux to make a unix process wakeup 
periodicaly, in terms of "real time".

1) the unix process uses 2 system calls, one to make it self periodic, and
one to suspend its self until the next period.

2) The system call that makes the unix process periodic, creates a Rtlinux
thread, which is periodic with the same period.

3) The periodic RT linux thread, sets a flag & sends fakes IRQ0 to linux,
in order to force its scheduling as soon as possible and then suspends it
self. (i know that this advances time, but this is not the question right
now).

4) The unix process wakeups perfectely when there is no disk activity, but
when there is some disk activity ("find /" and/or "updatedb") or the
period is too small (300us) i noticed that sometimes it loses one or two
periods. This is very rare, i mean 14 loses in 5000 executions at 5ms
period.

5) The unix process isn't scheduled the appropriate time although that
every IRQ is received by linux correctly, the myprocess->counter is
initialized to a very high value (in each period) and
current->need_resched is set to 1.

6) I don't want to use PSC.


        I believe that there is somekind of race conditions during the
bottom halves or something else that i haven't though. Your help would be
very valuable, though this might not be a strictly RT linux question.

TIA
mastoras@hack.gr


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
