Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbWJCVrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbWJCVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWJCVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:47:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030569AbWJCVrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:47:23 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH take2 0/5] dio: clean up completion phase of direct_io_worker()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Tue, 03 Oct 2006 17:47:08 -0400
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net> (Zach Brown's message of "Mon,  2 Oct 2006 16:21:19 -0700 (PDT)")
Message-ID: <x494pul842r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [PATCH take2 0/5] dio: clean up completion phase of direct_io_worker(); Zach Brown <zach.brown@oracle.com> adds:

zach.brown> Andrew, testing has now uncovered 2 bugs in this patch set that
zach.brown> have been fixed.  XFS and the generic file path were using
zach.brown> blkdev_direct_IO()'s return code to test if ops were in flight
zach.brown> and were missing EIOCBQUEUD.  They've been fixed.  I think this
zach.brown> can bake in -mm now.

zach.brown> Here's the initial introduction to the series with an update on
zach.brown> what's been tested:

zach.brown> There have been a lot of bugs recently due to the way
zach.brown> direct_io_worker() tries to decide how to finish direct IO
zach.brown> operations.  In the worst examples it has failed to call
zach.brown> aio_complete() at all (hang) or called it too many times
zach.brown> (oops).

zach.brown> This set of patches cleans up the completion phase with the
zach.brown> goal of removing the complexity that lead to these bugs.  We
zach.brown> end up with one path that calculates the result of the
zach.brown> operation after all off the bios have completed.  We decide
zach.brown> when to generate a result of the operation using that path
zach.brown> based on the final release of a refcount on the dio structure.

zach.brown> I tried to progress towards the final state in steps that were
zach.brown> relatively easy to understand.  Each step should compile but I
zach.brown> only tested the final result of having all the patches applied.

zach.brown> I've tested these on low end PC drives with aio-stress, the
zach.brown> direct IO tests I could manage to get running in LTP, orasim,
zach.brown> and some home-brew functional tests.

zach.brown> In http://lkml.org/lkml/2006/9/21/103 IBM reports success with
zach.brown> ext2 and ext3 running DIO LTP tests.  They found that XFS bug
zach.brown> which has since been addressed in the patch series.

We tested this on one of our smaller systems using ext3, and it holds up.
There was no performance degradation observed.  I would like to see some
raw testing;  I'll see if I can't get that done.

As with the last posting, I reviewed the direct I/O path with the patches
applied, and it's much nicer than before.

Acked-by: Jeff Moyer <jmoyer@redhat.com>
