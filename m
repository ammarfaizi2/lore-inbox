Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTIDWEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTIDWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:04:50 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:38136 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264839AbTIDWEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:04:46 -0400
Date: Thu, 4 Sep 2003 16:03:44 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030904160344.E15623@schatzie.adilger.int>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
	reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com> <20030904132804.D15623@schatzie.adilger.int> <3F57AF79.1040702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F57AF79.1040702@namesys.com>; from reiser@namesys.com on Fri, Sep 05, 2003 at 01:32:41AM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 05, 2003  01:32 +0400, Hans Reiser wrote:
> Andreas Dilger wrote:
> >It is possible to do the same with ext3, namely exporting journal_start()
> >and journal_stop() (or some interface to them) to userspace so the application
> >can start a transaction for multiple operations.  We had discussed this in
> >the past, but decided not to do so because user applications can screw up in
> >so many ways, and if an application uses these interfaces it is possible to
> >deadlock the entire filesystem if the application isn't well behaved.
>
> That's why we confine it to a (finite #defined number) set of 
> operations within one sys_reiser4 call.  At some point we will allow 
> trusted user space processes to span multiple system calls (mail server 
> applicances, database appliances, etc., might find this useful).  You 
> might consider supporting sys_reiser4 at some point.

Ah, OK.  If you are confining the atom to a single syscall, then this is
a much easier problem to solve, assuming sys_reiser4() has a sufficiently
rich interface to express what people want to do.  It avoids all of the
potential problems that could arise if you want to keep a transaction
open over multiple syscalls.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

