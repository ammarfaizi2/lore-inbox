Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUJ0Pll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUJ0Pll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUJ0PhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:37:25 -0400
Received: from zamok.crans.org ([138.231.136.6]:5099 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262492AbUJ0PgS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:36:18 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
	<87hdogvku7.fsf@barad-dur.crans.org>
	<20041026222650.596eddd8.akpm@osdl.org>
	<20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 27 Oct 2004 17:36:14 +0200
In-Reply-To: <20041027064146.GG15910@suse.de> (Jens Axboe's message of "Wed,
	27 Oct 2004 08:41:46 +0200")
Message-ID: <877jpcgolt.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> disait dernièrement que :


> This feels pretty icky, but should suffice for testing. Does it make a
> difference?
>
> --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.866931262 +0200
> +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:41:20.292172299 +0200
> @@ -987,8 +987,8 @@
>  	isize = i_size_read(inode);
>  	if (bytes_todo > (isize - offset))
>  		bytes_todo = isize - offset;
> -	if (!bytes_todo)
> -		return 0;
> +	if (bytes_todo < PAGE_SIZE)
> +		bytes_todo = PAGE_SIZE;
>  
>  	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
>  		user_addr = (unsigned long)iov[seg].iov_base;

As 2.6.10-rc1-mm1 failed (as expected), I tried tour fix applied upon
2.6.10-rc1-mm1. This did not make any difference.
The only workaround for now is backing out dio-handle-eof-fix.patch and
dio-handle-eof.patch
I am willing to test anything you could send :)

Best regards,

Mathieu

-- 
panic("esp_handle: current_SC == penguin within interrupt!");
        linux-2.2.16/drivers/scsi/esp.c

