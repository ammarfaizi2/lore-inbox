Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVBQJAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVBQJAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVBQJAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:00:24 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:32938 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262258AbVBQJAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:00:18 -0500
Message-ID: <42145D1F.5000301@yahoo.com.au>
Date: Thu, 17 Feb 2005 20:00:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix possible race with 4level-fixup.h
References: <1108624747.5383.52.camel@gaston>	 <421456F1.6090100@yahoo.com.au> <1108629648.5425.73.camel@gaston>
In-Reply-To: <1108629648.5425.73.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>>Index: linux-work/include/asm-generic/4level-fixup.h
>>>===================================================================
>>>--- linux-work.orig/include/asm-generic/4level-fixup.h	2005-01-24 17:09:49.000000000 +1100
>>>+++ linux-work/include/asm-generic/4level-fixup.h	2005-02-17 18:10:38.000000000 +1100
>>>@@ -24,7 +24,7 @@
>>> #define pud_bad(pud)			0
>>> #define pud_present(pud)		1
>>> #define pud_ERROR(pud)			do { } while (0)
>>>-#define pud_clear(pud)			do { } while (0)
>>>+#define pud_clear(pud)			pgd_clear((pgd_t *)(pud))
>>> 
>>
>>Just a small nit - no cast needed here.
> 
> 
> Well, do you know ? pud is a pud_t* and the arch is free to implement
> pgd_clear as an inline with strong typing no ? 
> 

Yeah but if you're using the 4level-fixup.h header, then you get
#define pud_t    pgd_t

Not that I really mind, but in this header we've just avoided
doing casts for that reason.

Nick

