Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131845AbRCZPow>; Mon, 26 Mar 2001 10:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRCZPon>; Mon, 26 Mar 2001 10:44:43 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:12818 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S131845AbRCZPod>; Mon, 26 Mar 2001 10:44:33 -0500
Message-ID: <3ABF63D3.D0C8558@linuxjedi.org>
Date: Mon, 26 Mar 2001 10:44:19 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/vm/freepages read-only?!?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to do some vm tuning for diskless (and therefore swapless)
devices.  (I'm working on a distro that tftp's packages and runs
entirely in RAM)

Even on an X terminal with 64MB RAM, badly behaved apps can use lots of
ram in the Xserver, and what I'm seeing is a hang.  The box is usually
still pingable, just unresponsive.  I'm using cramfs pretty heavily, and
I think what's occuring is that the terminal gets too low on freepages,
and since pages used by X can't be swapped out, the box starts thrashing
the vm and is unable to get pages to uncompress into.

My first thought was echo (bigger numbers) > /proc/sys/vm/freepages -
but lo! - it's not writable anymore.  I found comments in page_alloc.c
indicating it had to be read-only, but it seems it's only a safety
precaution.  Something along the lines of values too small being 'bad
bad'.


help?
	David
-- 
David L. Parsley
Network Administrator
Roanoke College
