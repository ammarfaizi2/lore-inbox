Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVARHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVARHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 02:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVARHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 02:23:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:47071 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261159AbVARHWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 02:22:50 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16876.50139.587691.939056@tut.ibm.com>
Date: Tue, 18 Jan 2005 02:07:55 -0600
To: karim@opersys.com
Cc: Aaron Cohen <remleduff@gmail.com>, Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EC94BF.2080105@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<41E899AC.3070705@opersys.com>
	<Pine.LNX.4.61.0501160245180.30794@scrub.home>
	<41EA0307.6020807@opersys.com>
	<Pine.LNX.4.61.0501161648310.30794@scrub.home>
	<41EADA11.70403@opersys.com>
	<Pine.LNX.4.61.0501171403490.30794@scrub.home>
	<41EC2DCA.50904@opersys.com>
	<Pine.LNX.4.61.0501172323310.30794@scrub.home>
	<41EC8AA2.1030000@opersys.com>
	<727e501505011720303ba4f2cd@mail.gmail.com>
	<41EC94BF.2080105@opersys.com>
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Aaron Cohen wrote:
 > >   I've got a quick question and I just want to be clear that it
 > > doesn't have a political agenda behind it.
 > 
 > :)
 > 
 > > Here goes, why can't LTT and/or relayfs, work similar to the way
 > > syslog does and just fill a buffer (aka ring-buffer or whatever is
 > > appropriate), while a userspace daemon of some kind periodically reads
 > > that buffer and massages it.  I'm probably being naive but if the
 > > difficulty is with huge several hundred-gig files, the daemon if it
 > > monitors the buffer often enough could stuff it into a database or
 > > whatever high-performance format you need.
 > 
 > Because of the bandwidth it is not possible to do any sort of live
 > processing of any kind. The only thing the daemon can possibly do
 > is write large blocks of tracing info to disk as rapidly as possible.

I have to disagree.  Awhile back, if you remember, I posted a patch to
the LTT daemon that would monitor the trace stream in real time, and
process it using an embedded Perl interpreter, no less:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109405724500237&w=2

It didn't seem to have any problems keeping up with the trace stream
even though it was monitoring all LTT event types (and a couple of
others - custom events injected using kprobes) and not doing any
filtering in the kernel, through kernel compiles, normal X traffic,
etc.  I don't know what volume of event traffic would cause this model
to break down, but I think it shows that at least some level of
non-trivial live processing is possible...

Tom

 > 
 > >  It also seems to me that Linus' nascent "splice and tee" work would
 > > be really useful for something like this to avoid a lot of unnecessary
 > > copying by the userspace daemon.
 > 
 > There is no copying by the userspace daemon. All it does is open(),
 > then mmap(), and then it sleeps until it is woken up by the ltt
 > kernel subsystem. When that happens, it only does a write() on the
 > mmaped area, tells the ltt subsystem that it commited X number of
 > sub-buffers and goes back asleep. This is all zero-copy.
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

