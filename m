Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTK3VFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTK3VFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:05:32 -0500
Received: from skintwin.microway.com ([64.80.227.45]:23444 "EHLO
	skintwin.microway.com") by vger.kernel.org with ESMTP
	id S263088AbTK3VFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:05:25 -0500
Message-ID: <3FCA5B8A.2020006@mail.ru>
Date: Sun, 30 Nov 2003 16:05:14 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de> <20031130175649.GA18670@ucw.cz> <20031130181723.GD6454@suse.de> <3FCA34A6.3010600@pobox.com> <20031130182232.GF6454@suse.de> <3FCA3787.1000104@pobox.com>
In-Reply-To: <3FCA3787.1000104@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
> 
>> Ah, my line wasn't completely clear (to say the least)... So to clear
>> all doubts:
>>
>>     if ((sector_count % 15 == 1) && (sector_count != 1))
>>         errata path
>>
>> Agree?
> 
> 
> 
> Agreed.
> 
> 
> The confusion here is most likely my fault, as my original post 
> intentionally inverted the logic for illustrative purposes (hah!)...
> 
>> Well, the constraint we must satisfy is
>>
>>     sector_count % 15 != 1
>>
>> (i.e. "== 1" causes the lockup) 


Hi, I just rebuilt my kernel with libata support.
I have 3112 Silicon Image controller with IDE drive attahed.
(I have 2 IDE drives, so I bought second controller to split load between them. One is connected to the MB IDE controller.)

When I run hdparm command, I can see strange behaviour of the ilbata driver:

[root@shrike root]# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  64 MB in  1.19 seconds = 53.78 MB/sec
[root@shrike root]# hdparm -t /dev/sda1

/dev/sda1:
  Timing buffered disk reads:  read(1048576) returned 921600 bytes
[root@shrike root]#


Meanwhile -T switch works normally.


I know, that siimage support is broken, any ideas, what can possibly cause such errors?
Is it somehow linked to the error discussed in this message thread?


WBR.

