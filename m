Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTKKJvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 04:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTKKJvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 04:51:19 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:37822 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264280AbTKKJvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 04:51:17 -0500
Message-ID: <3FB0B10E.9060907@softhome.net>
Date: Tue, 11 Nov 2003 10:51:10 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QxRl.17Y.9@gated-at.bofh.it> <Qy0W.1sk.9@gated-at.bofh.it> <QyaB.1GK.17@gated-at.bofh.it> <QzSZ.4x1.1@gated-at.bofh.it> <QCHh.X6.3@gated-at.bofh.it>
In-Reply-To: <QCHh.X6.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> Andreas Dilger wrote:
> 
> 
>>>This is fast turning into a creeping horror of aggregation.  I defy anybody
>>>to create an API to cover all the options mentioned so far and *not* have it
>>>look like the process_clone horror we so roundly derided a few weeks ago.
>>
>>	int sys_copy(int fd_src, int fd_dst)
> 
> 
> Doesn't work.  You have to set the security attributes while you open
> fd_dst.

   int new_fd = sys_copy( int src_fd );  /* cloned copy, out of any fs */
   fchmod( new_fd, XXX_WHAT_EVER );      /* do the job. */
   ...
   flink(new_fd, "/some/path/some/file/name"); /* commit to fs */
   close(new_fd);  /* bye-bye */

   I beleive this can be more useful. Not only in naive tries to replace 
cp(1) with kernel ;-)

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

