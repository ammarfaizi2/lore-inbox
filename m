Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWC3Cgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWC3Cgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWC3Cgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:36:47 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:14424 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751287AbWC3Cgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:36:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XOXJE2b/EJhmM6W6M5Wzwv7HOSk688cTVgApctByu7TbeOUufB7Bw1YvS0mWPQ63onMSMq7QlyjXYV8jfN3knMPgRCE7qc/kAcQSizJgm/gkM/S5EsG7cPogH7iJKZDZEFu6GWXe28zJ6NMugqmQgCE7igiqvw70tt7UzGKmJtM=  ;
Message-ID: <442B358A.4060805@yahoo.com.au>
Date: Thu, 30 Mar 2006 12:34:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Christoph Lameter <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603290645.k2T6jbg03728@unix-os.sc.intel.com>
In-Reply-To: <200603290645.k2T6jbg03728@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Nick Piggin wrote on Tuesday, March 28, 2006 6:36 PM
>
>>Hmm, not sure. Maybe a few new bitops with _lock / _unlock postfixes?
>>For page lock and buffer lock we'd just need test_and_set_bit_lock,
>>clear_bit_unlock, smp_mb__after_clear_bit_unlock.
>>
>>I don't know, _for_lock might be a better name. But it's getting long.
>>
>
>I think kernel needs all 4 variants:
>
>clear_bit
>clear_bit_lock
>clear_bit_unlock
>clear_bit_fence
>
>And the variant need to permutated on all other bit ops ...  I think it
>would be indeed a better API and be more explicit about the ordering.
>
>

We could just introduce them as required, though? clear_bit_fence shouldn't
be required for ia64 any longer, if you change bitops to be full barriers,
right?

And for now, let's just not let people open critical sections unless doing
a test_and_set, nor close them unless doing a plain clear?

It seems that memory ordering model seems to be almost too much for people
to cope with already, so would it be reasonable to require some performance
justification before adding more?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
