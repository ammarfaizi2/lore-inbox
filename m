Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWDMHdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWDMHdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWDMHdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:33:20 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:18864 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964819AbWDMHdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:33:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pbPnMyT8lXv8IWSDfbth2ulOGWHATU+6PMukNEslAXRtp0pHXuhPuKpJnSKalJ38r3IxMivzjLpeXoXEpit5fXe8TxBUbTJlv+M4GSVgSYCXVfgefZYfjTDS1vGc4NO/2xBcVZuDeKw5wmaUAExau1czkxoJOLpStMlnXHqZWXA=  ;
Message-ID: <443DE2BD.1080103@yahoo.com.au>
Date: Thu, 13 Apr 2006 15:33:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> <20060412214613.404cf49f.akpm@osdl.org>
In-Reply-To: <20060412214613.404cf49f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> OK, there _might_ be a real-world case: threads appending logging
> information to a flat file.  Trivially workable-around with a userspace
> lock, or by switching to stdio (same thing).
> 
> Yes, really we should fix it.  But it's not worth adding more overhead to
> do so.  So the fix would involve widespread (but simple) change, to draw
> that f_pos update inside i_mutex.

Didn't Linus explicitly made the decision not to add synchronisation for
writes with the same file?

http://groups.google.com/group/fa.linux.kernel/msg/ef66c762e737bab7?hl=en&
Is the closest I could find, but I'm sure he said something similar,
specifically about write(2) vs write(2).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
