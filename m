Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946302AbWJSSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946302AbWJSSKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946304AbWJSSKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:10:23 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:16800 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946302AbWJSSKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:10:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oyv6R67Pa1B9O2xHduUJ8P8bbaNKIg8K6GCxGjFURHz0X0TnGnCG+QiCrGhvEUmXliO7dpZ3PU0/zr3iTTOv5F/X4zzPViYe+pFmrTulcgx/GYbZP+ngBG4QjGgAU3LEk/GojF1g4BVE/MAhXTl4z3+kEqhBfqUF5rlOCNwLT6s=  ;
Message-ID: <4537BF8A.9040004@yahoo.com.au>
Date: Fri, 20 Oct 2006 04:10:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Carsten Otte <cotte@freenet.de>
CC: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	<45367210.4040507@googlemail.com>	<200610182118.31371.rjw@sisk.pl>	<4536818E.3060505@fr.ibm.com>	<453683A6.9090106@yahoo.com.au>	<45368E0A.1030503@fr.ibm.com> <20061018152346.0486b6bc.akpm@osdl.org> <4537A263.4090601@freenet.de>
In-Reply-To: <4537A263.4090601@freenet.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte wrote:
> Andrew Morton wrote:
> 
>> The page we're writing into isn't locked, so there's no deadlock afaict.
>>
>> But then, I forget how xip works.  Carsten, is it actually being used for
>> anything?
>>   
> 
> The comment may be superfluous. I did not quite understand the deadlock 
> condition refered to by the comment in filemap, therefore I cut&pasted 
> it over. I will send a patch that removes it.

Yes, it wasn't a good comment. Basically we can't hold the page lock and
then enter the page fault handler. mm-fix-pagecache-write-deadlocks.patch
has quite a lot of comments to explain it.

I don't believe filemap_xip holds the page lock, so you don't need to do
the atomic copy, and you don't need to do the fault_in_pages_readable.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
