Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSGOPTb>; Mon, 15 Jul 2002 11:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSGOPT3>; Mon, 15 Jul 2002 11:19:29 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:36344 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S316786AbSGOPTZ>;
	Mon, 15 Jul 2002 11:19:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 11:22:19 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20020712162306$aa7d@traf.lcs.mit.edu>
Message-ID: <s5gsn2lt3ro.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider this argument:

  Given: On ext3, fsync() of any file on a partition commits all
         outstanding transactions on that partition to the log.

  Given: data=ordered forces pending data writes for a file to happen
         before related transactions are committed to the log.

  Therefore: With data=ordered, fsync() of any file on a partition
             syncs the outstanding writes of EVERY file on that
             partition.

Is this argument correct?  If so, it suggests that data=ordered is
actually the *worst* possible journalling mode for a mail spool.

One other thing.  I think this statement is misleading:

    IF your server is stable and not prone to crashing, and/or you
    have the write cache on your hard drives battery backed, you
    should strongly consider using the writeback journaling mode of
    Ext3 versus ordered.

This makes it sound like data=writeback is somehow unsafe when
machines crash.  I do not think this is true.  If your application
(e.g., Postfix) is written correctly (which it is), so it calls
fsync() when it is supposed to, then data=writeback is *exactly* as
safe as any other journalling mode.  "Battery backed caches" and the
like have nothing to do with it.  And if your application is written
incorrectly, then other journalling modes will reduce but not
eliminate the chances for things to break catastrophically on a crash.

So if the partition is dedicated to correct applications, like a mail
spool is, then data=writeback is perfectly safe.  If it is faster,
too, then it really is a no-brainer.

 - Pat
