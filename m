Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbQLGASK>; Wed, 6 Dec 2000 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131470AbQLGAR7>; Wed, 6 Dec 2000 19:17:59 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:40819 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131455AbQLGARr>;
	Wed, 6 Dec 2000 19:17:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgn@somanetworks.com
cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, sct@dcs.ed.ac.uk
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: Your message of "Wed, 06 Dec 2000 17:24:58 CDT."
             <14894.48314.363938.770481@somanetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Dec 2000 10:46:09 +1100
Message-ID: <1348.976146369@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000 17:24:58 -0500 (EST), 
"Georg Nikodym" <georgn@somanetworks.com> wrote:
>sysklogd 1.3-31 no longer compiles using the latest headers in test11.
>
>Strictly speaking this isn't a kernel bug...
>
>sysklogd's ksym_mod.c includes <linux/module.h>

Speaking as the modutils maintainer and the person who added list.h to
module.h, sysklogd should *not* be including linux/module.h.  Linus has
spoken, it is an error for user space applications to include kernel
headers.  Even modutils does not include linux/module.h, instead it has
a portable (2.0 through 2.4) local definition of struct module.

ksym_mod.c is only present to try to decode oops reports in klogd.
klogd only handles some architectures, it often gets the oops decode
wrong and it destroys the log information that is needed by other oops
decoders.  IMNSHO ksymoops does a much better job of decoding the oops,
but I maintain ksymoops so I am just a little biased ;)

I would prefer to see the oops decoding completely removed from klogd.
The only justification for klogd converting the oops is to save users
from running ksymoops by hand.  I would not mind klogd capturing the
oops text, forking to run ksymoops then logging the ksymoops output.
Just as along as the original text was left alone and the ksymoops
output was obviously distinguished from real kernel output.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
