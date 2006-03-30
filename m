Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWC3HUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWC3HUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWC3HUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:20:04 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:53088 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751203AbWC3HUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:20:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2KAnRwG/PEik6H3I7ofAfpkiL7nlm32wYY8IEwJQg0nbfreQKetXOKJIjXXzBsxSOqgAJbkIDE2PEkDhad0V4sAdWV9KiRph5dHUgQxhS0J6Dqw2iLHx8rCo3S6jDE5wMRdLIxEJTdDVG4JYz6d0e7qijwUIHnKk9kp4bSvluME=  ;
Message-ID: <442B5406.9060606@yahoo.com.au>
Date: Thu, 30 Mar 2006 14:44:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de>	<20060329143758.607c1ccc.akpm@osdl.org>	<Pine.LNX.4.64.0603291624420.27203@g5.osdl.org> <20060329180830.50666eff.akpm@osdl.org>
In-Reply-To: <20060329180830.50666eff.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Linus Torvalds <torvalds@osdl.org> wrote:
>
>>Right now "flags" doesn't do anything at all, and you should just pass in 
>>zero.
>>
>
>In that case perhaps we should be enforcing flags==0 so that future
>flags-using applications will reliably fail on old flags-not-understanding
>kernels.
>
>But that won't work if we later define a bit in flags to mean "behave like
>old kernels used to".  So perhaps we should require that bits 0-15 of
>`flags' be zero and not care about bits 16-31.
>
>IOW: it might be best to make `flags' just go away, and add new syscalls in
>the future as appropriate.
>

Well it is always going to transfer data from infd to outfd, isn't it?
If something comes up that does not do that, then that should be a new
syscall rather than a new flag.

flags just modify the manner of the transfer I think. Things should still
work if some flag is not supported, perhaps just not with optimal
performance. That said, unsupported flags probably should fail, shouldn't
they? The application / library could then retry with flags = 0.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
