Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSHBNnS>; Fri, 2 Aug 2002 09:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSHBNnS>; Fri, 2 Aug 2002 09:43:18 -0400
Received: from daimi.au.dk ([130.225.16.1]:20153 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S313477AbSHBNnS>;
	Fri, 2 Aug 2002 09:43:18 -0400
Message-ID: <3D4A8D45.49226E2B@daimi.au.dk>
Date: Fri, 02 Aug 2002 15:46:45 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Race condition?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a race condition in this piece of code from do_fork in
linux/kernel/fork.c? I cannot see what prevents two processes
from calling this at the same time and both successfully fork
even though the user had only one process left.

        if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur
                      && !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
                goto bad_fork_free;

        atomic_inc(&p->user->__count);
        atomic_inc(&p->user->processes);

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
