Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRBQSnE>; Sat, 17 Feb 2001 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRBQSmy>; Sat, 17 Feb 2001 13:42:54 -0500
Received: from web1302.mail.yahoo.com ([128.11.23.152]:49416 "HELO
	web1302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130437AbRBQSmn>; Sat, 17 Feb 2001 13:42:43 -0500
Message-ID: <20010217184242.1070.qmail@web1302.mail.yahoo.com>
Date: Sat, 17 Feb 2001 10:42:42 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: System V msg queue bugs in latest kernels
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ipcs (msg) gives incorrect results if used-bytes is above 65536. It
stays at 65536 even though messages are being read and removed from the
msg queue.

The sysv msg queue either ignores the /proc/sys/kernel/msgmnb value if
it is above 65536 or simply gets it wrong. Proof: I can place more than
msgmnb bytes in a queue. The behavior is not consistent, but 100%
reproducable. It's not consistent because if I use messages of about
1000-2000 bytes the msgmnb never gets bigger than 65536 (even if
/proc/sys/kernel/msgmnb is set to 1048576 - bug). However, if I use
small messages like 13 bytes I can get bizarre (wrong) ipcs results
like this:

used-bytes    messages
65536          65536


Why does Linux ignore the /proc/sys/kernel/msgmnb value - or seem to
partly ignore it if it is above 65536? I *really* need this to be
around a MB. Is there an undocumented limit here or is this a bug?

Thanks.





=====
A camel is ugly but useful; it may stink, and it may spit, but it'll get you where you're going. - Larry Wall -

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
