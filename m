Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDLVcJ (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTDLVcJ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:32:09 -0400
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:2570 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP id S261609AbTDLVcI (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:32:08 -0400
Date: Sat, 12 Apr 2003 23:40:02 +0200
From: Michal Dorocinski <zwierzak@venus.ci.uw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.20 and a bug in page_alloc.c in 102 line.
Message-ID: <20030412234002.E721@venus.ci.uw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw reports about that bug once or twice, but no answer about it 
(only someone pointed it to nv drivers). Well it is _not_ connected to any
drivers I think.
Here is oops:

  kernel BUG at page_alloc.c:102!
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<c012c596>]    Not tainted
 EFLAGS: 00010282
 eax: 0100000d   ebx: c108280c   ecx: c108280c   edx: 00000000
 esi: 00000000   edi: cbc27a2c   ebp: c93e5f20   esp: c93e5eec
 ds: 0018   es: 0018   ss: 0018
 Process httpd (pid: 16114, stackpage=c93e5000)
 Stack: c108280c 00001000 cbc27a2c 00000009 000000bb cff4d488 c7cf0a64 c93e5f28
        c0125cb5 c108280c cff4d464 c108280c cff4d464 c93e5f28 c012cdda c93e5f64
        c0125f37 c93e5f88 c108280c 00000000 00001000 00000000 c7cf0a64 00000000
 Call Trace:    [<c0125cb5>] [<c012cdda>] [<c0125f37>] [<c012642b>] [<c0126328>]
   [<c0132308>] [<c0106c57>]

 Code: 0f 0b 66 00 5a 11 2d c0 89 d8 2b 05 f0 62 43 c0 69 c0 a3 8b

It goes to syslog twice every 30 seconds when the traffic is high, or a bit slower 
if not. Machine is working as far as I can see normaly. (ps, ls, df and so on works,
even other deamons work ie. sendmail, ssh and so on).
Call Trace and Code are _always_ the same.

Will it be fixed in 2.4.21 or there is some patch around ? (I've tried to find it but
couldn't)

Greetings
	Michal

-- 
The Shadow, The Darkness, The Fear...
	Forever Alone Immortal...
