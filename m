Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbUKTQ2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbUKTQ2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbUKTQ2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:28:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25765 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263029AbUKTQ0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:26:43 -0500
Date: Sat, 20 Nov 2004 17:26:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
In-Reply-To: <419F6DEB.6030606@colorfullife.com>
Message-ID: <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr>
References: <419F6DEB.6030606@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Jan,
>
>>I would like to also lock Buffer_lock around BufRP != BufWP, but don't see a
>>way on how to accomplish this.

>This is not a problem: You compare BufRP and BufWP twice: once within
>wait_event_interruptible (without locking) and again a second test in
>your uif_read function with locking.
>You are right that the test within wait_event_interruptible is
>optimistic: a concurrent uif_read could read the new data before the
>initial uif_read has a chance to acquire the BufferLock. But it doesn't
>matter: AFAICS the test is optimistic, it can't happen that BufRP and WP
>are actually different and wait_event sleeps. And the external loop
>within uif_read() just loops if the race that you describe happened.

Yay, I see now. It takes a fair amount of looking behind the scene to get the
idea. (It's just copy-and-paste from an O'reilly book with a few
modifications.)
Yes, there is always only one way from any insn you look at, which does not
require a lock.

>Btw, could you post a link to the complete driver when asking questions?

http://ttyrpld.sf.net/ -- "kernel-2.6/rpldev.c" in the tarball.

>For example the use of down_interruptible() looks wrong to me, I'd use
>plain down().

I'd like to be able to hit Ctrl+C (in the userspace application) whenever
possible. If that's not a reason, blame the book
http://www.xml.com/ldd/chapter/book/ch03.html#t8 ("the read method" a further
down below)

BTW, the complete book is at http://www.xml.com/ldd/chapter/book/index.html


Thanks,
Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
