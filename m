Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUE1KgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUE1KgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 06:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUE1KgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 06:36:00 -0400
Received: from gprs214-86.eurotel.cz ([160.218.214.86]:13953 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262008AbUE1Kf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 06:35:56 -0400
Date: Fri, 28 May 2004 12:35:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>,
       swsusp-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: suspend2 problems on SMP machine, incorrect tainting
Message-ID: <20040528103549.GA2789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried suspend2 2.0.0.81 on  Toshiba HT machine, and it did not
work :-(. First test was with "noapic nosmp", last messages are

Message from syslogd@elonex...
elonex kernel: - I/O speed: Write 80 MB/s, Read 83 MB/s

Unable to handle kernel NULL pointer deference at virtual address 100
...
EIP: c13f7f81 (<- outside of kernel symbols?! strange) Tainted: G S
...
(no call trace, strange).



Tainted: S is due to suspend2, right? It abuses flag that origally means
"invalid SMP configuration". You might want to fix that.

Tried without noapic nosmp... display got "interesting" at one point,
but hey, it worked! I have "sleeping function called rom invalid
context at arch/i386/mm/highmem.c:5" called from kmap, copy_pageset1.

Tried "noapic" only, worked ok.

-- 
934a471f20d6580d5aad759bf0d97ddc
