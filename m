Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUJQNtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUJQNtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269132AbUJQNtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:49:35 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:61546 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269129AbUJQNtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:49:32 -0400
Message-ID: <41727866.3000009@yahoo.com.au>
Date: Sun, 17 Oct 2004 23:49:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org> <4171E978.6060207@pobox.com> <41720740.2030901@yahoo.com.au> <417273F9.6050605@pobox.com>
In-Reply-To: <417273F9.6050605@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Nick Piggin wrote:
> 
>> Hi Jeff, my patch has gone to Linus... but if you have time can
>> you just verify that it works without the added cond_resched()
>> please?
>>
>> Thanks.
> 
> 
> 
> Wouldn't akpm's patch be better?
> 

Doesn't actually fix the problem. Well *sigh*, it does but it doesn't
if you know what I mean. It "fixed" the problem because your other
(non-empty) zones will now increase total_scanned, which means the busy
loop will turn into a sleepy loop and you don't notice a problem.

> I would tend to prefer that a one-liner hang fix go into -final, as it's 
> easier to review and verify at this late stage.
> 

Apart from the above, akpm's patch does fix *a* bug, but actually changes
much more common case code a lot more than my patch, and has less obvious
consequences. It really wants a full cycle for performance regressions to
appear.
