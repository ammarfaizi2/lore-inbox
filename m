Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVIVFID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVIVFID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVFIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:08:01 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:23134 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965047AbVIVFIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:08:00 -0400
Message-ID: <43323C2C.8070204@cosmosbay.com>
Date: Thu, 22 Sep 2005 07:07:56 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com> <Pine.LNX.4.63.0509220017430.6397@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0509220017430.6397@excalibur.intercode>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris a écrit :
> 
> Do you have any performance measurements?

Yes, as I said in the first mail :

 >In oprofile results, ipt_do_table() was at the first position.
 >It is now at 6th position, using 1/3 of the CPU it was using before.
 >(Tests done on a dual Xeon i386 and a dual Opteron x86_64)

On the dual opteron machine, with 40.000 packets coming per second, and 35.000 
sent per second, the numbers were : 12.8 % before the patches, 4.4 % after the 
patches.

I dont have separate perf measurements for each patch.

Considering the fact that I inlined the read_lock_bh() call (not displayed in 
oprofile results, probably because of the special .spinlock.text section) that 
should have increased the profile of ipt_do_table(), thats a lot of CPU cycles 
  and mem bandwitdh that are available for other jobs.

Eric

