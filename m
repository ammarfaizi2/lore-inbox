Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUKVW6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUKVW6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKVWzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:55:35 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58526 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261189AbUKVWwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:52:34 -0500
Message-ID: <41A25D53.9050909@tmr.com>
Date: Mon, 22 Nov 2004 16:42:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr><Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr> <20041122113328.GQ10340@devserv.devel.redhat.com>
In-Reply-To: <20041122113328.GQ10340@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Mon, Nov 22, 2004 at 12:03:56PM +0100, Jan Engelhardt wrote:
> 
>>>> What you can't do is e.g.
>>>>  va_list ap;
>>>>  va_start (ap, x);
>>>>  bar (x, ap);
>>>>  bar (x, ap);
>>>>  va_end (ap);
>>
>>In theory, you can't. But the way how GCC (and probably other compilers)
>>implement it, you can. Because "ap" is just a pointer (which fits into a
>>register, if I may add). As such, you can copy it, pass it multiple times, use
>>it multiple times, and whatever you like.
> 
> 
> That's exactly the wrong assumption.
> On some Linux architectures you can, on others you can't.
> Architectures where va_list is a char or void pointer include e.g.:
> i386, sparc*, ppc64, ia64
> Architectures where va_list is something different, usually struct { ... } va_list[1];
> or something similar:
> x86_64, ppc32, alpha, s390, s390x
> 
> In the latter case, you obviously can't do va_list dest = src and
> if you do bar (x, ap); the content of the struct pointed by ap is changed
> after the call, therefore you can't use it for other routines
> (as it depends on where exactly the called function stopped with va_arg).

Why can't you do dest=src? Assignment of struct to struct has been a 
part of C since earliest times. I used it in ~1990 in code which ran on 
Z80, Multics, M68k, VAX and Cray2, and it worked without any ifdefs (for 
that, there were "just a few" for other issues like 8 vs. 9 bit char, etc).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

