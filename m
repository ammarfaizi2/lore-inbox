Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbULTRtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbULTRtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbULTRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:49:18 -0500
Received: from mail6.hitachi.co.jp ([133.145.228.41]:45040 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S261590AbULTRtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:49:14 -0500
Message-ID: <41C710BB.9000705@sdl.hitachi.co.jp>
Date: Tue, 21 Dec 2004 02:49:47 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, mr@ramendik.ru, kernel@kolivas.org,
       riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au>
In-Reply-To: <41C682F1.20200@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Andrew Morton wrote:
[snip]
>> Did anyone come up with a simple step-by-step procedure for 
>> reproducing the
>> problem?  It would be good if someone could do this, because I don't 
>> think
>> we understand the root cause yet?
> 
> I admit to generally being in the same boat as you with respect to
> running complex userspace apps.
> 
> However, based on this and other scattered reports, I'd say it seems
> quite likely that token based thrashing control is the culprit. Based
> on the cost/benefit, I wonder if we should disable TBTC by default for
> 2.6.10, rather than trying to fix it, and try again for 2.6.11?

Hello,

I imagine that the issue might occur when only one process holds 
almost all memory and has swap token too long time.

However, TBTC has a good effect in my workload.  
So, I think that it is better to keep VM tunable using TBTC.
 
It may be a good idea to set 0 to default swap_token_timeout 
until we find the root cause.

Best regards,
Hideo AOKI

