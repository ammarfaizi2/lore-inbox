Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWIEQGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWIEQGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWIEQGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:06:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:4877 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965102AbWIEQGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:06:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMvNKzU9A5mie5Fiv34AiaYd6ZZgWl0evlDo9yAtXOL0KeFvMZo5H/sSPmQ4lJYZ8dC14IddZ8in0ngIBHM1ikgbiMXh49mL/RuyT6qsH9hoFDOCPr7i3Mtp/QZmGiqbrVdfIGPzj205M62p/O6HfoTHPf4ji9HPs6NXXnS5+K0=
Message-ID: <86b122f40609050906u7aafe808h5002c9f15369a744@mail.gmail.com>
Date: Tue, 5 Sep 2006 18:06:18 +0200
From: "Tiemen Schut" <tschut@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel drops ethernet packets during disk writes
In-Reply-To: <86b122f40609050815v664ff217kcfc82a5c9f2772ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86b122f40609050815v664ff217kcfc82a5c9f2772ad@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: The linux kernel appears to drop raw ethernet packets if
another process is writing to disk.

Test environment: Used a p4 1.7 GHz with gigabit interface
point-to-point connection to another p4 (windows pc). This windows PC
generates raw ethernet frames holding a counter and sends 'm on to the
linux PC, at a transfer rate of 350 Mbit/s. When not writing to disk,
everything goes quite fine. I can check the counters at the linux
side, and will notice a minimal packet loss (<  0.001 % or so).

However, for my application I want to write each and every frame to
disk. So, I created a second app, and through a fifo the receiver app
and the disk writer app communicate. Now I'm losing like 80% of my
packets :o Reducing the throughput on the network doesn't really help
(though it does help a little).

Note: I tried everything in the same app first, but my guess was that
the write operation delayed the app, so I decided to put everything in
two apps to give the scheduler some work ;) Didn't work though.

My guess would be that the kernel drops the packets because the write
operation takes to long (how long can it take, it's just a stupid 1512
bytes frame). Anyway, I tried to enlarge
.sys.net.core.netdev_max_backlog, but that didn't do the trick.

This problem occures on both 2.6.13 and 2.4.idontremember.

It kinda sucks, what's the use of receiving traffic if you can't write
it to disk?

I'm sending the packets using the winpcap library, and I'm receiving
the packets using the pcap library.

Any help would be _greatly_ appreciated, and if neccessary, please ask
for additional information/used software/test results/etc.

Tiemen Schut


PS: Personal CC's are okay with me, but if it's to much trouble never mind :)
