Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTJONjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTJONjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:39:18 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7052
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263210AbTJONjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:39:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Preemptible kernel makes mpg123 skip a lot under 2.6.0-testing7 and very high load average under low usage.
Date: Wed, 15 Oct 2003 23:44:29 +1000
User-Agent: KMail/1.5.4
Cc: Dru <andru@treshna.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310152344.29920.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I quote from your output:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
22953 andru     15   0 10100 5316 9464 S  3.7  0.6   2:02.39 mpg123
 1067 root       5 -10  595m  58m 539m S  3.3  6.6 391:41.29 XFree86
 1176 andru     15   0 47488  26m  13m S  1.0  3.0  11:52.32 gnome-terminal
25063 root      17   0  2004 1096 1792 R  0.7  0.1   0:00.03 top

The kernel is now tuned to give much more priority to reniced tasks and it is 
not recommended to run your X server nice -10. This is the cause of your 
problem as X is starving your audio application. Some distributions do this 
by default to get around the limitations of the old cpu scheduler not being 
able to make X smooth enough at nice 0. This hack/workaround is no longer 
recommended for 2.6 kernels. You will find nice performance of X at nice 0 
now and audio will not skip when the nice value of X is the same as your 
audio application.

Con

