Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUEFSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUEFSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEFSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:13:59 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:58242 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261832AbUEFSN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:13:57 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Kopytov <alexeyk@mysql.com>, linuxram@us.ibm.com,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040506014307.1a97d23b.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1083867233.2420.29.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 11:13:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 01:43, Andrew Morton wrote:

> 
> One thing I note about this test is that it generates a huge number of
> inode writes.  atime updates from the reads and mtime updates from the
> writes.  Suppressing them doesn't actually make a lot of performance
> difference, but that is with writeback caching enabled.  I expect that with
> a writethrough cache these will really hurt.

Perhaps.  By the way is there a way to disable update time modification
as well ?  It would make quite a good sense for partition used for
Database needs - you do not need last modification time in most cases.

> 
> The test uses 128 files, which seems excessive.  I assume that four or
> eight files is a more likely real-life setup, and in theis case the
> atime/mtime update volume will be proportionately less.

Actually both single (or very few) files and large amount of files are
practical setup. In MySQL 4.1 we have the option to store each Innodb
table in its own file, which will mean scattered random IO to many files
for OLTP workloads. 

You might think 128 actively used tables are still to much, but
practically we see even larger numbers - some customers partition data,
creating huge number of tables with same structure, for example
table-per customer.



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



