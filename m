Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTHBS2w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270222AbTHBS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:28:52 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:48794 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S270219AbTHBS2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:28:50 -0400
Subject: Re: Linux 2.4.22-pre10
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030802181007.GB13525@alpha.home.local>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
	 <20030801224753.GA912@alpha.home.local>
	 <1059817370.1868.5.camel@tux.rsn.bth.se>
	 <20030802181007.GB13525@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059848925.1869.22.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 02 Aug 2003 20:28:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 20:10, Willy Tarreau wrote:
 
> > Have you tried using the ULOG target and the ulogd userspace daemon?
> > It uses netlink and can batch several entries together before it sends
> > them to userspace. Works a lot better than syslog.
> 
> yes, I tried it about february. I thought it to be the ideal solution, and it
> performed better than the standard syslog, but not as well as syslog-ng. I
> could catch about 1500 lines/s at most, and the daemon was very hungry, it ate
> between 55 and 70% of the CPU, while syslog-ng eats about 25-30. So I thought
> it was still a bit experimental and switched to syslog-ng.

Uhm, my tests have shown it to be very fast and efficient. But I didn't
look to see if all packets got through to the logfile. But getting it to
write logs at ~35MB/s wasn't a problem.

Did you specify --ulog-qthreshold 50 ?
and did you specify --ulog-cprange at all? if you don't it will copy the
entire packet to userspace. I copy 64 bytes to userspace and that's more
than enough to log everything needed.

> > Are you using ip_conntrack on that machine? if you are, be aware that
> > ip_conntrack doesn't scale well at all on SMP. It's beeing worked on.
> 
> Yes I do. I noticed the scalability problems a long time ago on my dual athlon
> at home, but wasn't really concerned. At my customer's, the only SMP one is
> used as a development gateway. All the others are UP (PIII/1G, P4/2.4G).

Ok, we are working on memory-usage and scalability stuff.

> BTW, I get the same numbers with 2.4.22-pre10 / standard ip_conntrack as with
> 2.4.21-rc2 with tcp_window_tracking. I would have thought that
> tcp_window_tracking costs a bit more, but it doesn't seem to be noticeable here.

It should cost a little bit more but not very much.

-- 
/Martin
