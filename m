Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWJLIQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWJLIQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWJLIQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:16:23 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:43934 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932516AbWJLIQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:16:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Pt70ce1y0reSl1XNzDzpnfNj4O88Hy1kfqv7mEGAY3JrgP0boGRQjKnZo06iOzBDGJ9JvUSE+5xaoQKql6n6LPegl7Mo+0wnwir2zWXBnLEXhwJm53AMs8Nks2bd5nq4Q5esjaHam4k5c4c4wE8kNwbQgwA00kKIDS4CpnFEqRE=  ;
Message-ID: <452DF9D2.6020306@yahoo.com.au>
Date: Thu, 12 Oct 2006 18:16:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Harris <googlegroups@mgharris.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
References: <20061011160740.GA6868@dingu.igconcepts.com>
In-Reply-To: <20061011160740.GA6868@dingu.igconcepts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Harris wrote:
> Hi, I can readily reproduce this with 2.6.18 doing 4 simultanous kernel compiles on two disks to load test a P4 3.2 HT with 2GB. I have SMP and SMT scheduling enabled, and the 4GB memory option. Here is output with CONFIG_DEBUG_VM enabled followed by another crash before CONFIG_DEBUG_VM was enabled.

> Oct 11 04:53:35 hen kernel: swap_free: Unused swap offset entry 00004000
> Oct 11 04:53:35 hen kernel: Eeek! page_mapcount(page) went negative! (-1)
> Oct 11 04:53:35 hen kernel:   page->flags = c0080014
> Oct 11 04:53:35 hen kernel:   page->count = 0
> Oct 11 04:53:35 hen kernel:   page->mapping = 00000000

Hmm, this is a new one. The page is free and not reserved, wheras we are
used to seeing them reserved here.

> Oct 11 04:54:31 hen kernel: Bad page state in process 'tripwire'
> Oct 11 04:54:31 hen kernel: page:c1b5cd80 flags:0xc0000014 mapping:00000000 mapcount:-1 count:0

> Another crash from a day earlier before enabling DEBUG_VM
> Oct 10 05:19:43 hen kernel: VM: killing process cc1
> Oct 10 05:19:43 hen kernel: swap_free: Unused swap offset entry 00002000
> Oct 10 05:19:56 hen kernel: swap_free: Unused swap offset entry 00000400

These unused swap offset entry messages seem to indicate extensive memory
corruption in your page tables. Probably bad RAM, or system overheating
when you load it up :(

Can you run a good memory tester like memtest86+ overnight?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
