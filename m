Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTKNFpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTKNFpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:45:42 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:48551 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264510AbTKNFpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:45:40 -0500
Message-ID: <3FB46C00.6050104@cyberone.com.au>
Date: Fri, 14 Nov 2003 16:45:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mary Edie Meredith <maryedie@osdl.org>, linux-kernel@vger.kernel.org,
       jenny@osdl.org
Subject: Re: Nick's scheduler v18
References: <3FAFC8C6.8010709@cyberone.com.au>	<1068746827.1750.1358.camel@ibm-e.pdx.osdl.net> <20031113113906.65431b18.akpm@osdl.org>
In-Reply-To: <20031113113906.65431b18.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Mary Edie Meredith <maryedie@osdl.org> wrote:
>
>>Nick,
>>
>>We ran your patch on STP against one of our database workloads (DBT3 on
>>postgreSQL which uses file system rather than raw).
>>
>>The test was able to compile, successfully start up the database,
>>successfully load the database from source file, successfully run the
>>power test (single stream update/query/delete).   
>>
>>It failed, however at the next stage, where it starts 8 streams of query
>>and one stream of updates/deletes where it ran for approximately 40
>>minutes (usually takes over an hour to complete).  The updates appear to
>>have completed and only queries were active at the time of failure.  See
>>the error message below from the database log.
>>
>>...
>>
>>PANIC:  fdatasync of log file 1, segment 81 failed: Input/output error
>>
>>
>
>It's hard to see how a CPU scheduler change could cause fdatasync() to
>return EIO.
>
>What filesystem was being used?
>
>If it was ext2 then perhaps you hit the recently-fixed block allocator
>race.  That fix was merged after test9.  Please check the kernel logs for
>any filesystem error messages.
>

The kernel tested was test9-bk14 + my patch.

I don't think it would be due to a problem my patch. Perhaps different
scheduling patterns made some race more likely though.

>
>Also, please retry the run, see if it is repeatable.
>

I will let someone else take over from here ;) I'll run the test
again with the latest bk when I submit another round of STP tests
sometime.


