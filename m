Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTDVUCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTDVUCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:02:39 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:18164 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263511AbTDVUCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:02:38 -0400
Date: Tue, 22 Apr 2003 16:12:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH][ANNOUNCE] Linux 2.5.68-ce2
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221614_MC3-1-3589-7E0C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

.> What benefit did you see from that, what was your reasoning behind the 
.> change? Have you noted 16byte code alignment improvements with some processors?

 I posted a message about that a while ago after noticing that some
interrupt handlers started in the last 4 bytes of a(n assumed) 16-byte
cacheline, and the first instruction in all of them was 5 bytes long.
According to the manuals the penalties for this can be huge, and there's
no way to mitigate them with branch prediction and prefetch.  (How do you
predict an interrupt?)  And even if you hit L1 with both fetches there is
a small penalty...

 I couldn't find any way to test the patch, but there doesn't seem to be
any downside other than a lost 1K of memory on IOAPIC machines, and a possible
larger working set fighting for L1 space but that would require heavy
concurrent use of a very large number of interrupt vectors.


-------
 Chuck
