Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWC3GUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWC3GUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWC3GUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:20:01 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:17269 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751127AbWC3GUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:20:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r214dpkKTVgXxaQHcn1BBTr6Ckqt+wwde8NoRol+GJ/sqbWfmJYwXBVXAw7vdGZ4WBrsF96Qv9vHxTo5WRAhjsoRy5MJb6B68RfR6BceYaeHV6wx/FJHiE8B6+UN2JOrtsY5UTXHzLLQmbLvj2ZmfSVzQFsWGge+kLtlDz45IYs=  ;
Message-ID: <442B4C1C.4030308@yahoo.com.au>
Date: Thu, 30 Mar 2006 14:10:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Wed, 29 Mar 2006, Andrew Morton wrote:
>
>>- splice() take a size_t length.  Should it be taking a 64-bit length?
>>
>
>No. You can't splice more than the kernel buffers anyway (ie currently 
>PIPE_BUFFERS pages, ie ~64kB, although in theory somebody could use large 
>pages for it), so 64-bit would be total overkill.
>
>

But in that case you'll just end up blocking on the pipe won't you? I
think Andrew's talking about the syscall itself, which should be 64-bit
surely.

Hmm, with no "offset" parameter, you cannot splice-sendfile >4GB files...
Or am I going crazy? I see, it uses f_pos. Should it use offsets instead?
I guess you covered this in your earlier sys_splice discussions. I'll do
some research.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
