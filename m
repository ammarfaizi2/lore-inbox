Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRKDUgd>; Sun, 4 Nov 2001 15:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKDUgX>; Sun, 4 Nov 2001 15:36:23 -0500
Received: from EUNICH.REM.CMU.EDU ([128.237.160.239]:61076 "HELO
	eunich.rem.cmu.edu") by vger.kernel.org with SMTP
	id <S278813AbRKDUgD>; Sun, 4 Nov 2001 15:36:03 -0500
Date: Sun, 04 Nov 2001 15:36:00 -0500
From: Adam Pennington <adamp@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: riel@conectiva.com.br
Subject: OOM may be being too nice to killed processes
Message-ID: <4107440000.1004906160@eunich>
X-Mailer: Mulberry/2.1.0 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may be misunderstanding this, but looking at this portion of code from 
the oom task killer... Isn't it dangerous to give a process PF_MEMALLOC and 
then only pass it a SIGTERM? My take is that the high priority bump up 
should only happen for the force_sig(SIGKILL,p).

        /*
         * We give our sacrificial lamb high priority and access to
         * all the memory it needs. That way it should be able to
         * exit() and clear out its resources quickly...
         */
        p->counter = 5 * HZ;
        p->flags |= PF_MEMALLOC;

        /* This process has hardware access, be more careful. */
        if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
                force_sig(SIGTERM, p);
        } else {
                force_sig(SIGKILL, p);
        }

Adam Pennington
