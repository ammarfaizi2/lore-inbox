Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbULBPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbULBPnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbULBPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:43:18 -0500
Received: from www1.cdi.cz ([194.213.194.49]:61848 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S261650AbULBPm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:42:28 -0500
Date: Thu, 2 Dec 2004 16:42:08 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
Subject: sched isolcpus=1 related OOPS in 2.6.9
Message-ID: <Pine.LNX.4.33.0412021629080.493-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in Soyo dual CPU PII/350 system I experience early
OOPS (even ksymdump can't save it) during CPU#1
initialization when I use cmdline isolcpus=1 to force
only CPU#0 use (I want to use affinity to select CPU#1).
The OOPS triggers every time when I use isolcpus.

I traced the problem down into sched.c:1928 (find_busiest_group)
where group->cpu_power was zero (thus division by zero occured).
In call trace it goes swapper->schedule()->........->find_busiest_group.
Important registers there: eax=ecx=edx=0, ebx!=0.

Config and vmlinux:
http://luxik.cdi.cz/~devik/files/isolcpus-oops/

Sorry no oops yet (can't get it via ksymoops nor serial),
I can provide further info (screen photo).
Can anyone at least direct me where to look further ?
(I found no general description of group scheduling code
so that I'm lost in it).

thanks a much,

-------------------------------
    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/


