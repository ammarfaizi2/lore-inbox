Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132202AbRCVVY7>; Thu, 22 Mar 2001 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132209AbRCVVYu>; Thu, 22 Mar 2001 16:24:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132201AbRCVVYe>; Thu, 22 Mar 2001 16:24:34 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: stephenc@theiqgroup.com (Stephen Clouse)
Date: Thu, 22 Mar 2001 21:23:54 +0000 (GMT)
Cc: dwguest@win.tue.nl (Guest section DW),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010322142831.A929@owns.warpcore.org> from "Stephen Clouse" at Mar 22, 2001 02:28:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gCYn-0003K3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
> logically justify annihilating large-VM processes that have been running for 
> days or weeks instead of just returning ENOMEM to a process that just started 
> up.

How do you return an out of memory error to a C program that is out of memory
due to a stack growth fault. There is actually not a language construct for it

> It would be nice to give immunity to certain uids, or better yet, just turn the
> damn thing off entirely.  I've already hacked that in...errr, out.

Eventually you have to kill something or the machine deadlocks. The oom killing
doesnt kick in until that point. So its up to you how you like your errors.

One of the things that we badly need to resurrect for 2.5 is the beancounter
work which would let you reasonably do things like guaranteed Oracle a certain
amount of the machine, or restrict all the untrusted users to a total of 200Mb
hard limit between them etc

