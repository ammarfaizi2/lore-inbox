Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUJQNb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUJQNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUJQNb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:31:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269119AbUJQNbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:31:22 -0400
Message-ID: <4172741D.1090800@pobox.com>
Date: Sun, 17 Oct 2004 09:31:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org>
In-Reply-To: <20041016182116.33b3b788.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>Can we get a sysrq-M dump from that machine please?
>>
>> alas, for the 'hang' case, my during-initscripts console is going to 
>> strange place.  here's sysrq-m from 2.6.9-rc3-bk4 with the mm/vmscan.c 
>> patch reverted (the its-fixed version).
> 
> 
> Is cool - I was wondering if you had the same funny NUMA zone layout.  You
> do not.
> 
> So there's some new non-terminating condition in there.  It's definitely
> the case that we're still failing to throttle kswapd as we should be doing,
> but I left it as-is due to lack of reported problems (hah) and because the
> fix does cause less reclaim via kswapd and more reclaim via direct reclaim.
> 
> Still.  The relevant patches, in order, are at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out:
> 
> vmscan-total_scanned-fix.patch
> revert-vm-no-wild-kswapd.patch
> balance_pgdat-cleanup.patch
> no-wild-kswapd-2.patch
> no-wild-kswapd-kswapd-continue.patch
> 
> I expect the first one will fix this up.   Can you confirm?


FWIW, I verified that "vmscan-total_scanned-fix.patch" fixes the hang on 
both 2.6.9-rc3-bk4 and 2.6.9-final.

	Jeff


