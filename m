Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292091AbSBYSll>; Mon, 25 Feb 2002 13:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292092AbSBYSlc>; Mon, 25 Feb 2002 13:41:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8210 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292091AbSBYSlP>; Mon, 25 Feb 2002 13:41:15 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Feb 2002 18:06:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        mingo@elte.hu, matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202250942110.8978-100000@penguin.transmeta.com> from "Linus Torvalds" at Feb 25, 2002 09:44:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fPWS-0005hU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most common case for any fast semaphores are for _threaded_
> applications. No shared memory, no nothing.

Ok I see where you are coming from now -- that makes sense for a few cases.
POSIX thread locks have to be able to work interprocess not just between
threads though, so a full posix lock implementation couldn't be done without
being able to put these things on shared pages (hence I was coming from
the using shmfs as backing store angle).  Using a subset of shmfs also got
me resource management which happens to be nice.

The other user of these kind of fast locks is databases. Oracle for example
seems not to be a single mm threaded application.

If we are talking about being able to say "make this page semaphores" then I 
agree - the namespace is a seperate problem and up to whoever allocated the
backing store in the first place, and may well not involve a naming at all.
