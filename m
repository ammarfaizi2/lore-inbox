Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992690AbWJTSi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992690AbWJTSi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992693AbWJTSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:38:59 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:9630 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S2992690AbWJTSi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:38:59 -0400
Message-ID: <453917C2.8010201@candelatech.com>
Date: Fri, 20 Oct 2006 11:38:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: futex hang with rpm in 2.6.17.1-2174_FC5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a dead nfs server that was causing some programs to pause,
in particular 'yum install foo' was paused.  I kill -9'd the
yum related processes.

I fixed up the nfs server and was able to un-mount the file system.
I subsequently killed many backed up updatedb and similar processes.

Now, there are no rpm processes, but if I try 'rpm [anything]' it
hangs trying to open a futex:

open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=41390080, ...}) = 0
futex(0xb7ba178c, FUTEX_WAIT, 1, NULL <unfinished ...>

Is there any way to figure out what is causing this futex-wait?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

