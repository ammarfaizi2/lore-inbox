Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVJaUJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVJaUJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVJaUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:09:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964819AbVJaUJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:09:33 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 bitops fix for -Os
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
	<20051030192323.GF657@openzaurus.ucw.cz>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 31 Oct 2005 18:09:15 -0200
In-Reply-To: <20051030192323.GF657@openzaurus.ucw.cz> (Pavel Machek's
 message of "Sun, 30 Oct 2005 20:23:24 +0100")
Message-ID: <or8xw9v47o.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2005, Pavel Machek <pavel@suse.cz> wrote:

>> This patches fixes a bug that comes up when compiling the kernel for
>> x86_64 optimizing for size.  It affects 2.6.14 for sure, but I'm
>> pretty sure many earlier kernels are affected as well.

> Is the same problem in i386, too?

No, it doesn't use custom versions of find_first*bit.

>> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
>> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200
>> @@ -1,5 +1,11 @@
>> #include <linux/bitops.h>
>> 
>> +#define BITOPS_CHECK_UNDERFLOW_RANGE 0
>> +
>> +#if BITOPS_CHECK_UNDERFLOW_RANGE
>> +# include <linux/kernel.h>
>> +#endif

> Could you drop the ifdefs? Nice for debugging but we don't
> want them in mainline.

Are you absolutely sure we don't?  I'd almost left them in, enabled
unconditionally.  Note that the ifdef will make no difference
whatsoever for the case I've just fixed, but it would help catch any
other (ab)uses(?) elsewhere that may have gone unnoticed until now.

> Plus you want to add signed-off-by: header and send it to ak@suse.de.
> 				Pavel

Err...  The header was right there.  Or do you mean as an e-mail
header, as opposed to a regular line in the e-mail body?

I'll forward the patch to ak.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
