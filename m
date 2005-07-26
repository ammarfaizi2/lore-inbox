Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVGZNNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVGZNNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVGZNNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:13:16 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:52978 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261765AbVGZNMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:12:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=V8cPwggXwG4mc6mX9qZVDp/jvfnn8DtkrU+hvt9mFFU9mD5puEQT6rF4JFaA4LFYDTap4MiDKYku09lxd2dfP7tfOB2ovUSmuECCORA9p+/+qc0R/dY/iL/aGengEptOWnmI7nimhHgaas+43/ztrtF/Wu+UyIH7jZNuyAxHp+M=
Date: Tue, 26 Jul 2005 22:12:26 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6-block:master] overview of soon-to-be-posted patches
Message-ID: <20050726131215.GA23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 I hope you had fun on your vacation and at OLS.  I'm posting 18
welcome-back patches today. :-p This mail is to show the overview of
the patches.  All patches are against master head of linux-2.6-block
tree.

patch #1	: fix-elevator_find.  remove try_module_get race in
		  elevator_find.
patch #2	: fix-cfq_find_next_crq.  fix cfq_find_next_crq bug
		  in cfq.
patch #3-7	: generic dispatch queue patchset.  implements generic
		  dispatch queue.
patch #8	: reimplement-elevator-switch.  reimplements elevator
		  switch using generic dispatch queue.  draining isn't
		  needed anymore.
patch #9-#18	: ordered reimplementation patchset.  reimplements
		  I/O barrier handling.

 Both generic dispatch queue patchset and ordered reimplementation
patchset were previously posted.  They are reordered (as you asked)
and I've added missing bits (all elevators are updated, docs are
updated).  Also, there were a few changes and fixes.  I'll mention
them when I post those patches.

 I've tested these changes by running parallelly...

* random raw read (concurrency 8)
* repeatedly mounting a ext3 fs with -o barrier=1, copying, syncing &
  checksumming a 128M file, and unmounting the fs.
* periodic scheduler switch (each iosched runs for 3 minutes and then
  switched to the next one)

 This test has been running for several hours without a problem and I
will keep it running for today and maybe tomorrow unless I have to use
the test machine for some other purpose.

 Thanks.

--
tejun
