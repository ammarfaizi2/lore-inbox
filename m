Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTDGL6Y (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTDGL6X (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:58:23 -0400
Received: from gruby.cs.net.pl ([62.233.142.99]:15624 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S263388AbTDGL6X (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:58:23 -0400
Date: Mon, 7 Apr 2003 14:09:37 +0200
From: Jakub Bogusz <qboosh@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: ptrace patch side-effects on 2.4.x
Message-ID: <20030407120937.GA3201@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've noticed a few side-effects of using ptrace patch on Linux 2.4.x
(2.4.18 and 2.4.20 tested, with patch from
http://www.hardrock.org/kernel/2.4.20/linux-2.4.20-ptrace.patch; ptrace
changes in 2.4.21-pre6 look the same, so I expect the same side-effects
in 2.4.21-pre6).

Most of these problems already were mentioned here, but I couldn't find
proper ptrace patch or any set of fixes which could resolve all problems.
Is there any now?

Summarizing: for some processes (like apache, postfix... generally those
which were started with uid=0 and dropped some privileges on startup?):

- /proc/PID/cmdline and /proc/PID/environ are empty (ps displays those
  processes in [] brackets, like swapped out); I saw a patch on
  LKML, but it enabled this data only for root; previous behaviour
  was to allow reading cmdline for all users (blocking it can break some
  monitoring systems)

- *trace commands (using ptrace syscall) on such processes don't work
  from root account - e.g. strace on httpd shows only:
  trace: ptrace(PTRACE_SYSCALL, ...): Operation not permitted
  and leaves stopped process (kill -CONT must be used to start it again)


PS. please Cc comments to me. Thanks.

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld.org.pl/
