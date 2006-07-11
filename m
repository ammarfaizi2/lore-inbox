Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWGKTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWGKTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWGKTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:31:29 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:16313 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751202AbWGKTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:31:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uPTEKb1tgui376EjLP1F6ffTcsse3m9FNUN3lmiRGpO8AS1cPPnkUnGKtgSuQlXwj0aCpuMFDPgqy4YAJxHI70DYJ0l7LSE/DNMIqI0OILYajWBCUiwnMuRWaE0pPPZ+30pA6qoKdMzzvZ9bBrNdyKedIFBCNp7/ODILN4v6GUE=  ;
Message-ID: <44B3A2D1.2010108@yahoo.com.au>
Date: Tue, 11 Jul 2006 23:08:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       oleg@tv-sign.ru, ioe-lkml@rameria.de
Subject: Re: [PATCH] de_thread: Use tsk not current.
References: <m1bqrwkb0u.fsf@ebiederm.dsl.xmission.com> <20060711031635.a6a1f759.akpm@osdl.org>
In-Reply-To: <20060711031635.a6a1f759.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 10 Jul 2006 22:42:25 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> 
>>Ingo Oeser pointed out that because current expands to an inline function it
>>is more space efficient and somewhat faster to simply keep a cached copy of
>>current in another variable.  This patch implements that for the de_thread
>>function.
>>
>>-	if (thread_group_empty(current))
>>+	if (thread_group_empty(tsk))
>>-	if (unlikely(current->group_leader == child_reaper))
>>-		child_reaper = current;
>>+	if (unlikely(tsk->group_leader == child_reaper))
>>+		child_reaper = tsk;
>>-	zap_other_threads(current);
>>+	zap_other_threads(tsk);
>> 	read_unlock(&tasklist_lock);
>>...
> 
> 
> This saves nearly 100 bytes of text on gcc-4.1.0/i686.

Why can't current be a pure function, I wonder?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
