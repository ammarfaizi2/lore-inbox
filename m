Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUE2Hrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUE2Hrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUE2Hrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 03:47:42 -0400
Received: from mail.tpgi.com.au ([203.12.160.101]:7554 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263818AbUE2Hrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 03:47:40 -0400
Message-ID: <40B83D05.1020701@linuxmail.org>
Date: Sat, 29 May 2004 17:34:29 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: swsusp-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 problems on SMP machine, incorrect tainting
References: <20040528103549.GA2789@elf.ucw.cz>
In-Reply-To: <20040528103549.GA2789@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
> Hi!
> 
> I tried suspend2 2.0.0.81 on  Toshiba HT machine, and it did not
> work :-(. First test was with "noapic nosmp", last messages are

Hmm. I haven't tried it with noapic or nosmp options before. It ought to work; I'll see if I can 
reproduce this issue.

> Tainted: S is due to suspend2, right? It abuses flag that origally means
> "invalid SMP configuration". You might want to fix that.

Yes. I've been meaning to change that; must get around to it.

> Tried without noapic nosmp... display got "interesting" at one point,

Yes. The sequence of operations to force a redraw of the screen works okay under 2.4 but needs 
looking at under 2.6.

> but hey, it worked! I have "sleeping function called rom invalid
> context at arch/i386/mm/highmem.c:5" called from kmap, copy_pageset1.

Yes. It needs to be atomic (it's the atomic copy) and pages might well be HighMem so I guess the 
answer is to suppress the message rather than changing something in suspend.

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

After homosexuality, they'll be arguing paedophilia is normal.
