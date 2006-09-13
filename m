Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWIMFfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWIMFfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 01:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIMFfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 01:35:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:57553 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751577AbWIMFfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 01:35:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fp1OxvY7BwgpXqdhhUJ6KJuL0PQt7TAo6AeOtimBzdeUVRmB7XTzYdWt3oKiuYDsNHuaQhpbRJ1cABV3cvAyB+BXm1kd/3V6VqBJy3YVQ/29nqriL+BhKsosd5nMRpgoL6UCtnCmNIQfUQ8aL3iI8Pn4uKni6yHl/2yyJZHJk5Y=
Message-ID: <787b0d920609122235j57ac327ckcc8d08832fb3989c@mail.gmail.com>
Date: Wed, 13 Sep 2006 01:35:08 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: dwmw2@infradead.org, guest01@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: OT: calling kernel syscall manually
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> On Tue, 2006-09-12 at 14:05 +0200, guest01 wrote:

>> 3 -> using kernel directly
>>
>> Ok, the third one is a little bit tricky, at least for me.
>> I found an example for lseek, but I don't know how to convert
>> that for mkdir. I don't know the necessary arguments, ..
>
> The third one has always been broken on i386 for PIC code

No, I was just using it today in PIC i386 code.
The %ebx register gets pushed, the needed value
gets moved into %ebx, the int 0x80 is done, and
the %ebx register gets popped. Only a few odd
calls like clone() need something different.

(not that this should be needed: gcc is broken
if it can't save/restore the needed registers)

> and was pointless anyway, since glibc provides this
> functionality. The kernel method has been removed from
> userspace visibility all architectures, and we plan to
> remove it entirely in 2.6.19 since it's not at all useful.

It's damn useful. Hint: Linux does not require glibc.

I could hack up my own assembly. I did that for clone(),
but I didn't enjoy that waste of my time.
