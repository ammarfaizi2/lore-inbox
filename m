Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTBUHJ0>; Fri, 21 Feb 2003 02:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTBUHJ0>; Fri, 21 Feb 2003 02:09:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1197 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267198AbTBUHJZ>; Fri, 21 Feb 2003 02:09:25 -0500
Date: Thu, 20 Feb 2003 23:19:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-ID: <17280000.1045811967@[10.10.2.4]>
In-Reply-To: <20030219101957.05088aa1.akpm@digeo.com>
References: <32720000.1045671824@[10.10.2.4]> <20030219101957.05088aa1.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm comparing 59-mjb6 to 61-mjb1 and notice some strange performance
>> differences that I can't explain ... not a big drop, but odd.
>> ...
>> 
>> 1562 .text.lock.file_table
>> 583 dentry_open
>> 551 get_empty_filp
> 
> The first one here is fget().  That's causing problems on ppc64 as well - the
> machine is spending as long in fget as it is in copy_foo_user() in dbench
> runs.
> 
> One possibility is that we're calling fget() more often than previously,
> although that would be rather odd.  Can you add the below patch, and monitor
> /proc/meminfo:nr_fgets?

Thanks for the patch, sorry it took me so long to get the testing done.

59: 4742165
61: 4743166

Pretty damned close ;-)

> If not that, then maybe some funny cacheline aliasing thing?

Mmm... you mean like something sharing the cacheline with the file lock?

M.

