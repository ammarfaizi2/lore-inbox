Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWJLHAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWJLHAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWJLHAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:00:50 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:22170 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422770AbWJLHAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:00:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qrhgqfWXQ0UMljmW2Lv0s62UtZzo9V0SRMZ3Kn4pck1M+BslCYLBrm20pgSoxzexIcs0DJRZm2Lw0b9lvagSjQgD4JiKPSljRWzDprRREtwh+EZ8PmvB0twFL8fxsS4uXhbyLAJdyIa5giCVr3amr4Y+ITRAW6tV5FrPl1RIGFc=  ;
Message-ID: <452DE82F.3080803@yahoo.com.au>
Date: Thu, 12 Oct 2006 17:01:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dmitriy Monakhov <dmonakhov@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, devel@openvz.org,
       ext2-devel@lists.sourceforge.net, Andrey Savochkin <saw@swsoft.com>
Subject: Re: [RFC][PATCH] EXT3: problem with page fault inside a transaction
References: <87mz82vzy1.fsf@sw.ru> <20061011234330.efae4265.akpm@osdl.org>
In-Reply-To: <20061011234330.efae4265.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 12 Oct 2006 09:57:26 +0400
> Dmitriy Monakhov <dmonakhov@openvz.org> wrote:
> 
> 
>>While reading Andrew's generic_file_buffered_write patches i've remembered
>>one more EXT3 issue.journal_start() in prepare_write() causes different ranking
>>violations if copy_from_user() triggers a page fault. It could cause 
>>GFP_FS allocation, re-entering into ext3 code possibly with a different
>>superblock and journal, ranking violation of journalling serialization 
>>and mmap_sem and page lock and all other kinds of funny consequences.
> 
> 
> With the stuff Nick and I are looking at, we won't take pagefaults inside
> prepare_write()/commit_write() any more.

Yep. Because the page is locked, it is too much to deal with even
without a filesystem in the picture.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
