Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQLSSmw>; Tue, 19 Dec 2000 13:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbQLSSmm>; Tue, 19 Dec 2000 13:42:42 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:58896 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129828AbQLSSmf>; Tue, 19 Dec 2000 13:42:35 -0500
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
	<m3g0kggydi.fsf@linux.local> <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
	<m37l5rggmm.fsf@linux.local> <vbasnoeeajg.fsf@mozart.stat.wisc.edu>
	<qww1yv4bxdg.fsf@sap.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Christoph Rohland's message of "19 Dec 2000 09:58:51 +0100"
Date: 19 Dec 2000 12:11:52 -0600
Message-ID: <vbaelz4qo0n.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland <cr@sap.com> writes:
> 
> I am just running a stress test on 2.4.0-test13-pre3 + appended patch
> without problems. Is the shm segment deleted sometimes or is it always
> the same segment?

IIRC, in my particular crash case, the Enlightenment window manager
was using the X shared memory extension to take snapshots of the
screen for its little desktop pager window around 30 times a second;
Mozilla was also sharing some memory with the X server for something.

The code in Enlightenment did a complete shmget/shmat/shmctl(RMID)/shmdt
cycle, so that segment *was* being constantly deleted.  The Mozilla
ones stuck around.  The particular address that was being reference in
the shm_nopage_core call corresponded to the segments being created
and deleted by Enlightenment, however.

Thanks for the locking tutorial, too.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
