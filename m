Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVGLT5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVGLT5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVGLT5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:57:14 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:55741 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262353AbVGLT4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:56:04 -0400
Message-Id: <42D4207B.7060002@khandalf.com>
Date: Tue, 12 Jul 2005 21:56:43 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org
Subject: schedule while atomic
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: a6505e0dac1fe096b5f6466b6bf6c388
X-Transmit-Date: Tuesday, 12 Jul 2005 21:56:57 +0200
X-Message-Uid: 0000b49cec9da388000000020000000042d420890005cfa200000001000bc4ff
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@84-73-132-32.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 32700; Body=2
	Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More importantly _exactly_what_ are you using the LOCK to protect?

Short recap, spinlocks are used to serialise, ie prevent races in SMP
systems, where turning the interrupts off, on a single processor, is
NOT good enough to prevent races between interrupt-handlers and core
kernel code accessing shared-common-data eg managing a linked list
where the data structure would be mangled by shared access; thus
the lock should be taken and released _for_the_shortest_time_possible_
eg

get lock
unlink head of list
give lock

and so on, so get the lock only when you need it, and give it back as
soon as the transaction is done; also design the data-structure so that
complex, long lasting transactions are un-necessary.

see also RCU.

-- 
mit freundlichen Grüßen, Brian.


