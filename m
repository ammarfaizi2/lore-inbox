Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272695AbRILIVl>; Wed, 12 Sep 2001 04:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272703AbRILIVb>; Wed, 12 Sep 2001 04:21:31 -0400
Received: from camus.xss.co.at ([194.152.162.19]:47886 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S272695AbRILIV2>;
	Wed, 12 Sep 2001 04:21:28 -0400
Message-ID: <3B9F1B1A.2044CF1A@xss.co.at>
Date: Wed, 12 Sep 2001 10:21:46 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20pre10
In-Reply-To: <E15gwc5-0003VR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:
> 
> If you know any reason this should not be 2.2.20 final now is a very very
> good time to say. I intend to call this patch 2.2.20 in a week or so barring
> any last minute problems. Please save anything but actual bugfixes for
> 2.2.21.
> 
I did a short check through the pre10 patch but couldn't find my small
patch to linux/net/sunrpc/sched.c I sent you back in August.

This patch fixes (at least for us) the problem where rpciod still
keeps references into the root fs even after it was daemonized.

I didn't get any reaction after posting this patch, neither
positive nor negative. 

In case you don't remember here's the patch again:

andreas@ws1:~/cvsdir {625} % cvs diff -C5 -rR_2-2-19~11 -rR_2-2-19~12
linux/net/sunrpc/sched.c
Index: linux/net/sunrpc/sched.c
===================================================================
RCS file:
/raid5/cvs/repository/distribution/Base/linux/net/sunrpc/sched.c,v
retrieving revision 1.1.1.6
retrieving revision 1.12
diff -C5 -r1.1.1.6 -r1.12
*** linux/net/sunrpc/sched.c    2001/03/25 16:37:42     1.1.1.6
--- linux/net/sunrpc/sched.c    2001/08/17 11:53:48     1.12
***************
*** 1066,1075 ****
--- 1066,1076 ----
        rpciod_pid = current->pid;
        up(&rpciod_running);
 
        exit_files(current);
        exit_mm(current);
+       exit_fs(current);
 
        spin_lock_irq(&current->sigmask_lock);
        siginitsetinv(&current->blocked, sigmask(SIGKILL));
        recalc_sigpending(current);
        spin_unlock_irq(&current->sigmask_lock); 

Is there any reason for not including this in 2.2.20?
It helps us getting rid of the initial ramdisk rootfs 
on our diskless clients...

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
