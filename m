Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbWADS6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbWADS6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWADS6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:58:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:3261 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965269AbWADS6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:58:24 -0500
Message-ID: <43BC1AB8.3050801@zytor.com>
Date: Wed, 04 Jan 2006 10:58:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@suse.de>,
       "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without
 error
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de> <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com> <43BB5E22.2010306@zytor.com> <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org> <Pine.LNX.4.64.0601041033040.3668@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601041033040.3668@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 Jan 2006, Linus Torvalds wrote:
> 
>>On Tue, 3 Jan 2006, H. Peter Anvin wrote:
>>
>>>(I set the limit to 2^31-PAGE_CACHE_SIZE so that a transfer that starts at the
>>>beginning of the file will continue to be page-aligned.)
>>
>>Ok, this patch looks ok, if it's confirmed to unbreak apache.
> 
> Actually, looking closer, this patch does the wrong thing for a size_t 
> that is negative in ssize_t (which is technically "undefined behaviour" in 
> POSIX, but turning it into a big positive number is objectively worse than 
> returning -EINVAL).
> 

OK, that's a fair cop.  I agree.  In fact, for readv/writev(), POSIX 
does specify:

"If the sum of the iov_len values is greater than {SSIZE_MAX}, the 
operation shall fail and no data shall be tranferred."

... which is good precedence for doing so for all values.

So, what system calls are affected?  sendfile, [p]read[v], [p]write[v], 
send*, recv*, any others?

	-hpa
