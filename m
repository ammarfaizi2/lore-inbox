Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTGQMGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271441AbTGQMGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:06:05 -0400
Received: from ns.tasking.nl ([195.193.207.2]:3602 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S265440AbTGQMFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:05:52 -0400
Message-ID: <3F169437.8000802@_netscape_._net_>
Date: Thu, 17 Jul 2003 14:19:03 +0200
From: David Zaffiro <davzaffiro@tasking.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: waltabbyh@comcast.net
Subject: Re: [PATCH] pdcraid and weird IDE geometry
References: <3F160965.7060403@comcast.net>
In-Reply-To: <3F160965.7060403@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think this has any to do with the calculation, you probably just have to use:

CONFIG_PDC202XX_FORCE=y

(well, combined with...

CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y

...and a lot of other options...)

With 2.4.20 the FORCE option had to be set at "n", now it should be set at "y".


> The calc_pdcblock_offset function calculates lba by taking the capacity
> of the drive and dividing it by (head * sector), multiplying the result
> times (head * sector) and subtracting the sector (SPT) count.
> Unfortunately, with the strange geometry reported by the new drive,
> using INTs to store these values will fail. 


Avoiding floating-point precision,  this would do the same as your calculation:

lba = ideinfo->capacity - ideinfo->sect;


However, I don't think the expression "fails". the way it is expressed now, it will divide something integer-wise and then multiply it with the same value (and then minus sect), thus I assume this was intended: To round the capacity value to the next multiple of (head * start),  and then do a minus sect...

I don't think any hardcore programmer ever does a integerwise divide /before/ an integerwise multiply without a very good reason... (And don't give me that "you'd be surprised"!!!)


