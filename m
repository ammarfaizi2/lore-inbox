Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129647AbRBUAxq>; Tue, 20 Feb 2001 19:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130035AbRBUAx0>; Tue, 20 Feb 2001 19:53:26 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:56591 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129647AbRBUAxY>; Tue, 20 Feb 2001 19:53:24 -0500
Date: Tue, 20 Feb 2001 19:53:01 -0500
From: Chris Mason <mason@suse.com>
To: Arnaud Installe <a.installe@ieee.org>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs probs on 2.2.17
Message-ID: <1940350000.982716781@tiny>
In-Reply-To: <20010221014410.A2559@bach.iverlek.kotnet.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 21, 2001 01:44:10 AM +0100 Arnaud Installe
<arnaud@bach.kotnet.org> wrote:

> Hello,
> 
> I've had a problem with a reiserfs partition on a 2.2.17 kernel the other
> day.  Everything I did on it just waited forever.  (Since shutdown tries
> to umount all partitions the only way to reboot the machine was to kill
> the watchdog process.)
> 
> The problem persisted after the reboot, so the partition must've contained
> errors.  Running `reiserfsck --replay-by-journal' fixed the problem.  (I
> think: before that I also ran `reiserfsck --check 'on it.)
> 


Which reiserfs version are you running?  From the ps output, it looks like
you've got a bunch of processes waiting on the log, and one process waiting
on a semaphore, so everyone is probably waiting for that process to close
the transaction.  These kinds of deadlocks should have been long since
fixed, so there is probably a larger problem.

Running reiserfsck --replay-journal will replay the journal.  This happens
on every mount, so I'm really not sure how it could have fixed things ;-)
The --check option is readonly, and if there was a metadata problem it
probably would have reported it.

-chris

