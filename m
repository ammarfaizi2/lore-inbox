Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUA0AAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUA0AAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:00:02 -0500
Received: from mail.tmr.com ([216.238.38.203]:34058 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265635AbUAZX77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:59:59 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: i/o wait eating all of CPU on 2.6.1
Date: 26 Jan 2004 23:59:42 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv49le$747$1@gatekeeper.tmr.com>
References: <20040125143042.GA20274@ihme.org>
X-Trace: gatekeeper.tmr.com 1075161582 7303 192.168.12.62 (26 Jan 2004 23:59:42 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040125143042.GA20274@ihme.org>,
Jaakko Helminen  <haukkari@ihme.org> wrote:
| 
| I have two servers, both of which have more than 300 gigabytes of hard drive
| space and those files are made available to the network with samba, nfs and
| http and it worked fine with 2.6.0 but when I upgraded to 2.6.1 I noticed
| that everything was VERY slow, from a machine that is connected to the other
| server with a 100M link, 57kB/s tops. i/o wait eats up all of the cpu.
| On the other hand, Apache (and everything else) works very fast when I only
| send /dev/zero to a client, since that doesn't need disk operations.

Actually, io-wait is an indication that the CPU is idle with io
outstanding, and doesn't eat the machine any more than idle time. It is
an indication that the io is not keeping up, of course.

The fact that sending /dev/zero is fast sort of eliminates the reported
problems with NFS and setting the read/write size to 8k on the client.
Just for grins, hopefully you have followed the "NFS is slow" thread,
but I saw people having the issue with 2.6.0, so that's not likely to be
be involved.

I have some preliminary numbers which indicate 2.6.2-rc2 is faster at
some disk operations than 2.6.1, but since that's one benchmark on one
machine all I can say is that if you want to move forward, that kernel
is working well for me. Of course if there's nothing in 2.6.1 you
really want or need, falling back is a sure cure.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
