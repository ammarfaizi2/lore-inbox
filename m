Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUK0VL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUK0VL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUK0VL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:11:56 -0500
Received: from hermes.domdv.de ([193.102.202.1]:5388 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261331AbUK0VLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:11:53 -0500
Message-ID: <41A8ED8F.5010402@domdv.de>
Date: Sat, 27 Nov 2004 22:11:43 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127210331.GB7857@mars.ravnborg.org>
In-Reply-To: <20041127210331.GB7857@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
> 
>>We've been discussing splitting the kernel headers into userspace API headers
>>and kernel internal headers and deprecating the __KERNEL__ macro. This will
>>permit a cleaner interface between the kernel and userspace; and one that's
>>easier to keep up to date.
>>
>>What we've come up with is this:
>>
>> (1) Create new directories in the linux sources to shadow existing include
>>     directories:
>>
>>	NEW DIRECTORY		DIRECTORY SHADOWED
>>	=============		==================
>>	include/user/		include/linux/
>>	include/user-*/		include/asm-*/
>>
>>     Note that this doesn't take account of the other directories under
>>     include/, but I don't think they're relevant.
> 
> 
> If we go for some resturcturing of include/ then we should get rid of
> the annoying asm symlink. Following layout deals with that:
> 
> include/<arch>/asm		<= Files from include/asm-<arch>
> include/<arch>/mach*		<= Files from include/mach-*
> 
> This layout solve the symlink issue in an elegant way.
> We need to do trivial changes to compiler options to make it work. Changing
> compiler options is much more relaible than using symlinks.
> 
> Then the userspace part would then be located in:
> include/<arch>/user-asm
> 

This complicates things for bi-arch architectures like x86_64 where one 
can use a dispatcher directory instead of a symlink to suit include/asm 
for 32bit as well as 64bit.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
