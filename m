Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVCVRJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVCVRJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVCVRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:09:47 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:4111 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261449AbVCVRJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:09:36 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 22 Mar 2005 18:09:33 +0100
Message-Id: <1111511373.23155.41.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list!

(I'm new to this list so I'm sorry this mail has not correct thread id)

I have been following this forkbombing discussions and I would like to
point out a few things:

* When setting limits /etc/limits (or /etc/security/limits.conf) you
will prevent logged in users to fork too many processes. However, this
setting will not prevent a missbehaving daemon that is started from a
bootscript to fork too many processes, even if running as non root.

* Linux is very generous allowing maximum numbers of processes for
non-root users by default in comparation to other *nixes.

The kernel defaults is calculated from the amount of RAM in
kernel/fork.c with in those lines:

        max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);

        /*
         * we need to allow at least 20 threads to boot a system
         */
        if(max_threads < 20)
                max_threads = 20;

        init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
        init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

The forkbomb is mentioned already in 2001-06-18 by Rik van Riel that
suggested mempages / (16 * THREAD_SIZE / PAGE_SIZE)

http://marc.theaimsgroup.com/?l=linux-kernel&m=99283072806620&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=99617386529767&w=2

But I cannot find out why it was set back again to 8 * ... I think this
is the main reason that almost all distros are vulerable to the stupid
fork bomb attack.

Would it be an idea to set it back to:

mempages / (16 * THREAD_SIZE / PAGE_SIZE)

and let the sysadmins raise the limit with /proc/sys/kernel/threads-max
if they need more?

--
Natanael Copa


