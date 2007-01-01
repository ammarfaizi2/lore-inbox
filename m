Return-Path: <linux-kernel-owner+w=401wt.eu-S1755226AbXAAQBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbXAAQBV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbXAAQBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:01:21 -0500
Received: from main.gmane.org ([80.91.229.2]:36346 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbXAAQBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:01:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Nagel <feuerschwanz76@web.de>
Subject: Re: new harddrive with media error
Date: Mon, 01 Jan 2007 17:01:01 +0100
Message-ID: <4599303D.7000704@web.de>
References: <en6q3j$2jk$1@sea.gmane.org> <4596F760.9010105@redhat.com> <20061231001201.GT17561@ftp.linux.org.uk> <45988C50.5070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: xdsl-81-173-159-161.netcologne.de
User-Agent: IceDove 1.5.0.9 (X11/20061220)
In-Reply-To: <45988C50.5070001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the input of everybody.
i think the drive is broken and i will return it.

Happy gnu year @ all
Alex


Tejun Heo schrieb:
> Al Viro wrote:
>> From the look of it, I'd say that it's size reported by disk being
>> more than what's accessible.  Take a look at the block numbers...
> 
> How so?
> 
> ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
> 
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 976751999
> Buffer I/O error on device sda1, logical block 976751936
> 
> It seems like a genuine media error to me.  Many drives suffer a number 
> of media errors in its lifetime.  Read errors happen regularly and most 
> such errors are corrected by ECC, but sometimes you're just not lucky 
> enough.  Some of them are real bad sectors while others might be due to 
> degraded record quality even when the sector itself isn't necessary bad. 
>  In most cases, the drive will reallocate the area including the sector 
> when you write to it.
> 
> Simply rewriting the affected file should solve the problem.  Examine 
> the result of 'smartctl -d ata -a' just in case.  For data of any 
> importance, it's always wise to use raid 1 or 5 and backup regularly. 
> Both help keeping your data safe in more than one way.  Raid re-sync is 
> an easy way out of partial media failures and backing up not only gives 
> you another copy of the data but gives the drives chance to detect 
> degrading area quickly and reallocate before actual read failures begin 
> to occur.
> 

