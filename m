Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287588AbSBKIv4>; Mon, 11 Feb 2002 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSBKIvh>; Mon, 11 Feb 2002 03:51:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287588AbSBKIvd>;
	Mon, 11 Feb 2002 03:51:33 -0500
Date: Mon, 11 Feb 2002 00:49:53 -0800 (PST)
Message-Id: <20020211.004953.74751936.davem@redhat.com>
To: green@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: unix sockets problems in 2.5.4-pre6?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020211111904.A955@namesys.com>
In-Reply-To: <20020211111904.A955@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oleg Drokin <green@namesys.com>
   Date: Mon, 11 Feb 2002 11:19:04 +0300

      Just tried 2.5.4-pre6 and got hung postfix "master" process which I cannot
      kill in RUNNABLE state. Here is traces of all postfix processes at the time:
   
   pickup        Z C212E180    48   522    520   523       (L-TLB)
   Call Trace: [do_exit+745/784] [sys_exit+14/16] [syscall_call+7/11]
   qmgr          S F70FBF30    48   523    520   524   522 (NOTLB)
   Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11]
   tlsmgr        S F70F5F30  8944   524    520   523 (NOTLB)
   Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11]
   master        R F773F744    48   520    900   524               (NOTLB)
   Call Trace: [__write_lock_failed+9/32] [.text.lock.open+71/137] [unix_create+92/112] [sock_map_fd+12/304] [select_bits_free+10/16]
      [sys_socket+29/96] [sys_socket+48/96] [sys_socketcall+99/512] [syscall_call+7/11]
   
      Hope this will help someone to nail a problem

It doesn't help.  You need to find the backtrace of the other process
holding the lock the AF_UNIX code wants as well, dumping just these
few processes isn't enough.

Franks a lot,
David S. Miller
davem@redhat.com
