Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVEXLNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVEXLNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVEXLMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:12:13 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59266 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261995AbVEXLJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 07:09:27 -0400
Message-ID: <42930B64.2060105@freenet.de>
Date: Tue, 24 May 2005 13:09:24 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com>
In-Reply-To: <20050524093029.GA4390@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

>On Mon, May 23, 2005 at 07:30:20PM +0200, Carsten Otte wrote:
>  
>
>>diff -ruN linux-git/mm/filemap.h linux-git-xip/mm/filemap.h
>>--- linux-git/mm/filemap.h	1970-01-01 01:00:00.000000000 +0100
>>+++ linux-git-xip/mm/filemap.h	2005-05-23 19:01:27.000000000 +0200
>>@@ -0,0 +1,94 @@
>>+/*
>>+ *	linux/mm/filemap.c
>>+ *
>>    
>>
>
>I guess you meant "filemap.h" not "filemap.c" ? Shouldn't this be
>in include/linux instead ?
>  
>
Yea, Andrew Morton fixed this one while merging into -mm. Cut&Paste - sorry

> OK, though this leaves filemap.c alone which is good, I have to admit
>
>that this entire duplication of read/write routines really worries me.
>
>There has to be a third way.
>  
>
Well those carbon copied functions are -as Christoph pointed out- just
wrappers. In addition,
we don't have sync read/write, just aio_read/aio_write, readv/writev,
and sendfile.
We saved almost as much patches to filemap.c as we have added stuff to
filemap_xip:
cotte@cotte:~/patches$ cat v2/linux-2.6-xip-2-filemap.patch |wc -l
789
cotte@cotte:~/patches$ cat v3/linux-2.6-xip-2-filemap.patch |wc -l
868
Given that the copied wrappers add just 80 lines after all, I agree with
Christoph that this is
worth buying reduced complexity for.

cheers,
Carsten
