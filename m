Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWE3Guc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWE3Guc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWE3Guc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:50:32 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:22894 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932166AbWE3Gub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:50:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Sg/yB8+NVFzuCLZwBzFaOOrqu97iNYsJk7G8R0BCK46fNQUMUU4fE4uDjvHr9V9t3MBNOJ4n/RmFUdx7vxvRhIgFJ2Uq8Z+zn2NCM3Cb6AleKf95xwyX1t/qfoq6LG2OqA9Uaybtc0+2jNMCXk11W6N0Iiqbacw+Y/nv2zsqjCE=  ;
Message-ID: <447BEB2F.7020605@yahoo.com.au>
Date: Tue, 30 May 2006 16:50:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       mike@halcrow.us, ezk@cs.sunysb.edu
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060530055115.GD18626@filer.fsl.cs.sunysb.edu> <447BE9E9.4000907@yahoo.com.au>
In-Reply-To: <447BE9E9.4000907@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Josef Sipek wrote:
> 
>> On Mon, May 29, 2006 at 07:34:09PM +1000, Nick Piggin wrote:
>> ...
>>
>>> Can we get rid of the whole thing, confusing memory barriers and all?
>>> Nobody uses anything but the default sync_page
>>
>>
>>
>> I feel like I must say this: there are some file systems that live
>> outside the kernel (at least for now) that do _NOT_ use the default
>> sync_page. All the stackable file systems that are based on FiST [1],
>> such as Unionfs [2] and eCryptfs (currently in -mm) [3] (respective
>> authors CC'd). As an example, Unionfs must decide which lower file
>> system page to sync (since it may have several to chose from).
> 
> 
> OK, noted. Thanks. Luckily for them it looks like sync_page might
> stay for other reasons (eg. raid) ;)

Ah, no: that's the backing dev's unplug_fn. sync_page is always the
same. And it has definite bugs now that splice has been merged.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
