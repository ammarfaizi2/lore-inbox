Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUJATZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUJATZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUJATZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:25:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:26317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266200AbUJATXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:23:34 -0400
Date: Fri, 1 Oct 2004 12:23:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ivan Kalatchev <ivan.kalatchev@esg.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 bug in fs/locks.c
Message-ID: <20041001122332.E1973@build.pdx.osdl.net>
References: <000001c4a7d3$21c62bb0$2e646434@ivans>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c4a7d3$21c62bb0$2e646434@ivans>; from ivan.kalatchev@esg.ca on Fri, Oct 01, 2004 at 12:24:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivan Kalatchev (ivan.kalatchev@esg.ca) wrote:
> I'm using pthreads for each user-application connections. To protect
> configuration file from corruption I used file locking mechanism - fcntl
> with F_WRLCK/F_RDLCK.

I must be confused.  pthreads and fcntl locking...that does't give
proper exclusion?  The BUG, however, is no good.  Despite the fact
that it appears to come at the result of an application bug, we should
be able to handle this w/out a BUG.  AFAICT, one thread has closed the
file descriptor, whilst another is mucking with the locks.  So the locker
winds up holding the last ref to the filp.  This blows the logic of when
locks_remove_posix gets called.  Thanks for the bug report.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
