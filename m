Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276408AbRJCPge>; Wed, 3 Oct 2001 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276403AbRJCPgX>; Wed, 3 Oct 2001 11:36:23 -0400
Received: from [217.6.75.131] ([217.6.75.131]:38029 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S276397AbRJCPgG>; Wed, 3 Oct 2001 11:36:06 -0400
Message-ID: <3BBB334B.98D8750C@internetwork-ag.de>
Date: Wed, 03 Oct 2001 17:48:28 +0200
From: "Till Immanuel Patzschke" <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is currently the most stable 2.4 kernel? (PPP)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.10 + the ppp patch works fine on UP - if you need the SMP you can hack/patch
socket.c to "make" PPP SMP safe (the patch below works perfectly well for me on
a 2 CPU P-III system for 6 days now -- no lockups, no crashes - and I'm loading
the system constantly w/ up to 4000 PPPoX sessions, starting stopping etc... -
NO PROBLEM.)

Please keep in mind - the folling is a HACK!

Cheers,

Immanuel

--- net/socket.c~       Tue Aug 28 19:56:06 2001
+++ net/socket.c        Fri Sep 28 18:22:53 2001
@@ -682,10 +682,10 @@
        struct socket *sock;
        int err;

-       unlock_kernel();
+       //unlock_kernel();
        sock = socki_lookup(inode);
        err = sock->ops->ioctl(sock, cmd, arg);
-       lock_kernel();
+       //lock_kernel();

        return err;
 }


