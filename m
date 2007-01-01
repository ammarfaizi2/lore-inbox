Return-Path: <linux-kernel-owner+w=401wt.eu-S932531AbXAAXxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbXAAXxJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbXAAXxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:53:09 -0500
Received: from rtr.ca ([64.26.128.89]:4278 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbXAAXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:53:08 -0500
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2007 18:53:08 EST
Message-ID: <4599992D.8000607@rtr.ca>
Date: Mon, 01 Jan 2007 18:28:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: jens.axboe@oracle.com
Cc: Rene Herman <rene.herman@gmail.com>, Tejun Heo <htejun@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com>
In-Reply-To: <45998F62.6010904@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Tejun Heo wrote:
> 
>> Everything seems fine in the dmesg.  Performance degradation is
>> probably some other issue in -rc kernel.  I'm suspecting recently
>> fixed block layer bug.  If it's still the same in the next -rc,
>> please report.
> 
> In fact, it's CFQ. The PATA thing was a red herring. 2.6.20-rc2 and 3 
> give me ~ 24 MB/s from "hdparm t /dev/hda" while 2.6.20-rc1 and below 
> give me ~ 50 MB/s.
> 
> Jens: this is due to "[PATCH] cfq-iosched: tighten allow merge 
> criteria", 719d34027e1a186e46a3952e8a24bf91ecc33837:
> 
> http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=719d34027e1a186e46a3952e8a24bf91ecc33837 
> 
> 
> If I revert that one, I have my 50 M/s back. config and dmesg attached 
> in case they're useful.

Wow.. same deal here -- sequential throughput drops from 40MB/sec to 28MB/sec
with CFQ -- whereas the anticipatory scheduler maintains the 40MB/sec.

Jens.. I wonder if the new merging test is a bit too strict?

There are four possible combinations, and the new code
allows merging for two of them:  sync+sync and async+async.

But surely one of (not sure which) sync+async or async+sync may also be okay?
Or would it?

This is a huge performance hit.

Cheers
