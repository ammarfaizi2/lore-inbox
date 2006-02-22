Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWBVBh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWBVBh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWBVBh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:37:26 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:56920 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161237AbWBVBhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:37:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r5ANsN0Eib+Q+O4cX44IxH0Azmo2QKv3zXlZrpZIic4TsIQyqMqvTPhm4OkqYtnwpecRC25DcfecJLmI7T2wNAjLTwit7I0ioxi5tqbaHowg5B8vbcmzf8lXGRjhTgteMb+ewpQ9oRaavSYgtUCoI+m7RQup8kObir9iXIBOwm8=  ;
Message-ID: <43FBB292.1000304@yahoo.com.au>
Date: Wed, 22 Feb 2006 11:38:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
CC: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au> <20060221233950.GB20872@localhost.localdomain>
In-Reply-To: <20060221233950.GB20872@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Tue, Feb 21, 2006 at 03:18:59PM +1100, Nick Piggin wrote:

>>This introduces
>>tree_lock(r) -> hugetlb_lock
>>
>>And we already have
>>hugetlb_lock -> lru_lock
>>
>>So we now have tree_lock(r) -> lru_lock, which would deadlock
>>against lru_lock -> tree_lock(w), right?
>>
>>From a quick glance it looks safe, but I'd _really_ rather not
>>introduce something like this.
> 
> 
> Urg.. good point.  I hadn't even thought of that consequence - I was
> more worried about whether I need i_lock or i_mutex to protect my
> updates to i_blocks.
> 
> Would hugetlb_lock -> tree_lock(r) be any preferable (I think that's a
> possible alternative).
> 

Yes I think that should avoid the introduction of new lock dependency.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
