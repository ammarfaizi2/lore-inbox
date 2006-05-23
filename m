Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWEWI3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEWI3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWEWI3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:29:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24263 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932114AbWEWI3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:29:49 -0400
Message-ID: <4472C7E1.3060004@themaw.net>
Date: Tue, 23 May 2006 16:29:21 +0800
From: Ian Kent <raven@themaw.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu,
       Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use	aio_read/aio_write
 instead
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>	 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>	 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>	 <20060521180037.3c8f2847.akpm@osdl.org>	 <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>	 <20060522100640.0710f7da.akpm@osdl.org> <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Mon, 2006-05-22 at 10:06 -0700, Andrew Morton wrote:
>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>> On Sun, 2006-05-21 at 18:00 -0700, Andrew Morton wrote:
>>>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>>>> This patch removes readv() and writev() methods and replaces
>>>>>  them with aio_read()/aio_write() methods.
>>>> And it breaks autofs4
>>>>
>>>> autofs: pipe file descriptor does not contain proper ops
>>>>
>>> Any easy test case to reproduce the problem ?
>>>
>> Grab an FC5 setup, copy RH's .config into your tree.
> 
> Will do. 
> 
> Like I mentioned, I am travelling this week. I would really
> appreciate if someone could test my updated patch (I sent out
> in my earlier mail).

Doesn't seem to apply to 2.6.17-rc4.

[raven@raven linux-2.6.16]$ patch -p1 < 
~/remove-readv_writev-methods-and-use-aio_read_aio_write.patch
patching file drivers/char/raw.c
Hunk #1 succeeded at 270 (offset 12 lines).
patching file drivers/net/tun.c
patching file fs/bad_inode.c
patching file fs/block_dev.c
Hunk #1 succeeded at 1101 (offset 8 lines).
patching file fs/cifs/cifsfs.c
Hunk #1 FAILED at 484.
1 out of 3 hunks FAILED -- saving rejects to file fs/cifs/cifsfs.c.rej
patching file fs/compat.c
patching file fs/ext2/file.c
patching file fs/ext3/file.c
Hunk #1 succeeded at 111 (offset -1 lines).
patching file fs/fat/file.c
patching file fs/fuse/dev.c
patching file fs/hostfs/hostfs_kern.c
patching file fs/jfs/file.c
patching file fs/ntfs/file.c
Hunk #1 succeeded at 2298 (offset 2 lines).
patching file fs/pipe.c
patching file fs/read_write.c
Hunk #2 succeeded at 439 (offset -12 lines).
Hunk #4 succeeded at 574 (offset -12 lines).
Hunk #6 succeeded at 619 (offset -12 lines).
patching file fs/read_write.h
patching file fs/xfs/linux-2.6/xfs_file.c
Hunk #1 succeeded at 131 with fuzz 1 (offset 2 lines).
Hunk #3 succeeded at 513 (offset 2 lines).
patching file include/linux/fs.h
patching file mm/filemap.c
Hunk #1 succeeded at 2300 (offset 2 lines).
patching file net/socket.c
Hunk #3 FAILED at 732.
Hunk #4 FAILED at 774.
2 out of 4 hunks FAILED -- saving rejects to file net/socket.c.rej
patching file sound/core/pcm_native.c
[raven@raven linux-2.6.16]$

Ian
