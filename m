Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUFGJNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUFGJNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFGJNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:13:46 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:53388 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264365AbUFGJNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:13:08 -0400
Message-ID: <40C4319D.6090201@yahoo.com.au>
Date: Mon, 07 Jun 2004 19:13:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: BUG in ht-aware scheduler/nice in 2.6.7-rc2 on dual xeon
References: <20040607085625.GA11276@outpost.ds9a.nl>
In-Reply-To: <20040607085625.GA11276@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> Fails sometimes, with all processes getting 50%. The above 'screenshot' is
> from the working and expected situation, which happens most of the time.
> 
> When it goes wrong, top shows me that Cpu0 and Cpu1 are 100% user, while
> Cpu2 and Cpu3 are both 100% nice.  The niced processes show up in top as
> PRiority 39, the unniced ones (NI = 0) as PR 25.
> 
> I've also seen it that Cpu2 and Cpu3 are 100% busy, and 0 and 1 are 100%
> nice.
> 

Ahh, that is because we don't do nice-aware SMP balancing. It
is orthogonal to the HT-nice work.

Fixing it properly requires someone to sit down and do some careful
design of nice-aware balancing that should be general enough to handle
the HT problems as a matter of course.
