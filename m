Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129077AbQJ3N5e>; Mon, 30 Oct 2000 08:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129120AbQJ3N5Y>; Mon, 30 Oct 2000 08:57:24 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61964 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129077AbQJ3N5J>;
	Mon, 30 Oct 2000 08:57:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17 
In-Reply-To: Your message of "Mon, 30 Oct 2000 13:41:40 -0000."
             <E13qFC1-0006t5-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 00:56:58 +1100
Message-ID: <4572.972914218@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 13:41:40 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>Keith Owens wrote
>> >You may find that creating your own wrappers for these files that do
>> >
>> >extern "C" {
>> >#define new new_
>> >#define private private_
>> >#include <linux/foo.h>
>> >#undef new
>> >#undef private
>> >}
>> >
>> >safer, since you won't break anything
>> 
>> It breaks module symbol versions, see earlier mail to l-k.
>
>I don't believe that is the case.
>
>You compute the modversions against the C header files. You include the C++
>header files in a C++ module and you include the module version file directly.
>Your symbols match providing you don't have an object called private or new
>that is globally exported. We don't seem to have any of those

There is a deficiency in modversions which has been there since the
start.  Symbol versions assume that the kernel header files and the
module version file are in sync but this has never been guaranteed.  I
have seen people compile (outside the kernel) with headers from kernel
2.2.x and modversions from kernel 2.3.x, the checksums "match" the 2.3
kernel so the module loaded but they used the wrong headers, splat!

As part of the 2.5 kbuild redesign, symbol versions will be completely
redone.  One of the things on my todo list is to detect this mismatch.
There are some problems in doing that which I may or may not be able to
overcome, but if the field names are different between C and C++ then I
can never detect this mismatch correctly.

Please do not use different structure field names in kernel and modules.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
