Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbULPROW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbULPROW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULPRLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:11:32 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:8149 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261941AbULPRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:10:41 -0500
Message-ID: <41C1C187.2040202@nortelnetworks.com>
Date: Thu, 16 Dec 2004 11:10:31 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: slow OOM killing with 2.6.9?
References: <41C065A2.4040504@nortelnetworks.com> <41C1777A.3080105@tebibyte.org>
In-Reply-To: <41C1777A.3080105@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:

> The OOM Killer is working properly again in 2.6.10-rc2-mm4. Could you 
> try that kernel and report whether it fixed your problems too?

I had to turn off HIGHMEM support (see other response) but I mangaged to 
reproduce it.

My testcase forks a single child, then both parent and child proceed to allocate 
and write to 3/5 of total system memory.  Swap is disabled.  There is barely 
anything else running, so only one hog should have to be killed.

With 2.6.10-rc2-mm4, I got the following results:


running as root:
trial 1:
both memory hogs as well as the xterm in which they were started were killed. 
In the process, the system was frozen for 14 seconds.

trial 2: both memory hogs killed, system frozen for 9 seconds

trial 3: both memory hogs as well as the xterm in which they were started were 
killed., system was frozen for 15 seconds.

running as regular user:
trial 1:
one hog killed, system hung for 8 seconds

trial 2:
both hogs killed, timing window killed, system hung for at least 15 seconds


Doesn't look like the oom killer is entirely fixed.

Chris
