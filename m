Return-Path: <linux-kernel-owner+w=401wt.eu-S1161325AbXAHPvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbXAHPvs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161324AbXAHPvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:51:48 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55337 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161323AbXAHPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:51:47 -0500
Message-ID: <45A2688E.3080503@pobox.com>
Date: Mon, 08 Jan 2007 10:51:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
References: <20070108122659.00c22754@localhost.localdomain>	<45A24159.7060001@pobox.com> <20070108154249.6d8f5697@localhost.localdomain>
In-Reply-To: <20070108154249.6d8f5697@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> The problem you need to fix or work around is ata_probe_ent, which 
>> doesn't properly fill in ata_port info for this situation.  Tejun has 
>> posted patches that kill ata_probe_ent, which you were pointed to. 
> 
> And which are not yet in the main tree leaving many users unable to
> install Linux.

The controllers affected by your patch have been around for well over a 
year.  I doubt a huge amount of suffering will be caused by pausing to 
get it right...  especially when you have been pointed at two working 
code examples that already get it right.


> This isn't the way to get stuff done. When you've got the
> new patches in the driver can use them if its worth it (which, see below,
> I question).

In Linux, we work /with/ the subsystem, not around it.

Your current approach is fundamentally flawed.  You can see this because 
e.g. a call to vt6421_ops::scr_read() will immediately oops, after your 
patch.

Just separate PATA and SATA operations.  That way everything works as 
expected, and you don't unintentionally add lovely oopses all over the 
place.

	Jeff


