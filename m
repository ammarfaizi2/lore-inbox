Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWB0JD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWB0JD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWB0JD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:03:26 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:58496 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751701AbWB0JD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:03:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=p/Zmna0DvCtwfCAK9Mclu14bmXCV+jNkdgE/Ta6uj67qD88G6LWP/0ZSKyHP6F5C79Z8oGCaDhA6bYA0biE/Teo3RdVVqBlPt52igRU1wPrfNgwDl+qN9a+8czY2KmmcF41htj29aChdSBoT4zdgx0pcjrPwxDk1RUQ7xw8G4Z8=  ;
Message-ID: <4402C05A.2020404@yahoo.com.au>
Date: Mon, 27 Feb 2006 20:03:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page cache question
References: <4ae3c140602262345g43e71a2oea7db21c05dd5aba@mail.gmail.com>
In-Reply-To: <4ae3c140602262345g43e71a2oea7db21c05dd5aba@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> Sorry if this question is dumb.
> 
> Linux uses address_space to identify pages in the page cache. An
> address space is often associated with a memory object such as inode.
> That seems to associate the cached page with that inode. My question
> is: if a file is closed and the inode is destroyed, will the cached
> page be removed from page cache immediately?  If so, does that mean

Yes. The inode's struct address_space contains the radix tree which
indexes the pagecache pages.

> the file system has to load data from disk again if a user promptly
> open and read the same file again? If not, how does linux determine
> when to evict a cached page? using LRU?
> 

Yes they would have to be read again. However in general the inode is
not destroyed after the file is closed -- inodes are cached too.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
