Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRKGSF2>; Wed, 7 Nov 2001 13:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280885AbRKGSFS>; Wed, 7 Nov 2001 13:05:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61200 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280883AbRKGSFM>; Wed, 7 Nov 2001 13:05:12 -0500
Message-ID: <3BE97696.B7B28810@zip.com.au>
Date: Wed, 07 Nov 2001 09:59:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Tweedie <sct@redhat.com>
CC: "Steven N. Hirsch" <shirsch@adelphia.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-0.9.15 against linux-2.4.14
In-Reply-To: <3BE7AB6C.97749631@zip.com.au> <Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>,
		<Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>; from shirsch@adelphia.net on Tue, Nov 06, 2001 at 01:09:42PM -0500 <20011107003131.D7290@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Tweedie wrote:
> 
> Andrew, the code
> 
>         if (page->buffers) {
>                 /*
>                  * Anonymous buffercache page left behind by
>                  * truncate.
>                  */
>                 printk(__FUNCTION__ ": page has buffers!\n");
>                 goto preserve;
>         }
> 
> is going to end up preserving the pte forever and shouting to syslog
> every time the VM walks over the pte in question.  I'd be just as
> happy dropping these ptes on the floor when we find them, as they are
> clearly of no use to anybody at this point.
> 

Yes, perhaps we could do something smarter - I wasn't even sure it 
was possible to hit any more (still waiting to hear back from
Steve Hirsch!)

The idea is that in this rare case, shrink_cache() will at
some later time revisit the page and again try to remove its
buffers, and will succeed.   It's still on the LRU.

We definitely need to kill the printk(), but I really want
to get to test this code path locally.

-
