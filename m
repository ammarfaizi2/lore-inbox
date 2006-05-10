Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWEJDvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWEJDvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWEJDvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:51:03 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:9873 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964798AbWEJDvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:51:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IW28lttt+QFufS75a1vOuXtfXWngAviKU4Sm1wYv/MqsCymRv5JuPjrs8WuY8Z+nP+8nz8CfB0vgS0XSULf53QRNfzDpg6cyOV9h3wS5RB7yXqjJHh5f9rwcBd0ju2DlkPZAotJ8UyUB06A76tt465R4Sdui01FMsj8zkjMwv9g=  ;
Message-ID: <44616321.2000404@yahoo.com.au>
Date: Wed, 10 May 2006 13:50:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
References: <200605021200.37424.rjw@sisk.pl> <20060509003334.70771572.akpm@osdl.org> <200605091219.17386.rjw@sisk.pl> <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>On Tue, 9 May 2006, Rafael J. Wysocki wrote:
>
>>On Tuesday 09 May 2006 09:33, Andrew Morton wrote:
>>    
>>
>>>task_struct.mm can sometimes be NULL.  This function assumes that it will
>>>never be NULL.  That makes it a somewhat risky interface.  Are we sure it
>>>can never be NULL?
>>>
>>Well, now it's only called for task == current, but I can add a check.
>>
>
>Better fold it into the (renamed and recommented) page_to_copy,
>applying only to current.
>
>The "use" of page_table_lock there is totally bogus.  Normally you
>need down_read(&current->mm->mmap_sem) to walk that vma chain; but
>I'm guessing you have everything sufficiently frozen here that you
>don't need that.
>

I have to admit that I suggested making this change, because the
function was sufficently generic looking. I guess the mm == NULL
case should logically return 0... unless you did that, making
page_mapped_by_task use current still leaves the burden of ensuring
->mm != NULL on the caller.

But I don't much mind which way the consensus goes.

---

Send instant messages to your online friends http://au.messenger.yahoo.com 
