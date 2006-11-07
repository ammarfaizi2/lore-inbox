Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWKGPtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWKGPtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbWKGPtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:49:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59322 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1754069AbWKGPtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:49:32 -0500
Message-ID: <4550AB43.10704@us.ibm.com>
Date: Tue, 07 Nov 2006 09:50:27 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
CC: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to	 	PAGE_CACHE_SIZE
References: <454FAE0A.3070409@redhat.com>	 <1162852069.11030.70.camel@kleikamp.austin.ibm.com>	 <454FD2BE.2090302@us.ibm.com>	 <1162906845.8123.11.camel@kleikamp.austin.ibm.com> <1162913653.8123.13.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1162913653.8123.13.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
> On Tue, 2006-11-07 at 07:40 -0600, Dave Kleikamp wrote:
>   
>> It would probably be best to just set stat->blksize to the negotiated
>> buffer size.
>>     
>
> But be careful here.  I don't know how applications/glibc may behave if
> stat->blksize is not a power of 2.
>   
The man page is not particularly helpful either as it simply indicates:
    "The st_blksize field gives the preferred blocksize for efficient 
file system  I/O. "
but it appears that blksize would affects readdir performance more than 
read/write
(since read/write go through the pagecache and thus readpages/writepages
will request readahead/writebehind for many pages at a time) unless the 
application
opens the file direct i/o.
