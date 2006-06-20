Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWFTQrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFTQrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWFTQrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:47:08 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:48292 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751407AbWFTQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JRxGyj5lA7y74ULNPhSlQbla4P71ddmtjzwM0dCSknBcNgWAJFOwyUGHpuJKlJXlcWdbR0F1Yyi4Q3PhPni5S63bpmskzHD/TwDWUjERc44j1WfpwMLbG4ovL9HrCsrBvu5bjBSKk62EXxcTmXO4Wpw/G2SB37Y4/VE1UnlzgbQ=  ;
Message-ID: <449821EC.2080601@yahoo.com.au>
Date: Wed, 21 Jun 2006 02:27:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Dave Olson <olson@unixfolk.com>, ccb@acm.org,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>	 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>	 <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>	 <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au>	 <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au>	 <20060620095135.GC11037@elte.hu>  <4497D4FF.6000706@yahoo.com.au>	 <1150808692.2891.194.camel@laptopd505.fenrus.org>	 <4497F9F1.8060708@yahoo.com.au> <1150815237.2891.205.camel@laptopd505.fenrus.org> <44981164.3000406@yahoo.com.au>
In-Reply-To: <44981164.3000406@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> And either way, spinlocks are still much more costly than rwlocks,
> because they still have that first exclusive request, who's
> effectiveness deteriorates under load. That you *also* have these
> follow on shared accesses (which will need to be invalidated somehow
> later anyway), doesn't make them better than read locks.

I shouldn't say much more costly.... Much more costly when looking
at the limit case (and we traditionally rather look at the common
case in Linux, and in those cases spinlocks _can_ be faster).

However in the limit, spinlocks scale O(N), while readlocks scale
O(1), where N is the number of CPUs trying to take the lock.
AFAIKS.

But if they're causing stability problems, I have no arguments
against converting them to spinlocks. It might even result in a
worldwide net saving of CPU cycles, for what that's worth ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
