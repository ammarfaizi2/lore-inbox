Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTKMTil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTKMTil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:38:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:50337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264400AbTKMTij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:38:39 -0500
Date: Thu, 13 Nov 2003 11:39:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mary Edie Meredith <maryedie@osdl.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, jenny@osdl.org
Subject: Re: Nick's scheduler v18
Message-Id: <20031113113906.65431b18.akpm@osdl.org>
In-Reply-To: <1068746827.1750.1358.camel@ibm-e.pdx.osdl.net>
References: <3FAFC8C6.8010709@cyberone.com.au>
	<1068746827.1750.1358.camel@ibm-e.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mary Edie Meredith <maryedie@osdl.org> wrote:
>
> Nick,
> 
> We ran your patch on STP against one of our database workloads (DBT3 on
> postgreSQL which uses file system rather than raw).
> 
> The test was able to compile, successfully start up the database,
> successfully load the database from source file, successfully run the
> power test (single stream update/query/delete).   
> 
> It failed, however at the next stage, where it starts 8 streams of query
> and one stream of updates/deletes where it ran for approximately 40
> minutes (usually takes over an hour to complete).  The updates appear to
> have completed and only queries were active at the time of failure.  See
> the error message below from the database log.
>
> ...
>
> PANIC:  fdatasync of log file 1, segment 81 failed: Input/output error
>

It's hard to see how a CPU scheduler change could cause fdatasync() to
return EIO.

What filesystem was being used?

If it was ext2 then perhaps you hit the recently-fixed block allocator
race.  That fix was merged after test9.  Please check the kernel logs for
any filesystem error messages.

Also, please retry the run, see if it is repeatable.

Thanks.
