Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUENX2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUENX2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUENXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:25:35 -0400
Received: from [209.195.52.120] ([209.195.52.120]:54706 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S264543AbUENXYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:24:51 -0400
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 14 May 2004 16:24:43 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: zombies with AMD64 and 32 bit userspace with 2.6
In-Reply-To: <1084576043923@kroah.com>
Message-ID: <Pine.LNX.4.58.0405141615220.27007@dlang.diginsite.com>
References: <1084576043923@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box I am testing in my lab which is a dual opteron with a
complete 32 bit userspace (debian based) with a 64 bit kernel. when
running a stress test with a highly forking workload I am running into a
situation where it generates a lot of zombies

the test is a simple forking proxy that receives connections from one
machine (running apache benchmark) and forwards them to anothr machine
(running apache). for <~30,000 requests the machine keeps up with no
problem (apache is the bottlneck here at ~3500 requests/sec), but if I try
to do a test with more then about 30,000 requests in it the box starts to
generate zombie processes (eventually running into the max processes limit
and stopping)

the smaller tests leave no zombies at all and can be run multiple times
without a problem (although I have not run them back to back, so there is
a substantial bit of time between tests)

I have been able to duplicate this with the 2.6.4 and 2.6.6 kernels.

running the exact same test (same binaries except for the kernel) on a
dual athlon box has no problems (the dual athlon box becomes the
bottleneck at ~2500 connections/sec) and has survived 10,000,000
connection tests.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
