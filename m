Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWAOUrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWAOUrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWAOUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:47:45 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:57295 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750733AbWAOUrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:45 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Damian Pietras <daper@daper.net>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jan 2006 21:47:40 +0100
In-Reply-To: <43CA9FC7.9000802@cfl.rr.com>
Message-ID: <m3ek39z09f.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> Damian Pietras wrote:
> > On Sun, Jan 15, 2006 at 12:53:25PM -0500, Phillip Susi wrote:
> > Neither Ubuntu kernel nor this patch fixes the problem.
> >
> 
> You might want to try it under dapper then.  If you still have that
> problem, then it's got to be busted hardware.  You might try updating
> the firmware in the drive.

The irq timeout problem might be broken hardware/firmware, but there
is a problem with drive locking and the pktcdvd driver.

If you do

	pktsetup 0 /dev/hdc
	mount /dev/hdc /mnt/tmp
	umount /mnt/tmp

the door will be left in a locked state. (It gets unlocked when you
run "pktsetup -d 0" though.) However, if you do:

	pktsetup 0 /dev/hdc
	mount /dev/pktcdvd/0 /mnt/tmp
	umount /mnt/tmp

the door will be properly unlocked.

The problem is that the cdrom driver locks the door the first time the
device is opened in blocking mode, but doesn't unlock it again until
the open count goes down to zero. The pktcdvd driver tries to work
around that, but it can't do it in the first example because the
mount/umount commands do not involve the pktcdvd driver at all.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
