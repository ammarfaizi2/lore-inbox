Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWHRSmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWHRSmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWHRSmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:42:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48360 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751435AbWHRSmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:42:11 -0400
Message-ID: <44E609F6.1090603@garzik.org>
Date: Fri, 18 Aug 2006 14:41:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Chuck Lever <chucklever@gmail.com>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] NFS: Use local caching [try #12]
References: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>	 <20060818153514.29482.78513.stgit@warthog.cambridge.redhat.com> <76bd70e30608180843m536e9f57y90e1915f40f85b2@mail.gmail.com>
In-Reply-To: <76bd70e30608180843m536e9f57y90e1915f40f85b2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> Hi David-
> 
> On 8/18/06, David Howells <dhowells@redhat.com> wrote:
>> The attached patch makes it possible for the NFS filesystem to make 
>> use of the
>> network filesystem local caching service (FS-Cache).
>>
>> To be able to use this, an updated mount program is required.  This 
>> can be
>> obtained from:
>>
>>         http://people.redhat.com/steved/cachefs/util-linux/
>>
>> To mount an NFS filesystem to use caching, add an "fsc" option to the 
>> mount:
>>
>>         mount warthog:/ /a -o fsc
>>
>> Signed-Off-By: David Howells <dhowells@redhat.com>
>> ---
>>
>>  fs/Kconfig                 |    7 +
>>  fs/nfs/Makefile            |    1
>>  fs/nfs/client.c            |   11 +
>>  fs/nfs/file.c              |   49 ++++-
>>  fs/nfs/fscache.c           |  348 ++++++++++++++++++++++++++++++++
>>  fs/nfs/fscache.h           |  476 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  fs/nfs/inode.c             |   21 ++
>>  fs/nfs/internal.h          |   32 +++
>>  fs/nfs/pagelist.c          |    3
>>  fs/nfs/read.c              |   30 +++
>>  fs/nfs/super.c             |    1
>>  fs/nfs/sysctl.c            |   43 ++++
>>  fs/nfs/write.c             |   11 +
>>  include/linux/nfs4_mount.h |    1
>>  include/linux/nfs_fs.h     |    5
>>  include/linux/nfs_fs_sb.h  |    5
>>  include/linux/nfs_mount.h  |    1
>>  17 files changed, 1035 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
>> new file mode 100644
>> index 0000000..94d5e3a
>> --- /dev/null
>> +++ b/fs/nfs/fscache.c
>> @@ -0,0 +1,348 @@
>> +/* fscache.c: NFS filesystem cache interface
>> + *
>> + * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
>> + * Written by David Howells (dhowells@redhat.com)
>> + *
> 
>> +
>> +static uint16_t nfs_server_get_key(const void *cookie_netfs_data,
>> +                                  void *buffer, uint16_t bufmax)
>> +{
> 
> Why don't you use the function declaration style that is used in the
> rest of the NFS client?  All the parameters belong on one line, don't
> they?

Normally, one wraps the line if it exceeds 80 columns...

	Jeff



