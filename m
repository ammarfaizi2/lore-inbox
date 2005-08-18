Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVHRCww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVHRCww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVHRCww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:52:52 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:50333 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932108AbVHRCwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:52:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fjYNROJtSaM1kriSmatpuYPiX341/G3HG/GPCtj9nBD1v83CKrui3wbd5fevIXxO2G7iHp2Y7pVc2Ox4GDneT79EE9Po74GQtstb3GJVWULIgsAfh3ZwmBfS8DsoVXZSfGcHHhw5RWR9T29Bf0be1vruiWd7lB9749qobTviuWk=  ;
Message-ID: <4303F7E8.5030705@yahoo.com.au>
Date: Thu, 18 Aug 2005 12:52:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Eric Dumazet <dada1@cosmosbay.com>,
       Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is
 now allocated only on demand.
References: <20050810164655.GB4162@linux.intel.com> <20050810.135306.79296985.davem@davemloft.net> <20050810211737.GA21581@linux.intel.com> <430391F1.9080900@cosmosbay.com> <20050817211829.GK27628@wotan.suse.de> <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de> <4303D90E.2030103@cosmosbay.com> <20050818010524.GW3996@wotan.suse.de>
In-Reply-To: <20050818010524.GW3996@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>
>I would just set the ra pointer to a single global structure if the allocation
>fails. Then you can avoid all the other checks. It will slow down
>things and trash some state, but not fail and nobody should expect good 
>performance after out of memory anyways. The only check still
>needed would be on freeing.
>
>

You don't want to always have bad performance though, so you
could attempt to allocate if either the pointer is null _or_ it
points to the global structure?


Send instant messages to your online friends http://au.messenger.yahoo.com 
