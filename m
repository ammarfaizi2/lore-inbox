Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbTILC7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTILC73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:59:29 -0400
Received: from lpz9-d9ba689f.pool.mediaWays.net ([217.186.104.159]:42142 "EHLO
	router.abc") by vger.kernel.org with ESMTP id S261502AbTILC7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:59:25 -0400
Message-ID: <3F613680.6020200@baldauf.org>
Date: Fri, 12 Sep 2003 04:59:12 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--lkml--2003.09.12@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "busy" load counters
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tools like "top" show stats like

  Cpu(s):  92.1% user,   6.9% system,   0.0% nice,   1.0% idle

Unfortunately, these stats are not sufficient to determine wether the 
system is "busy". Determining wether the system is "busy" is very useful 
in case an interactive application (e.g. a shell or some shell command) 
does not respond.
Maybe it just hangs (waits for input) or does serious work (e.g. uses 
the CPU or accesses the disk). Disk access is not visible in "top". 
Depending on the machine, on disk accesses, there might be a slight or 
significant rise in the "system" portion of those stats, but this is not 
trustable.

I'd like a new stat "busy", which simply is one minus the time, when the 
system is idle but does _not_ have outstanding IO requests. Users may 
judge from this stat, wether their application waits for input or just 
needs some time. This way, they know better what to do when they get 
impatient, and they now it faster. (Yes, they can know it by looking up 
all processes of their application, strace them and check wether the 
actions observed involve just waiting and polling or maybe IO. But this 
is very tedious.)

How do you think about this? Would kernel hackers oppose such a 
"feature" for any reason?

Xuân.


