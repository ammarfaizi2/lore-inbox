Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVG0PCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVG0PCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVG0PCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:02:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6340 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262106AbVG0PCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:02:07 -0400
Message-ID: <42E7A157.3080508@redhat.com>
Date: Wed, 27 Jul 2005 10:59:35 -0400
From: Kimball Murray <kmurray@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
References: <20050726145344.GO3160@stusta.de> <20050727142912.GJ6920@suse.de>
In-Reply-To: <20050727142912.GJ6920@suse.de>
Content-Type: multipart/mixed;
 boundary="------------040307000101050808070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040307000101050808070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

>On Tue, Jul 26 2005, Adrian Bunk wrote:
>  
>
>>"extern inline" doesn't make much sense.
>>    
>>
>
>Yep, thanks.
>
>  
>
IIRC, there was a time when the extern inline construct was used to 
catch cases where the compiler did not inline the function (you'd get a 
link error).  Seems like it still works.  Try building the attached 
files in each of the following ways:

gcc -o foo foo.c

    and

gcc -O2 -o foo foo.c

In the first case, you get a link error, because there is no inlining.

-kimball

--------------040307000101050808070001
Content-Type: text/plain;
 name="foo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.c"

#include "bar.h"

void foo(void) {
	bar();
}

int main(int argc, char *argv[])
{
	foo();
	return 0;
}

--------------040307000101050808070001
Content-Type: text/plain;
 name="bar.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bar.h"

extern inline void bar(void)
{
}

--------------040307000101050808070001--

