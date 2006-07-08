Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWGHKpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWGHKpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWGHKpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:45:19 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:9380 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751284AbWGHKpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:45:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TRhuTzARhyStKPbz7IUN8gGS0zsLOeS+vxRZ5xl/g+XULbBrjeobrRmhU4C+xY38bW41bM42Lgp7/1tUR1upimx8+tnOJn+nwt+nfai+A6btSzAg5gwXVfHOCHZVUAFRnjDBS0VTyEYkV/PQwmbip/X6ww8lYduUy+fDB79t6WM=  ;
Message-ID: <44AF532B.4050504@yahoo.com.au>
Date: Sat, 08 Jul 2006 16:39:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com> <Pine.LNX.4.64.0607072222540.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607072222540.3869@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> It's not that "volatile" is the "portable way". It's that "volatile" is 
> fundamentally not sufficient for the job.

However it does seem to be good for some things, as you say.

The volatile casting in atomic_* and *_bit seems to be a good idea
(now that I think about it) [1].

Because if you had a barrier there, you'd have to reload everything
used after an atomic_read or set_bit, etc.

But it might be nice to wrap that in something rather than use
volatile directly. force_reload(wordptr); maybe?

[1] Even though I still can't tell the exact semantics of these
     operations eg. why do we need volatile at all? why do we have
     volatile in the double underscore (non-atomic) versions?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
