Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWC3See@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWC3See (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWC3See
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:34:34 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:26471 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750753AbWC3Sed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:34:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DniFEou6F2fgItrovu2FOGxKKyiYJJhFyhN1uDQCJ/TBiVaZFKLLstnm7IF0+XNMXpfo1Zj9VG8KiI2uN8FJbDTTb5QvVB5hdKb4VZpiAuYmmE0XhjPb5LgIh219+ERpBQaRjWcJRYuexlcN3f+FrhS/ThBtkauFaVOmspz/6IM=  ;
Message-ID: <442B9BD5.7030101@yahoo.com.au>
Date: Thu, 30 Mar 2006 18:50:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de>	<20060329143758.607c1ccc.akpm@osdl.org>	<20060330074534.GL13476@suse.de>	<20060330000240.156f4933.akpm@osdl.org>	<20060330081008.GO13476@suse.de> <20060330002726.48cf0ffb.akpm@osdl.org>
In-Reply-To: <20060330002726.48cf0ffb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:

>> It doesn't, I'm assuming that find_get_pages() returns consequtive pages
>> atm. Would seem like the sane interface :-)
> 
> 
> Yeah, sorry.  It's a "gather what's presently there" thing.  For writeback.
> 
> Nick has some gang-lookup-slots code.  So instead of populating an array of
> page*'s you can populate an array of (effectively) page**'s.  Then one
> could walk that.   All while holding ->tree_lock.    This doesn't help ;)
> 

Actually while we're on the subject, my gang_lookup_slot code is just
named to match lookup_slot and gang_lookup... it still only returns
slots that are presently populated. Suggestions for a better name
welcome?

> Probably the simplest for now is an open-coded find_get_page() loop.  Later

Agreed. I think that's the best idea for now.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
