Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUHZXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUHZXxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269700AbUHZXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:50:37 -0400
Received: from science.horizon.com ([192.35.100.1]:41520 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269802AbUHZXrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:47:40 -0400
Date: 26 Aug 2004 23:47:39 -0000
Message-ID: <20040826234739.18194.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From MAILER-DAEMON Thu Aug 26 08:51:34 2004
Date: 26 Aug 2004 08:51:34 -0000
From: MAILER-DAEMON@horizon.com
To: linux@horizon.com
Subject: failure notice

This is an automated response from the e-mail delivery system at
horizon.com.  Your mail could not be delivered to one or more recipients.
This is a permanent error, so the message is being returned to you as
undeliverable.  The detailed error message is at the end of this text.
	
The most common reason that mail is not deliverable is that the specified
e-mail address does not exist.  horizon.com is Science Horizons, Inc.,
makers of seismic data acquisition equipment, with offices in Florida
and Missouri, USA.  We sometimes receive e-mail that is intended for a
different company entirely.  The most common are:
	- Horizon Airlines, horizonair.com
	- Horizon Organic Dairy, horizonorganic.com
	- Horizon Staffing Services, horizonstaff.com
	- Verizon Wireless, verizon.com
but there are many other companies with the word "horizon" in their name.
	
	
Please note that this response IS A RECORDING.	No human being has seen
your e-mail.  The header From: line of MAILER-DAEMON is the conventional
name for the source of such messages; it does not actually exist,
and mail to it is not accepted or read.  (The envelope sender, where
automated delivery messages are to be delivered, is the null address
"<>", as required by RFC 2821 section 6.1 for such bounce messages.)

If you wish to contact a human, the correct e-mail address is "postmaster"
(at whatever domain is of interest), as specified and required by RFC
2821 section 4.5.1.


The address to which your e-mail could not be delivered, and the specific
reason why, is:

<linux-kerne@vger.kernel.org>:
12.107.209.244 does not like recipient.
Remote host said: 554 Hi [192.35.100.1], 5.0.0 unresolvable address: <linux-kerne@vger.kernel.org>; nosuchuser; linux-kerne@vger.kernel.org
Giving up on 12.107.209.244.

--- Below this line is a copy of the message.

Return-Path: <linux@horizon.com>
Received: (qmail 22885 invoked by uid 1000); 26 Aug 2004 08:51:02 -0000
Date: 26 Aug 2004 08:51:02 -0000
Message-ID: <20040826085102.22884.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kerne@vger.kernel.org
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Cc: 

William Lee Irwin III wrote:
> ELF ABI violation. "...the reserved area shall not consume more than
> 1GB of the address space."

and in another message:

> Though asinine, the ABI spec is set in stone.

So document that in Kconfig and violate away.

The point is that the vast majority of programs don't care.
Any program that uses a shared library can't depend on the exact size of
the address space that will be left to it.

I'm very dubious about a 1 GB user-land/3 GB kernel patch, but the
0xb0000000 patch (2.75/1.25) is damn useful to avoid HIGHMEM on 1 GB
RAM machines.  PAE requires the split to be on a 1 GB boundary, but
if you're using it to avoid highmem entirely, you're not running
PAE.  And normal page tables only require 4 MB granularity.

Ryan Cumming wrote:
> And at least one app (valgrind) chokes with as little as 1.25G of reserved 
> space.

You can mention that in the help, too.  But it's probably that valgrind
tries to put itself up there and present the debuged application with
the illusion of a smaller machine.  And to the extent that this works,
the debugged program doesn't care about the split, which actually proves
the point.

Valgrind can probably be hacked to cope fairly easily.
