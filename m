Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbUK0DFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUK0DFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUK0DFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:05:52 -0500
Received: from neopsis.com ([213.239.204.14]:23445 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S263091AbUK0CDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 21:03:52 -0500
Message-ID: <41A7E085.8050704@dbservice.com>
Date: Sat, 27 Nov 2004 03:03:49 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <Pine.LNX.4.60.0411270049520.29718@alpha.polcom.net> <41A7D814.6060900@dbservice.com> <Pine.LNX.4.60.0411270234520.13348@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.60.0411270234520.13348@alpha.polcom.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> Ok, so maybe do it in this way:
> 1. common headers (included by 2. and 3.)
> 2. kernel headers (things only for kernel + included 1.)
> 3. userspace headers (things only for userspace + included 1.)

Are there really any definitions that belong _only_ to userspace?
AFAIK all that is in the kernel sources is used by the kernel, so
there are no headers that would fit into your category 3. There is
no reason to put such things into the kernel sources.

> Are you talking about breaking userspace (API and ABI) compatibility? 
> And possibly breaking compatibility with older versions of standards? I 
> do not think it could happen. (Well at least not for common widely-used 
> APIs).
> 
> Instead we can place such userspace only hacks in 3.

The API can be changed, I don't see any problems with the API
compatibility, if you document all changes then it's no problem for
the developers to change their code.
And the ABI? Well, I compile my kernel by myself, as I do all my 
userspace (gentoo). And the distributions still could define
__DEPRECATED__ (or something similar).

I mean.. come on.. how hard is it to change some lines of code,
some structure names, some function arguments.
I know that there's a problem if you have binary only files, but
I doubt that anyone is running a exe that was compiled for against
kernel 2.0 and every big company compiles their projects against each
stable kernel line.
Oh.. and I forgot, you usually don't include the kernel headers in your
'hello world' program, most of the applications use (g)libc, one big
library, so you'd need to change only very few projects, although I
admit that can be rather big projects, but still...

BTW, how much smaller would the kernel be if we removed all the
backwards compatibility? I mean the size of the compiled kernel
image.

tom
