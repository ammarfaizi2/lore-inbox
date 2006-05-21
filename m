Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWEUMBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWEUMBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWEUMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:01:35 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:44367 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751527AbWEUMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:01:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vIMGkygD7Z/UjizVtmduXWjjZW8Ho2cjkJYAu0FeN6bAqwDFDUxhJbZiz4LCIyoDyKF3G1HWjsevbyYkDIH6AmVdmm5OEeLjuqAGw9YpxtqPno/i31LY67LTX69mRz/Ui66IsIBuREAYXwqjvDrzTVN7qZgQdzrnM/5aAiuxnFc=  ;
Message-ID: <44705699.3080401@yahoo.com.au>
Date: Sun, 21 May 2006 22:01:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Haar J?nos <djani22@netcenter.hu>, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102642.GB5582@taniwha.stupidest.org>
In-Reply-To: <20060521102642.GB5582@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:
> 
> 
>>[root@st-0001 /]# uname -a
>>Linux st-0001 2.6.17-rc3-git1 #2 SMP Sun May 21 01:12:22 CEST 2006 i686 i686 i386 GNU/Linux
> 
> 
> did earlier kernels work OK?
> 
> 
>>This is a simple disk node.
>>It serves the md0 array, and uses mem for buffering-caching.
> 
> 
> odd, i looks like you've leaked alot of lowmem but i can't think why
> 
> i've got major (induced) brain-fog right now so i'll have to think
> about it tomorrow sorry

The buffers are buffercache rather than the usual pagecache; due to
nbd I guess. Buffercache cannot be satisfied by highmem.

This would be a relatively uncommon setup, which explains why it
isn't working 100%. I don't know of any reason why reclaim speed
should be worse for buffercache, however one notable thing will be
that zone_normal's lowmem reserve that is untouchable by pagecache
will be eaten by buffercache...

Anyway, increasing /proc/sys/vm/min_free_kbytes should help. Janos,
perhaps you could try doubling it and see how you go?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
