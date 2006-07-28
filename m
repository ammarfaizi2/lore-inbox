Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161373AbWG1XtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161373AbWG1XtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161389AbWG1XtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:49:08 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:34933 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161373AbWG1XtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NkrS7i1w17FF6r/QyDACsspaVdELssvEqafss+sv4mcgQkNJ0tjZ7sezykQlubjADcXLGLTti/e/B004j+KC4aDRbwMY00yWKXa7P1Z2P84fya/71TaSp4hqucEKuQ10XTlF8S7fB97r2wAlXLufes8kqOFCJ6s/2Zz+MzeSiwU=  ;
Message-ID: <44CAA26D.7030809@yahoo.com.au>
Date: Sat, 29 Jul 2006 09:49:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: nhorman@tuxdriver.com
CC: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org, paulus@au.ibm.com
Subject: Re: [KJ] audit return code handling for kernel_thread [1/11]
References: <200607282007.k6SK75MK009573@ra.tuxdriver.com>
In-Reply-To: <200607282007.k6SK75MK009573@ra.tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nhorman@tuxdriver.com wrote:
> Audit/Cleanup of kernel_thread calls, specifically checking of return codes.
>     Problems seemed to fall into 3 main categories:
>     

Thanks for doing this. Nitpick: this should be all one patch, or at most 3
patches (then each of the below 3 items would become individual changelogs).

Each patch should have a unique changelog, each should have a unique subject
(sans the sequence number).

cc'ing Andrew is also a good idea, if you want them to get merged ;)

One coding style comment:
if (...)
     multi line
         statement

Could use braces around the outermost if statement, for clarity.


>     1) callers of kernel_thread were inconsistent about meaning of a zero return
>     code.  Some callers considered a zero return code to mean success, others took
>     it to mean failure.  a zero return code, while not actually possible in the
>     current implementation, should be considered a success (pid 0 is/should be
>     valid). fixed all callers to treat zero return as success
>     
>     2) caller of kernel_thread saved return code of kernel_thread for later use
>     without ever checking its value.  Callers who did this tended to assume a
>     non-zero return was success, and would often wait for a completion queue to be
>     woken up, implying that an error (negative return code) from kernel_thread could
>     lead to deadlock.  Repaired by checking return code at call time, and setting
>     saved return code to zero in the event of an error.
>     
>     3) callers of kernel_thread never bothered to check the return code at all.
>     This can lead to seemingly unrelated errors later in execution.  Fixed by
>     checking return code at call time and printing a warning message on failure.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
