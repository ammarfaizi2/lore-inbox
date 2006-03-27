Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWC0K7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWC0K7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWC0K7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:59:03 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:12886 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750817AbWC0K7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:59:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=slhuHTK97/gSowUStd5vghiHD68zP2Lya/8elBiN6qa9BSpFNsZKSVcRslqi/GXkJ7UQ/egl3vktZ/XVrZbKH27jlmGCEaZznpvDbM/5nSEil3toRJsbB3Hmjtl7juC4/6s+O+S8UBStfG1+ggRV3VbkPlXCmaau9ziWFcLKguc=  ;
Message-ID: <4427C4EE.1070807@yahoo.com.au>
Date: Mon, 27 Mar 2006 20:56:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: unlock_buffer() and clear_bit()
References: <44247FAB.3040202@free.fr>	<20060325040233.1f95b30d.akpm@osdl.org>	<4427A817.4060905@bull.net> <20060327010739.027d410d.akpm@osdl.org> <4427B292.3080204@bull.net> <4427C284.3020206@yahoo.com.au>
In-Reply-To: <4427C284.3020206@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> smp_mb__after_clear_bit() is supposed to, when run directly after
> a clear_bit operation, provide the equivalent of an smp_mb().
> 

Actually I guess I'm wrong here: it appears that it really should
order before, and after the clear_bit, respectively (looking at
its usage in unlock_page.

So ia64's smp_mb__before_clear_bit needs to be a full barrier, but
__after_clear_bit can be a release. I think?

By the way unlock_page is issuing extra barriers:
Documentation/atomic_ops.txt defines test_and_clear_bit operations
to provide full memory barriers before and after them, so no need
for smp_mb__before/after there.

...ia64 gets these test_and_x_bit operations wrong as well...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
