Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVH3NGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVH3NGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVH3NGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:06:12 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:55469 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751119AbVH3NGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:06:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FMluM9PcrJ5tt3NbHsXM3WsR1tNvWKKcQGa+UlxJyHUkL16jN7NXhIe8QN6LkrbyM9Ftt6pQpnpgnwVq/PLOmwkpBZmNoC1WAyDyOCTplig/V3MV1kqZjmADws1rcj2pwEj7XPij5c58E8PrQyC+/+V5qUh4LCZUO2UERQ8+Pbw=  ;
Message-ID: <431459C8.6070701@yahoo.com.au>
Date: Tue, 30 Aug 2005 23:06:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sonny Rao <sonnyrao@us.ibm.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, sonny@burdell.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
References: <1125276312.5048.22.camel@mulgrave> <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave> <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave> <4312830C.8000308@yahoo.com.au> <20050829164144.GC9508@localhost.localdomain> <4313AEC9.3050406@yahoo.com.au> <1125369981.5089.106.camel@mulgrave> <4313CA1E.3000605@yahoo.com.au> <20050830052405.GB20843@localhost.localdomain>
In-Reply-To: <20050830052405.GB20843@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:
> On Tue, Aug 30, 2005 at 12:53:18PM +1000, Nick Piggin wrote:

>>For testing regular lookups, yeah that's more difficult. For a
>>microbenchmark you can use sparse files, which can be a good
>>trick for testing pagecache performance without the IO.
> 
> 
> I have a feeling that testing using sparse files should be done with
> great care to avoid exaggerating the effects of the CPU cache --
> i.e. you still need to have quite a number of pages to look up, but
> spread them apart by large offsets so that the top few levels don't
> become quickly cached for the whole test. 
> 

That's true depending on what kind of test you want to run.

Just to be clear: by 'sparse files', I mean create a huge,
sparse on-disk file from which pagecache can be arbitrarily
populated without taking up disk space by read(2)ing from it.

 From the pagecache's point of view, there would be no
difference between using that or an on-disk file.

Nick

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
