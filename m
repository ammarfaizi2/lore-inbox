Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266976AbUBMMXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266979AbUBMMXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:23:52 -0500
Received: from pop.gmx.de ([213.165.64.20]:26093 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266976AbUBMMXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:23:51 -0500
Date: Fri, 13 Feb 2004 13:23:49 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <9792.1076675029@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote in message
news:<1oEGw-2ex-1@gated-at.bofh.it>...
> On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
>  
> > For writes, iozone found an upper bound of about 10megs/sec, which is 
> > abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
> > than reads, because once the write is sent, you can forget about it. 
> > You don't have to wait around for something to come back, and that 
> > latency for reads can hurt performance.  The OS can also buffer writes 
> > and reorder them in order to improve efficiency.
> 
> It depends on the disk too. Lots of disks (specially IDE) are far slower
> on writes than they are on reads.

No. Have you verified this? If you 'dd' your swap partition from /dev/zero
on IDE, you'll see write performance closely matches read performance, for
drives old and new.

In the case of small transfers, the drive can hand them off to the on-drive
write cache (2/8MB usually). The only case where IDE disks will be 'slow' for
write performance is where you have no disk I/O scheduling and lots of small
reads/writes - this case wins on SCSI, but many modern IDE disks and
controllers also have tagged command queuing, so it is even more of a corner case.

Dan

-- 
Daniel J Blueman

GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

