Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUEaSmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUEaSmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 14:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUEaSmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 14:42:17 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6297 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264677AbUEaSmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 14:42:14 -0400
Message-ID: <40BB7D34.8060200@elegant-software.com>
Date: Mon, 31 May 2004 14:45:08 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a program that works fine under stock rh9 (2.4.2-8) but has 
issues getting signaled under FedoraCore2 (2.6.5-1.358)
using SETSIG to a Posix RT signal.

The program does the standard:

  /* hook to process */
  if ( fcntl(fdcallback->fd, F_SETOWN, mon->handler_q.thread->pid) == -1 ) {
    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
       "cannot set owner on fd (%s)",
       strerror(errno));
  }/* end if */

  /* make async */
  if ( fcntl(fdcallback->fd, F_SETFL, (O_NONBLOCK | O_ASYNC) ) == -1 ) {
    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
       "cannot set async on fd (%s)",
       strerror(errno));
  }/* end if */

  /* hook to signal */
  if ( fcntl(fdcallback->fd, F_SETSIG, AW_SIG_FD) == -1 ) {
    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
       "cannot set signal on fd (%s)",
       strerror(errno));
  }/* end if */

Under Fedora things work well for raw sockets (much lower latency than 
in 2.4!) but are inconsistent with udp or tcp sockets.

In the udp case, I when I listen for multicast packets my app only 
receives them when I am running a tcpdump (bizarre!).

In the tcp case, I don't get signaled if I do the F_SETSIG on more than 
1 fd.

Any tips on tracking this down would be much appreciated.

Thx

Russ

