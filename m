Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVBUT2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVBUT2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVBUT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:27:17 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:43514 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S262082AbVBUTUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:20:40 -0500
Message-ID: <421A3414.2020508@nodivisions.com>
Date: Mon, 21 Feb 2005 14:18:44 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uninterruptible sleep lockups
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Processes that get permanently stuck in "uninterruptible sleep" (the D state 
as indicated by "ps aux") are such a pain.  Of course they've always 
existed, but at least on the 3 systems that I administer, they are far more 
frequent with udev than they ever were before.  I'm constantly upgrading 
udev, hal, etc on these 3 different systems, but still not a week goes by 
that one of them doesn't need a reboot because some hardware-related process 
is hung.

The most recent one was yesterday: I had run lsusb in the morning and had no 
problems, but at the end of the day I ran it again, and after outputting 3 
lines of data, it hung, stuck in D-state.  So now I have this:

[/home/user]$ ps aux|grep D
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root        92  0.0  0.0     0    0 ?        D    Feb19   0:00 [khubd]
root       845  0.0  0.0     0    0 ?        D    Feb19   0:00 [knodemgrd_0]
root     29016  0.0  0.1  1512  592 ?        D    00:28   0:00 lsusb

It seems like this problem is always going to exist, because some hardware 
and some drivers will always be buggy.  So shouldn't we have some sort of 
watchdog higher up in the kernel, that watches for hung processes like this 
and kills them?

Don't get me wrong, I love rebooting every couple days... but I have a 
Windows system for that.

-Anthony DiSante
http://nodivisions.com/
