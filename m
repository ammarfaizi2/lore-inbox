Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUKWJq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUKWJq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUKWJq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:46:26 -0500
Received: from mail.dif.dk ([193.138.115.101]:188 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261286AbUKWJqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:46:20 -0500
Message-ID: <41A30612.2040700@dif.dk>
Date: Tue, 23 Nov 2004 10:42:42 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable
 in fs/fcntl.c
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost> <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sun, Nov 21, 2004 at 11:55:23PM +0100, Jesper Juhl wrote:
> 
>>This patch removes a pointless comparison. "arg" is an unsigned long, thus 
>>it can never be <0, so testing that is pointless.
>>
>>Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>>
>> 	case F_SETSIG:
>> 		/* arg == 0 restores default behaviour. */
>>-		if (arg < 0 || arg > _NSIG) {
>>+		if (arg > _NSIG) {
>> 			break;
> 
> 
> I've seen patches like this before.  I'm generally in favour of removing
> the unnecessary test, but Linus rejected it on the grounds the compiler
> shouldn't be warning about it and it's better to be more explicit about
> the range test.  Maybe he's changed his mind between then and now ;-)
> 
Let's find out.
Linus, would you accept patches like this?

I've been building recent kernels with -W and there are tons of places 
with similar comparisons like the one above, as well as places where 
signed and unsigned values are compared, places where values are 
potentially truncated in signed/unsigned assignments and similar.
At the very least a review of these code locations to make sure they are 
all safe would make sense, and I think it would also make sense to get 
rid of the comparisons that always evaluate true or false due to the 
signedness or range of datatypes.
I probably won't be able to properly evaluate/review *all* the instances 
of this in the kernel, but I don't mind spending some time reviewing 
what I can and submit patches, but I don't want to waste my time with it 
if you already know up-front that you'll just be dropping all such 
patches. Or is this up to the individual maintainers to accept/reject? 
If so, then I'll go ahead and submit patches, then the individual 
maintainers can ack/nack as they please.

Comments?


--
Jesper Juhl



