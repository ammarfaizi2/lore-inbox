Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUJZIB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUJZIB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbUJZIB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:01:57 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:44202 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262178AbUJZIB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:01:56 -0400
Message-ID: <417E046A.5070200@yahoo.com.au>
Date: Tue, 26 Oct 2004 18:01:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Rik van Riel <riel@redhat.com>, javier@marcet.info,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <20041023125948.GC9488@marcet.info>	<Pine.LNX.4.44.0410251735470.21539-100000@chimarrao.boston.redhat.com> <20041025151343.7a501719.akpm@osdl.org>
In-Reply-To: <20041025151343.7a501719.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> 
>>-		if (referenced && page_mapping_inuse(page))
>>+		if (referenced && sc->priority && page_mapping_inuse(page))
> 
> 
> Makes heaps of sense, but I'd like to exactly understand why people are
> getting oomings before doing something like this.  I think we're still
> waiting for a testcase?

I have found that quite often it is because all_unreclaimable gets set,
scanning slows down, and the OOM killer goes off.

Rik, I wonder if you can put some printk's where all_unreclaimable
is being set to 1, and see if there is any correlation to OOMs?


Aside from that, the patch does make sense, but might be too aggressive.
In heavy swapping loads, the "zero priority" scan might make up a
significant proportion of the scanning done so you'll want to be
careful about regressions there.
