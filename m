Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWCAEKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWCAEKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCAEKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:10:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39303 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751100AbWCAEKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:10:46 -0500
Date: Tue, 28 Feb 2006 20:10:40 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228201040.34a1e8f5.pj@sgi.com>
In-Reply-To: <20060228194525.0faebaaa.pj@sgi.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With these three patches:
    proc-dont-lock-task_structs-indefinitely.patch
    proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
    proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

the command:

    /bin/fuser -n tcp 5553

kills my kernel very quickly.  This latest time it died with
the swap command failure I mentioned before.  And this command
shows the permission problem (2) that I reported to Eric.

The full output, from command entry to death, is as
follows.  The second '#', near the end, is my shell
prompt returning to me, microseconds before death.

# /bin/fuser -n tcp 5553
Cannot stat file /proc/1675/fd/3: Permission denied
Cannot stat file /proc/1675/fd/4: Permission denied
Cannot stat file /proc/1675/fd/5: Permission denied
Cannot stat file /proc/1675/fd/6: Permission denied
Cannot stat file /proc/1675/fd/7: Permission denied
Cannot stat file /proc/2852/fd/6: Permission denied
Cannot stat file /proc/2852/fd/7: Permission denied
Cannot stat file /proc/2853/fd/6: Permission denied
Cannot stat file /proc/2853/fd/7: Permission denied
Cannot stat file /proc/2854/fd/6: Permission denied
Cannot stat file /proc/2854/fd/7: Permission denied
Cannot stat file /proc/2855/fd/6: Permission denied
Cannot stat file /proc/2855/fd/7: Permission denied
Cannot stat file /proc/2866/fd/0: Permission denied
Cannot stat file /proc/2866/fd/1: Permission denied
Cannot stat file /proc/2867/fd/0: Permission denied
Cannot stat file /proc/2867/fd/1: Permission denied
Cannot stat file /proc/2868/fd/0: Permission denied
Cannot stat file /proc/2868/fd/1: Permission denied
Cannot stat file /proc/2869/fd/0: Permission denied
Cannot stat file /proc/2869/fd/1: Permission denied
Cannot stat file /proc/2897/fd/3: Permission denied
Cannot stat file /proc/2902/fd/4: Permission denied
Cannot stat file /proc/2911/fd/3: Permission denied
Cannot stat file /proc/2914/fd/1: Permission denied
Cannot stat file /proc/2921/fd/3: Permission denied
Cannot stat file /proc/2921/fd/5: Permission denied
Cannot stat file /proc/2921/fd/6: Permission denied
Cannot stat file /proc/3512/fd/3: Permission denied
Cannot stat file /proc/3512/fd/4: Permission denied
Cannot stat file /proc/3512/fd/6: Permission denied
Cannot stat file /proc/3512/fd/7: Permission denied
Cannot stat file /proc/3537/fd/3: Permission denied
Cannot stat file /proc/3537/fd/4: Permission denied
Cannot stat file /proc/3645/fd/3: Permission denied
Cannot stat file /proc/3676/fd/4: Permission denied
Cannot stat file /proc/3676/fd/5: Permission denied
Cannot stat file /proc/3676/fd/7: Permission denied
Cannot stat file /proc/3680/fd/0: Permission denied
Cannot stat file /proc/3680/fd/2: Permission denied
Cannot stat file /proc/3680/fd/3: Permission denied
Cannot stat file /proc/3680/fd/4: Permission denied
Cannot stat file /proc/3700/fd/3: Permission denied
Cannot stat file /proc/3735/fd/1: Permission denied
Cannot stat file /proc/3735/fd/2: Permission denied
Cannot stat file /proc/3735/fd/4: Permission denied
Cannot stat file /proc/3735/fd/5: Permission denied
Cannot stat file /proc/3735/fd/7: Permission denied
Cannot stat file /proc/3946/fd/3: Permission denied
Cannot stat file /proc/3946/fd/4: Permission denied
Cannot stat file /proc/3946/fd/5: Permission denied
Cannot stat file /proc/3946/fd/6: Permission denied
Cannot stat file /proc/3948/fd/3: Permission denied
Cannot stat file /proc/3948/fd/4: Permission denied
Cannot stat file /proc/3948/fd/5: Permission denied
Cannot stat file /proc/3948/fd/7: Permission denied
Cannot stat file /proc/3948/fd/8: Permission denied
Cannot stat file /proc/3948/fd/9: Permission denied
Cannot stat file /proc/3948/fd/10: Permission denied
Cannot stat file /proc/3948/fd/11: Permission denied
Cannot stat file /proc/3948/fd/12: Permission denied
Cannot stat file /proc/3948/fd/13: Permission denied
Cannot stat file /proc/3975/fd/0: Permission denied
Cannot stat file /proc/3984/fd/9: Permission denied
Cannot stat file /proc/3984/fd/10: Permission denied
Cannot stat file /proc/4020/fd/4: Permission denied
# swapper[0]: bugcheck! 0 [1]
Modules linked in:

Pid: 0, CPU 3, comm:              swapper
psr : 0000101008026038 ifs : 8000000000000288 ip  : [<a000000100106a10>]    Not tainted

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
