Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314575AbSEFQxl>; Mon, 6 May 2002 12:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSEFQxk>; Mon, 6 May 2002 12:53:40 -0400
Received: from web13105.mail.yahoo.com ([216.136.174.150]:27661 "HELO
	web13105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314575AbSEFQxj>; Mon, 6 May 2002 12:53:39 -0400
Message-ID: <20020506165336.93440.qmail@web13105.mail.yahoo.com>
Date: Mon, 6 May 2002 09:53:36 -0700 (PDT)
From: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Stack overflow ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I applied Tigran's 8k->16k large stack patch to
2.4.18. When I look at /proc/stack I see that a
process insmod is using 0x2000=8k stack. My
undertstanding is that the stack size increase should
not have affected the amount of stack used by any
process. 

If that is the case how did my system survive without
the patch when the whole task_struct is wiped out by a
process using a stack size of 8k. I have been running
heavy I/O on this system (A file server) for a couple
of days without the patch. Nothing adverese happened.

Can this happen or are the contents put to /proc/stack
in the patch is wrong. I looked at the patch carefully
and all seems to be ok to me. Has any one had a
similar experience before ?

To further analyze the problem I called BUG() when the
stack size ever increased more than 8k in schedule()
After running ksymoops I see that this is happening
when I try to access routines in i2c.o which seem to
have a deep call stack.

Thank you
Ravi

=====
------------------------------
Ravi Wijayaratne

__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
