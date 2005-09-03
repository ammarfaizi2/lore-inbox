Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbVICGFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbVICGFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVICGFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:05:16 -0400
Received: from smtpout.mac.com ([17.250.248.87]:29435 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161156AbVICGFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:05:14 -0400
In-Reply-To: <43193B46.6080806@zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com> <43193B46.6080806@zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B10085E6-F7EC-494F-8E73-33F62D36F4E3@mac.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 02:05:03 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 3, 2005, at 01:57:26, H. Peter Anvin wrote:
> Kyle Moffett wrote:
>
>>> The world would be so much nicer a place if user space were free
>>> to #include linux/* header files rather than keeping a
>>> per-project private copy of all kernel structs of interest.
>> Exactly!  This is why I want to create kcore/* and kabi/* that
>> define the appropriate types, then both userspace and the kernel
>> could use whatever types fit their fancy, defined in terms of the
>> __kcore_ and __kabi_ types, which could be _depended_ on to exist
>> because they are guaranteed not to conflict with other namespaces
>
> Agreed.  We should use well-defined namespaces that won't conflict.
> However, I think the __[us][0-9]+ namespace can be considered
> well-established.

True, however, IMNSHO it would be much better if the kcore/kabi stuff  
had
a _consistent_ namespace as well.  If every macro begins with "__KABI_"
and every type and function with "__kabi_" (With a few function-like  
macro
exceptions, of course), then it is trivial to see where it originally  
came
from and provides a standard naming scheme that external parties can  
kind
of rely upon.  It also means there are fewer exceptions to remember when
coding.  My thought for the __[us][0-9]+ types is that they should still
be defined in linux/types.h for compatibility (outside of __KERNEL__)  
and
based off the __kabi_* types.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare


