Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbVICPTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVICPTU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVICPTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:19:20 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:62356 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751467AbVICPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:19:20 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <4319BEF5.2070000@zytor.com>
Date: Sat, 03 Sep 2005 08:19:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com> <20050903055007.GA30966@codepoet.org> <43193A4F.5030906@zytor.com> <20050903064124.GA31400@codepoet.org>
In-Reply-To: <20050903064124.GA31400@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> That is certainly not what I was proposing.  Why are you bringing
> sys/stat.h into this?  The contents of sys/stat.h are entirely up
> to SUSv3 and the C library to worry about.  Nobody has proposed
> mucking with that.  I dunno about your C library, but mine
> doesn't include linux/* header files (not even sys/stat.h).  And
> I'd really like to fix uClibc to not use any asm/* either, since
> much of it is entirely unsuitable for user space.
> 

That's the whole problem here, isn't it, so let's fix it the sane way 
instead of putting Descartes before Dehorse.

Anyway, to answer your implied question is: since I explicitly don't 
have to worry about forward ABI compatibility, I expose the kernel ABI 
raw.  Thus I want to be able to use the kernel ABI directly, including 
for things like struct stat.  It poses a particularly interesting 
problem, actually, because the real stat system call is called stat64 on 
most platforms.

Thus, an ABIzed <linux/abi/stat.h> or whatever it's called might export 
  "struct __kabi_stat" and "struct __kabi_stat64" with the expectation 
that the caller would "#define __kabi_stat64 stat" if that is the 
version they want.  A typedef isn't good enough for C, since you can't 
typedef struct tags.

	-hpa
