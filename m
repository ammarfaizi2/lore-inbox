Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWIYVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWIYVnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWIYVnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:43:40 -0400
Received: from alnrmhc12.comcast.net ([204.127.225.92]:60568 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751473AbWIYVnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:43:39 -0400
Message-ID: <45184D88.1010203@comcast.net>
Date: Mon, 25 Sep 2006 17:43:36 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Swap on Fuse deadlocks?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to set up an LZOlayer swap partition:

http://north.one.pl/~kazik/pub/LZOlayer/

The layout was as such:

/tmp/swap_base  - tmpfs (run1), disk (run2)
/tmp/swap - lzolayer swap_base
/tmp/swap/swap0 - 200M swap file
/dev/loop0 - /tmp/swap/swap0 loopback

I turned on loop0, crept anywhere over 10 megs into swap and it seized
up (otherwise it was fine).  This happened in both run1 (swap on tmpfs)
and run2 (swap on disk).

The swap on tmpfs I can understand; it'll essentially loop trying to
allocate new swap, swap in and out parts of the swap file to itself, and
eventually hit a condition where it's trying to swap an area of the swap
file into itself, creating an infinite loop.

Swap on disk I don't get.  A little slow perhaps due to the LZO or zlib
compression in the middle (lzolayer lets you pick either); but a total
freeze?  What's wrong here, is lzo_fs data getting swapped out and then
not swapped in because it's needed to decompress itself?


-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
