Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132088AbQKBOub>; Thu, 2 Nov 2000 09:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbQKBOuV>; Thu, 2 Nov 2000 09:50:21 -0500
Received: from windsormachine.com ([206.48.122.28]:39186 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S132088AbQKBOuK>; Thu, 2 Nov 2000 09:50:10 -0500
Message-ID: <3A017F1E.C699593A@windsormachine.com>
Date: Thu, 02 Nov 2000 09:50:07 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: issues with ide-tape under 2.4.x and with 2.2.x+ide patches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(originally posted to linux-tape@vger, but i figure more people read
this list <grin>)

Hi

Hoping someone can help.  I'm running Debian 2.2, tar (GNU tar)
1.13.17.  Hardware is a celeron 300, Abit BH6, but repeats itself on all
hardware i've tested(old dataexpert 8551/8661's, abit be6, some via686a
box at home, gigabyte mb's, you name it)

I'm currently running 2.4.0test10, running backups onto an IDE HP 7/14
gb drive.  Using  tar -cpvf /dev/ht0 myfiles backs up fine, no errors.

But..

promise:~# tar -tf /dev/ht0
tar: /dev/ht0: Cannot read: Input/output error
tar: At beginning of tape, quitting now
tar: Error is not recoverable: exiting now

and from dmesg:
ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0
ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0

(normal, i get those cause of the lock drive/unlock drive, which the
drive doesn't support)

If i bounce back to 2.2.17(18-18 as well), and do the exact same
command, I can read my tapes again.  But I lose support for the Promise
Ultra/66 in the machine.  So.  I go back to 2.2.17, put in the ide
patches.  I can't read my tapes again.  Take out the patches.  Tapes
restore fine.  So I'm wondering what changed with Andre's patches, and
also with 2.4.x?

I also ran into the same issues, back when i was playing with 2.2.17,
using taper 6.9b, leading me to suspect it's not tar's fault.  Just
tried dump, aside from it not agreeing with my /dev/md0 device, it backs
up fine, can't restore.

I get the same results with a Seagate IDE 10/20 drive.

ide-tape is compiled as a module, but IIRC it does the same behaviour as
built in.

Yes, the proper solution is buy a DDS-3 drive and a handful of tapes.
But my cheap employer doesn't want to spend the money to do it right.

Hoping for a solution,
Mike Dresser

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
