Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVECIKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVECIKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 04:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVECIKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 04:10:15 -0400
Received: from vsmtp1.tin.it ([212.216.176.141]:27056 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S261420AbVECIKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 04:10:09 -0400
To: William Park <opengeometry@yahoo.ca>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no,
       davidnwelton@gmail.com
Subject: Re: rootdelay
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org>
	<87pswjur3c.fsf@dedasys.com>
	<20050425144213.GA2293@node1.opengeometry.net>
	<87acnmee1s.fsf@dedasys.com>
	<20050429183411.GA1998@node1.opengeometry.net>
From: davidw@dedasys.com (David N. Welton)
Date: 03 May 2005 10:07:35 +0200
Message-ID: <874qdkenqw.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park <opengeometry@yahoo.ca> writes:

> On Mon, Apr 25, 2005 at 11:34:23PM +0200, David N. Welton wrote:
> > > > > > http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch
> 
> I patched it to 2.6.11, and it compiles okey.  On boot, it prints
> "Waiting for root device to wake us up."  then it waits for my USB
> key to register.  After USB partition info prints to screen, above
> message is printed "Waiting for root device to wake us up."  again.
> Then, it just hangs forever.

Ok, I updated to 2.6.11.8, and indeed it does have problems that
weren't there before - although in my case it can't mount the root
partition because it's not quite ready yet.  In part, it seems to be
caused by the fact that the USB start up sequence introduces a new
thread that delays the scsi_host_scan by 5 seconds, which is long
enough to cause problems.  I added some code to wait for not only the
disk name to be online, but the partition, but even that doesn't seem
to be quite enough.

Is there anyplace generic that could be hooked that will report when a
device is actually online and ready to run?  Perhaps I was just lucky
in the past with add_disk :-/

Ciao,
-- 
David N. Welton
 - http://www.dedasys.com/davidw/

Apache, Linux, Tcl Consulting
 - http://www.dedasys.com/
