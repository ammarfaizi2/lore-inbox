Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTK3RGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTK3RGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:06:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264944AbTK3RGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:06:23 -0500
Message-ID: <3FCA2380.1050902@pobox.com>
Date: Sun, 30 Nov 2003 12:06:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       marcush@onlinehome.de, linux-kernel@vger.kernel.org,
       eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311301758.53885.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 30 of November 2003 17:51, Jens Axboe wrote:
>>>Tangent:  My non-pessimistic fix will involve submitting a single sector
>>>DMA r/w taskfile manually, then proceeding with the remaining sectors in
>>>another r/w taskfile.  This doubles the interrupts on the affected
>>>chipset/drive combos, but still allows large requests.  I'm not terribly
>>
>>Or split the request 50/50.
> 
> 
> We can't - hardware will lock up.

Well, the constraint we must satisfy is

	sector_count % 15 != 1

(i.e. "== 1" causes the lockup)

Beyond that, any request ratio should be ok AFAIK...

	Jeff



