Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSBNAwS>; Wed, 13 Feb 2002 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSBNAwI>; Wed, 13 Feb 2002 19:52:08 -0500
Received: from web12306.mail.yahoo.com ([216.136.173.104]:41991 "HELO
	web12306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289278AbSBNAvx>; Wed, 13 Feb 2002 19:51:53 -0500
Message-ID: <20020214005152.91108.qmail@web12306.mail.yahoo.com>
Date: Wed, 13 Feb 2002 16:51:52 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: memory corruption in tcp bind hash buckets on SMP? 
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020212.221726.34760851.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "David S. Miller" <davem@redhat.com> wrote:
> 
> This bug is fixed in the 2.4.9 Red Hat 7.2 errata kernels.

Thanks, Is the following diff the only culprit/fix?

--- linux-2.4.7-10/net/ipv4/tcp_ipv4.c      Wed Feb 13 16:50:00 2002
+++ linux-2.4.9-21/net/ipv4/tcp_ipv4.c  Thu Jan 17 10:03:28 2002
@@ -1484,11 +1484,11 @@
        if (nsk) {
                if (nsk->state != TCP_TIME_WAIT) {
                        bh_lock_sock(nsk);
                        return nsk;
                }
-               tcp_tw_put((struct tcp_tw_bucket*)sk);
+               tcp_tw_put((struct tcp_tw_bucket*)nsk);
                return NULL;
        }
 

Raghu.

__________________________________________________
Do You Yahoo!?
Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com
