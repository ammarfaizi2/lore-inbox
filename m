Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWJFUZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWJFUZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422928AbWJFUZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:25:15 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:12188 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422926AbWJFUZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:25:13 -0400
Date: Fri, 6 Oct 2006 22:18:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
cc: "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>,
       Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
In-Reply-To: <20061006143555.GC14186@rhun.haifa.ibm.com>
Message-ID: <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
 <20061006143555.GC14186@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-2141548496-1160165937=:30417"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-2141548496-1160165937=:30417
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


>> -	(void) kmem_cache_destroy(cache);
>> +	kmem_cache_destroy(cache);
>> 
>> I believe that the point of the (void) is to prevent lint from
>> squawking, and perhaps some picky ANSI-C compilers. What is the overall
>> Linux policy on this?
>
>IMHO there's another reason to do this which is much more relevant: it
>tells the reader that whoever wrote it knows that it returns a value
>and ignores it on purpose.

And GCC does not care about that, i.e. it still prints foritfy warnings, 
as in:

$ svn co https://svn.sourceforge.net/svnroot/ttyrpld/trunk a && cd a
$ make user/rpld.o EXT_CFLAGS="-D_FORTIFY_SOURCE=2"
user/rpld.c:425: warning: ignoring return value of ‘write’, declared 
with attribute warn_unused_result

Adding (void) to the front to line 425 does not get rid of the warning. 
So doing so does not seem to be the right way to let others know you 
intentionally want to discard the return value. Plus, on top, many 
(sometimes older) C books advise to cast to (void) just because 
something does not return it.



	-`J'
-- 
--1283855629-2141548496-1160165937=:30417--
