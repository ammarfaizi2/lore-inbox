Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDCOMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUDCOMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:12:47 -0500
Received: from webmail.sub.ru ([213.247.139.22]:20743 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261746AbUDCOMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:12:12 -0500
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
From: Mikhail Ramendik <mr@ramendik.ru>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <406E9EE5.7030509@A88a2.a.pppool.de>
References: <fa.ld6rcgc.1lhmd9q@ifi.uio.no>
	 <406E9EE5.7030509@A88a2.a.pppool.de>
Content-Type: text/plain
Message-Id: <1081001524.1061.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Sat, 03 Apr 2004 18:12:05 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andreas Hartmann wrote:

> > It turned out that on disk-intensive operation, the "system" CPU usage
> > skyrockets. With a mere "cp" of a large file to the same direstory
> > (tested with ext3fs and FAT32 file systems), it is 100% practically all
> > of the time !
> 
> Which tool do you use for measure? xosview?

IceWM's monitor. (It just runs all the time, that's how I spotted the
problem).

> I'm having here the same problem. But it depends on the tool which is used 
> for measuring. If I use top from procps 3.2, I can't see this high system 
> load. "time" can't see it, too.
> 
> This is what top says during cp of 512MB-file:
> Cpu(s):  2.0% us,  8.3% sy,  0.0% ni,  0.0% id, 89.0% wa,  0.7% hi,  0.0% si

I don't have procps 3.2 as yet, will compile it soon; however I think
it's the same issue.

I tried the deadline elevator, as suggested by Bill Davidsen down this
thread. It did not help. In fact the performance fell (the same file
took a longer time to copy); the CPU use is still 100% (with an
occasional "dent" or two, but these are very small in duration).

I also tried increasing the read-ahead. It does not help either.

Finally I tried increasing the read-ahead WITH the deadline elevator.
The performance rose (compared to the one measured with the standard
read-ahead and the deadline elevator). And the CPU load still did not
change.

I don't have much CPU to waste (Duron 650 MHz), so I think some
performance problems I see are linked to this. 

> But you're right, 2.6.4 is slower than 2.4.25. See the thread "Very poor 
> performance with 2.6.4" here in the list.

I've looked at it. I will try the latest rc-mm kernel and report the
results.

Yours, Mikhail Ramendik



