Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVERPAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVERPAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVERO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:57:45 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9367 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262293AbVERO4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:56:53 -0400
Message-ID: <428B57AA.2030006@freenet.de>
Date: Wed, 18 May 2005 16:56:42 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org>
In-Reply-To: <20050518142707.GA23162@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> I don't like this read split at all. Please just define a completely
>
>separate entry point for read, xip_file_read except for verifying the
>iovecs you don't share any code.
>Similar please add a separate xip_file_mmap.
>Dito with xip_file_write.
>  
>
I do plainly agree that this would make the code more readable here.
But it has a significant downside:
Once you have a different set of file operations for either case, you
also need to have a different file_operations struct in each individual
filesystem using this. Also, this moves the check "do we have xip today?"
from here to the filesystem that needs to decide which file operations
struct to use.
Looking forward, there may be multiple filesystems using this which
leads to duplicating the need for this check.

>  
>
>>diff -ruN linux-git/mm/filemap.h linux-git-xip/mm/filemap.h
>>--- linux-git/mm/filemap.h	1970-01-01 01:00:00.000000000 +0100
>>+++ linux-git-xip/mm/filemap.h	2005-05-17 18:33:57.792451512 +0200
>>@@ -0,0 +1,141 @@
>>+/*
>>+ *	linux/mm/filemap.h
>>+ *
>>+ * Copyright (C) 2005 IBM Corporation
>>    
>>
>
>I think just adding an IBM copyright isn't fair.  Just copy it from
>filemap.c
>  
>
Agreed.

>
>You should probably use page_check_address().  Currently it's static in rmap.c,
>but that could be changed.
>  
>
Good point. This was derived from try_to_unmap_one before that one
was added. Btw: Should'nt this function move to rmap.c anyway?

