Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWEIB5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWEIB5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 21:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWEIB5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 21:57:45 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:57204 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751093AbWEIB5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 21:57:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vTvl9GW8pDMYaR2tmr2XebAVgzImqYa7nAkuXJgavITqE550L1MZlqA+YeR1B/0EFKLoHf5QknDFfRokiul4f3J97RmxA/x4pE1vQsuEIRPGoxj7We9weMNpCOGasfNJ/Mi2BZgTNaL5i97Toge44IvZDLqPz4ARadT+p3PgArE=  ;
Message-ID: <445FF714.4050803@yahoo.com.au>
Date: Tue, 09 May 2006 11:57:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Erik Mouw <erik@harddisk-recovery.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com>	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>	 <1147100149.2888.37.camel@laptopd505.fenrus.org>	 <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org>
In-Reply-To: <1147102290.2888.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>... except that any kernel < 2.6 didn't account tasks waiting for disk
>>IO.
>>
>
>they did. It was "D" state, which counted into load average.
>

Perhaps kernel threads in D state should not contribute toward load avg.

Userspace does not care whether there are 2 or 20 pdflush threads waiting
for IO. However, when the network/disks can no longer keep up, userspace
processes will end up going to sleep in writeback or reclaim -- *that* is
when we start feeling the load.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
