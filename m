Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbRGZOp3>; Thu, 26 Jul 2001 10:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbRGZOpU>; Thu, 26 Jul 2001 10:45:20 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:21637 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267999AbRGZOpL>; Thu, 26 Jul 2001 10:45:11 -0400
Date: Thu, 26 Jul 2001 16:45:16 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726164516.R17244@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <E15PlYr-0003mr-00@the-village.bc.nu> <Pine.LNX.4.33L.0107261054070.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107261054070.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Rik van Riel wrote:

> An MTA which relies on this is therefore Broken(tm).

MTAs rely on TRULY, ULTIMATELY AND DEFINITELY SYNCHRONOUS directory
updates, nothing else. And because they do so, and most systems have
them, and MTAs are portable, they choose chattr +S on Linux. And that's
a performance problem because it doesn't come for free, but also with
synchronous data updates, which are unnecessary because there is
fsync().

That's already the complete story about MTAs on Linux.

If Linux HAD a mode (it doesn't) to have just synchronous directory
updates, MTAs could stop using chattr +S and be faster.


MTAs do NOT care how the file system is internally managed, they only
rely on the rename operation having completed physically on disk before
the "my rename call has returned 0" event. They expect that with the
call returning the rename operation has completed ultimately, finally,
for good, definitely and the old file will not reappear after a crash.

(Note that the atomicity addressed in the man pages and Unix
specifications is a different one: it deals with the visibility of the
changes in the system, not with the functioning of the file system.)

That's why *BSD + softupdates is still recommended over Linux for pure
mail transfer agents by people.

This still implies the drive doesn't lie to the OS about the completion
of write requests: write cache == off.

-- 
Matthias Andree
