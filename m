Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTLELX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTLELX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:23:28 -0500
Received: from web02.mailshell.com ([209.157.66.232]:57823 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S263921AbTLELXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:23:23 -0500
Message-ID: <20031205112319.31918.qmail@mailshell.com>
Date: Fri, 05 Dec 2003 13:23:15 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com>	<87d6bc2yvq.fsf@devron.myhome.or.jp>	<20031129170034.10522.qmail@mailshell.com>	<1070242158.1110.150.camel@buffy> <3FCBAE6F.1090405@myrealbox.com>	<20031201213624.18232.qmail@mailshell.com> <871xrmudyb.fsf@devron.myhome.or.jp>
In-Reply-To: <871xrmudyb.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031128@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> lkml-031128@amos.mailshell.com writes:
> 
> 
>>After I added Ogawa's line, "head -1 /proc/net/tcp" stopped
>>freezing my machine but PPP failed to work.
>>
>>Also after adding Ogawa's line, PPP works fine (as it is now, as
>>I write this message) as long as I don't try "head -1 /proc/net/tcp"
>>after boot. If I'll try "head -1 /proc/net/tcp" now PPP will stop
>>working.
> 
> 
> Can you reproduce the fail of PPP? I couldn't reproduce it.
> What reason is the fail of PPP? (the "debug" option of pppd may be helpful)

Sorry. I just tried:

1. From a multi-user mode, after an uptime of 5 days (test11 with your
fix).
2. killed the ppp daemon (/etc/init.d/ppp stop). Made sure the ppp0
interface is down.
3. did "head -1 /proc/net/tcp" and "cat /proc/net/tcp". Passed fine.
4. re-startted ppp daemon.
5. System is fine. No kernel errors. PPP works flowlessly.

So I think my linking of PPP to the fix was wrong. Maybe the PPP failure
was unrelated to this.

> 
> Of course, the following message is easy reproducible. But it's
> debugging message, not the real problem. And probably it's unrelated
> to the fail of PPP.
> 
> 
>>>>>Badness in local_bh_enable at kernel/softirq.c:121
>>>>>Call Trace:
>>>>> [<c011df25>] local_bh_enable+0x85/0x90
>>>>> [<c02315e2>] ppp_async_push+0xa2/0x180
>>>>> [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
>>>>> [<c0202638>] pty_unthrottle+0x58/0x60
>>>>> [<c01ff0fd>] check_unthrottle+0x3d/0x40
>>>>> [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
>>>>> [<c0202a47>] pty_flush_buffer+0x67/0x70
>>>>> [<c01fba41>] do_tty_hangup+0x3f1/0x460


