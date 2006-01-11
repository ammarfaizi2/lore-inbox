Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWAKJj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWAKJj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWAKJj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:39:29 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:47253 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751407AbWAKJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:39:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4GmVtrAiMcX6g19q5Ppnh9yVkZEnggYU7SPbIi4bK0BMNox1hqlBKvET/3k1vyGYBbjE951Dqr9HAwNstME7U4IOsTqZePWygjleNCEa2qZUBKcGNPALFy07r498QwLRA6MBWKJMpSe5zGmaTOqxgKrDf8iCZ6EBHGJL053Xo9Y=  ;
Message-ID: <43C4D24B.8040007@yahoo.com.au>
Date: Wed, 11 Jan 2006 20:39:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random> <20060110062425.GA15897@opteron.random> <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random> <20060111005134.3306b69a.akpm@osdl.org> <20060111090225.GY15897@opteron.random>
In-Reply-To: <20060111090225.GY15897@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> The main scary thing as far as I can tell, is the blocking lock_page. We
> can't just do TryLockPage...
> 

Hopefully that should be OK... it should not tend to get tripped up on read
because filemap_nopage needs to take the lock and wait in that case anyway.
Hopefully other lock_page users will be in the noise?

Another option might be a spinbit in page->flags but that seems like overkill.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
