Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTKZK6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTKZK6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:58:22 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:62214 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S264141AbTKZK6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:58:20 -0500
Message-ID: <1069844249.3fc487195c258@imp.gcu.info>
Date: Wed, 26 Nov 2003 11:57:29 +0100
From: Jean Delvare <khali@linux-fr.org>
To: yuval yeret <yuval_yeret@hotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-18 size-4096 memory leaks
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuval, hi list,

> I'm seeing a constant leak in size-4096 on a machine running
> 2.4.20-18 SMP BIGMEM, which might / might not be related to the
> machine finally going out of memory and going into a hang.

I just wanted to let you know that I have been experiencing similar
leaks. So far, I wasn't enable to find where the leak was, but your
theory matches my observations:

1* On two systems running 2.4.20-2.4.22 kernels, I observed that the
free memory as reported by top was going down regularly, by blocks of 4
or 8kB at an average rate of 90kB/min. Sometimes the value would
stabilize, but I couldn't understand why. What was lost as "free"
memory
increased "buffers" from the same amount. Still that value doesn't
exceed a few dozen MB and sometimes goes does by large blocks, so I was
wondering if there was a real leak or if it was just some kind of
regular prebuffering.

2* On two other, seemingly similar systems, the memory leak wouldn't
occur. It happens that these two systems do *not* use ext3, while the
fisrt two *do* use ext3.

3* The leak isn't distribution specific. I experienced it on both a
Mandrake-shipped kernel and a self-compiled one on a Slackware system.

Your theory that it comes from the ext3 driver makes full sense. I'll
confirm that later today, by using ext2 only on one of the leaking
systems (without changing kernels of course).

The other leaking system is used as a development server. It used to
become very slow after several days. We are now restarting it every
monday and have no significant slowdown anymore. Having other things to
do, I stopped my experiments there, but could do some more now if it
can help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
