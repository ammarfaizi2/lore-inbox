Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUAXAwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUAXAwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:52:09 -0500
Received: from hell.org.pl ([212.244.218.42]:24083 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S266830AbUAXAvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:51:39 -0500
Date: Sat, 24 Jan 2004 01:51:44 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc1-mm2
Message-ID: <20040124005144.GA30881@hell.org.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <1h670-8J-5@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1h670-8J-5@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Andrew Morton:
> - There is a new debug check in here which drops a stack trace when a piece
>   of code calls one of the sleep_on() functions without lock_kernel() held. 
>   This is almost certainly a bug.  Please try to identify (from the trace)
>   which subsystem is the culprit and copy its maintainer when reporting such
>   traces.

#v+
Linux version 2.6.2-rc1-mm2 (sziwan@nadir) (gcc version 3.3.2) #11 Fri Jan 23 22:45:18 CET 2004
[...]
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011aa82>] interruptible_sleep_on+0xd1/0xd6
 [<c011a784>] default_wake_function+0x0/0x12
 [<c01df0b1>] pagebuf_daemon+0x0/0x230
 [<c01df2c6>] pagebuf_daemon+0x215/0x230
 [<c01df087>] pagebuf_daemon_wakeup+0x0/0x2a
 [<c01df0b1>] pagebuf_daemon+0x0/0x230
 [<c0109255>] kernel_thread_helper+0x5/0xb

[...]
XFS mounting filesystem hda5
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011aa82>] interruptible_sleep_on+0xd1/0xd6
 [<c011a784>] default_wake_function+0x0/0x12
 [<c01df2c6>] pagebuf_daemon+0x215/0x230
 [<c01df087>] pagebuf_daemon_wakeup+0x0/0x2a
 [<c01df0b1>] pagebuf_daemon+0x0/0x230
 [<c0109255>] kernel_thread_helper+0x5/0xb

Ending clean XFS mount for filesystem: hda5
#v-

[there was more of that, omitted]
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
