Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWEBXg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWEBXg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWEBXg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:36:29 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:59307 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751183AbWEBXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:36:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ANOziwcjzFzcuCwT3885EbzHvOKXJxwN5cc0he8FNiJUC/ROcpzhqHLidfGvzo9gGuCj+SeJYXt7vAJiY62u6t7AECUe4Dvnsazt1lh3aVPuQH2xrxa+mKgDPQjWje4ZrYuv1WCuvECUbif7QHuCS1gPMQ0doUlRzFcNj3wT/Mo=  ;
Message-ID: <44576BF5.8070903@yahoo.com.au>
Date: Wed, 03 May 2006 00:25:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org>
In-Reply-To: <44576688.6050607@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>> Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
>> anywhere but some Summit systems (at least every time I tried it it 
>> blew up on me and nobody seems to use it regularly). Maybe it would be 
>> finally time to mark it CONFIG_BROKEN though or just remove it (even 
>> by design it doesn't work very well) 
> 
> 
> Bollocks. It works fine, and is tested every single day, on every git
> release, and every -mm tree.

Whatever the case, there definitely does not appear to be sufficient
zone alignment enforced for the buddy allocator. I cannot see how it
could work if zones are not aligned on 4MB boundaries.

Maybe some architectures / subarch code naturally does this for us,
but Ingo is definitely hitting this bug because his config does not
(align, that is).

I've randomly added a couple more cc's.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
