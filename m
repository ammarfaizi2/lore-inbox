Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWEICQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWEICQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 22:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWEICQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 22:16:44 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:30395 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751086AbWEICQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 22:16:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nhTHhVy+Zne+lRd88AYuFNGq/nwnVL2uHSsxU9jzdLN0VlxbyokU17dRSkcQxPbhAuhVuj2EhyqEsPU+4ymVI/ooX8nCIOZKH+6AnXRZM4dU1WIlddxjMWjaEYgEDdoH2ZU6v5rJ5yctPnZL4u3DsqAG5zmpyDNXG8aLvZ6Od6Y=  ;
Message-ID: <445FFB83.8060100@yahoo.com.au>
Date: Tue, 09 May 2006 12:16:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com>	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>	 <1147100149.2888.37.camel@laptopd505.fenrus.org>	 <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <445FF714.4050803@yahoo.com.au> <445FF82A.2080106@mbligh.org>
In-Reply-To: <445FF82A.2080106@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

> Nick Piggin wrote:
>
>>
>> Perhaps kernel threads in D state should not contribute toward load avg.
>>
>> Userspace does not care whether there are 2 or 20 pdflush threads 
>> waiting
>> for IO. However, when the network/disks can no longer keep up, userspace
>> processes will end up going to sleep in writeback or reclaim -- 
>> *that* is
>> when we start feeling the load.
>
>
> Personally I'd be far happier having separated counters for both.


Well so long as userspace never blocks, blocked kernel threads aren't a
bottleneck (OK, perhaps things like nfsd are an exception, but kernel
threads doing asynch work on behalf of userspace, like pdflush or kswapd).
It is something simple we can do today that might decouple the kernel
implementation (eg. of pdflush) from the load average reporting.

> Then
> we can see what the real bottleneck is. Whilst we're at it, on a per-cpu
> and per-elevator-queue basis ;-)

Might be helpful, yes. At least separate counters for CPU and IO... but
that doesn't mean the global loadavg is going away.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
