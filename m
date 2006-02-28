Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWB1AeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWB1AeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWB1AeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:34:13 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:32430 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751856AbWB1AeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:34:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JT9CmAAStOYCWj/Apvb8RnOR6AVFRjhud8e6jNgj78dNx3Zv0foeFj8VNNi6x9DWIeydV/HfM9PrbfxyJlXmpaYQ3psc2aiDVgeO1d9acpbGB2y+XhVzj0MLLvkTI8OkgMmPWwAkyM9ZsP0LqsXjILC99kF5HAen8sn8RxA8R70=  ;
Message-ID: <44039A83.4050604@yahoo.com.au>
Date: Tue, 28 Feb 2006 11:34:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <200602261407.33262.ioe-lkml@rameria.de> <4401B233.7050308@yahoo.com.au> <44036670.7060204@namesys.com>
In-Reply-To: <44036670.7060204@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Sounds like the real problem is that glibc is doing filesystem
>optimizations without making them conditional on the filesystem type. 
>

I'm not sure that it should even be conditional on the filesystem type...
To me it seems silly to even bother doing it, although I guess there
is another level of buffering involved which might mean it makes more
sense.

>Does anyone know the email address of the glibc guy so we can ask him
>not to do that?
>
>

Ulrich Drepper I guess. But don't tell him I sent you ;)

>My entry for the ugliest thought of the day: I wonder if the kernel can
>test the glibc version and.....
>
>Hans
>
>Nick Piggin wrote:
>
>
>>Actually glibc tries to turn this pre-read off if the seek is to a page
>>aligned offset, presumably to handle this case. However a big write
>>would only have to RMW the first and last partial pages, so pre-reading
>>128KB in this case is wrong.
>>
>>And I would also say a 4K read is wrong as well, because a big read will
>>be less efficient due to the extra syscall and small IO.
>>
>>
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
