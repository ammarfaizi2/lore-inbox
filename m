Return-Path: <linux-kernel-owner+w=401wt.eu-S1754459AbXAAK1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbXAAK1d (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 05:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbXAAK1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 05:27:33 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:58617 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbXAAK1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 05:27:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h8eVJWCfgMaIPhn96XJYn3AobdvVRoSCf0AQAB0UI0pXHzr1lOyvXZ2AHn4vGw1cWcyifIQBYnBGv6Rj4cWx9spjIFcV3eHduQ0Oi+wvHEBbnWzCbzWsnlDk65dyZuozMAMZQdJfk9Ff7oSkPCIYMGE+V/ZH7kWdvv/Ig7iwvio=
Message-ID: <45988C50.5070001@gmail.com>
Date: Mon, 01 Jan 2007 13:21:36 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Rik van Riel <riel@redhat.com>, Alexander Nagel <feuerschwanz76@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: new harddrive with media error
References: <en6q3j$2jk$1@sea.gmane.org> <4596F760.9010105@redhat.com> <20061231001201.GT17561@ftp.linux.org.uk>
In-Reply-To: <20061231001201.GT17561@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> From the look of it, I'd say that it's size reported by disk being
> more than what's accessible.  Take a look at the block numbers...

How so?

ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)

sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936

It seems like a genuine media error to me.  Many drives suffer a number 
of media errors in its lifetime.  Read errors happen regularly and most 
such errors are corrected by ECC, but sometimes you're just not lucky 
enough.  Some of them are real bad sectors while others might be due to 
degraded record quality even when the sector itself isn't necessary bad. 
  In most cases, the drive will reallocate the area including the sector 
when you write to it.

Simply rewriting the affected file should solve the problem.  Examine 
the result of 'smartctl -d ata -a' just in case.  For data of any 
importance, it's always wise to use raid 1 or 5 and backup regularly. 
Both help keeping your data safe in more than one way.  Raid re-sync is 
an easy way out of partial media failures and backing up not only gives 
you another copy of the data but gives the drives chance to detect 
degrading area quickly and reallocate before actual read failures begin 
to occur.

-- 
tejun

