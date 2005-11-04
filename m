Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbVKDHz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbVKDHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbVKDHz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:55:29 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:49274 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161095AbVKDHz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:55:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dSUJaCyWikgpLKBDqwpw5eu3H/SsNnPy+Auw3qsCj5qiQsc+Yi1odush5/JY5OZ8D39dyJLECqGS6Yxsc0iDMwKeQEqkAk2B1TlcACt15iqC/xA4evAyRyF4ooSx0gG3qq4BB/JoUf+6mZH72qqIllIdZSfndMAdodxOOj6nQTI=  ;
Message-ID: <436B146A.8020209@yahoo.com.au>
Date: Fri, 04 Nov 2005 18:57:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       notting@redhat.com
Subject: Re: [PATCH] core remove PageReserved
References: <200510300502.j9U52LE0027873@hera.kernel.org> <20051104044217.GA25858@redhat.com>
In-Reply-To: <20051104044217.GA25858@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Oct 29, 2005 at 10:02:22PM -0700, Linux Kernel wrote:
>  > tree 835836cb527ec9bd525f93eb7e016f3dfb8c8ae2
>  > parent f9c98d0287de42221c624482fd4f8d485c98ab22
>  > author Nick Piggin <nickpiggin@yahoo.com.au> Sun, 30 Oct 2005 08:16:12 -0700
>  > committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 30 Oct 2005 11:40:39 -0700
>  > 
>  > [PATCH] core remove PageReserved
>  > 
>  > Remove PageReserved() calls from core code by tightening VM_RESERVED
>  > handling in mm/ to cover PageReserved functionality.
>  > 
>  > PageReserved special casing is removed from get_page and put_page.
>  > 
>  > All setting and clearing of PageReserved is retained, and it is now flagged
>  > in the page_alloc checks to help ensure we don't introduce any refcount
>  > based freeing of Reserved pages.
>  > 
>  > MAP_PRIVATE, PROT_WRITE of VM_RESERVED regions is tentatively being
>  > deprecated.  We never completely handled it correctly anyway, and is be
>  > reintroduced in future if required (Hugh has a proof of concept).
> 
> We've got one user reporting that he's getting the following
> message..
> 
> "program ddcprobe is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory"
> since this cset.
> 
> So what should happen here, does that app need changing? Or do we just
> need to get Hugh's changes merged?
> 

Thanks for reporting this.

Can the app use MAP_SHARED? Or PROT_READ and copy the mapped page to
its own private one before modifying it?

It is likely to only be very specific userspace drivers and stuff
that would ever do this... but if they become a real problem then
Hugh's patch would be able to solve it. Though I'd like to try to
avoid relying on that if possible.

Perhaps the nice thing to do would be to include Hugh's patch *and*
display the warning message, and remove the functionality in a
later release.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
