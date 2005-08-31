Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVHaL7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVHaL7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHaL7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:59:32 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13658 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932500AbVHaL7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:59:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LVgOQLoVuMUb8LkRfNRxO6xTjMPkKYIerqu3zycpsrCByuCQglUdQ+Aa5Hzvt7IBqwaZU65ffkqccLkoHmvc4BUuTimK5qg2n1G5g3/9kBZ4zcSVZS+k5UucXDTb2eGKjOSocGpU9yZ70g4aVZ4wLkXxWbDIz2qZjr9Mla4GVLU=  ;
Message-ID: <43159BAC.2080205@yahoo.com.au>
Date: Wed, 31 Aug 2005 21:59:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Becker <nbecker@physics.ucsb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange CPU speedups with SMP on Athlon 64 X2
References: <Pine.LNX.4.63.0508301153340.10786@claven.physics.ucsb.edu>
In-Reply-To: <Pine.LNX.4.63.0508301153340.10786@claven.physics.ucsb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Becker wrote:
> 
> I would be happy to post my exact C source that I use to do the 
> benchmark, but I wanted to get some feedback first in case I'm just 
> doing something stupid.  Also, since I'm not subscribed to this list, 
> please cc me directly regarding this topic.
> 

Hi Nathan,

Cache issues may explain this. When 2 processes are allocating
memory in parallel they'll be given different interleavings of
pages which could explain the speedup.

Start one process, get it to memset all its memory, then pause
it and do the same thing. Then set them both running at the same
time (ie. after they've each touched their memory in turn), what
do you see?

(By memset()ing the memory, you'll cause the kernel to actually
allocate a physical page. By doing that one after the other, we
hope to eliminate interleaving issues.)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
