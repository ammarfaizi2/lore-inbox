Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVJDOjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJDOjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJDOjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:39:39 -0400
Received: from [62.138.14.87] ([62.138.14.87]:17158 "EHLO mail.hk30.de")
	by vger.kernel.org with ESMTP id S964787AbVJDOji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:39:38 -0400
Message-ID: <45922.212.114.70.5.1128436759.squirrel@62.138.14.87>
Date: Tue, 4 Oct 2005 16:39:19 +0200 (CEST)
From: "Hans Korneder" <hans@korneder.de>
To: linux-kernel@vger.kernel.org
Reply-To: hans@korneder.de
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: hans@korneder.de
Subject: SIGALRM stays blocked when kernel 2.6.13.3 booted through pxelinux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.0 (built Tue, 27 Jul 2004 15:39:04 +0200)
X-SA-Exim-Scanned: Yes (on mail.hk30.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when booting a 2.6.* - kernel through pxelinux
SIGALRM stays blocked for a process trying to catch it.

the process trying to catch signals:

        #include <stdio.h>
        #include <signal.h>

        void catch_sig(int sig_num)
                {
                fprintf(stderr,"catch_sig %d\n", sig_num);
                (void)signal(sig_num, catch_sig);
                }

        main()
                {
                catch_sig(SIGALRM);
                catch_sig(SIGHUP);
                pause();
                }

the output of /proc/#/status:
        ...
        State:  S (sleeping)
        ...
        SigPnd: 0000000000000000
        ShdPnd: 0000000000000000
        SigBlk: 0000000000002000
        SigIgn: 0000000000000000
        SigCgt: 0000000000002001
        ...
shows that signal SIGALRM is being blocked.

thus a "kill -ALRM #" is being ignored,
a "kill -HUP #" is being processed as expected.

This could be verified with kernel 2.6.11.11 and 2.6.13.3
being booted through pxelinux 2.11, 3.08 and 3.11.

This does not happen with kernel 2.4.* (tested 2.4.25, 2.4.27, 2.4.31)
or whenever the kernel (any version 2.4 or 2.6 from above) is booted from
a harddisk.

My CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz
The GCC: gcc (GCC) 3.3.5 20050117 (prerelease) (SUSE Linux)
The .config dont seem to make much of a difference, tried with different ones
(SuSE-originals, defconfig and minimalistic configs) with and without SMP.
No modules loaded, almost no processes running (besides init/sshd/bash),
no SuSE, RedHat or other distribution-specific processes.

Any hints for a solution or how to trace the problem?

Regards,
Hans Korneder
hans at korneder dot de


