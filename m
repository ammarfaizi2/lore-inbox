Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUITCnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUITCnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 22:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUITCnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 22:43:19 -0400
Received: from jaures31-1-82-228-83-187.fbx.proxad.net ([82.228.83.187]:46396
	"HELO valhalla.trou.net") by vger.kernel.org with SMTP
	id S262418AbUITCnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 22:43:17 -0400
Message-ID: <414E43C3.9000404@twilight-hall.net>
Date: Mon, 20 Sep 2004 04:43:15 +0200
From: =?ISO-8859-1?Q?Rapha=EBl_Rigo?= <raphael.rigo@twilight-hall.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [RAID1 Bug] bio too big device md0 (248 > 200) (2.6.9-rc2-mm1)
References: <414E076F.5010801@twilight-hall.net> <16718.7181.394343.887783@cse.unsw.edu.au>
In-Reply-To: <16718.7181.394343.887783@cse.unsw.edu.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday September 20, raphael.rigo@twilight-hall.net wrote:
> 
>>Hello,
>>kernel version : 2.6.9-rc2-mm1
>>i'm using a RAID1 array over 2 disks : one ATA, and another one in 
>>"SATA" (if we can call the ICH5 a real SATA controller).
>>During array synchronisation, I get "bio too big device md0 (248 > 200)" 
>>error, which I fixed in doing
>>//#define RESYNC_BLOCK_SIZE (64*1024)
>>#define RESYNC_BLOCK_SIZE PAGE_SIZE
>>in raid1.c, following the instruction on an old thread (for kernel 2.6.0).
>>I would like to know if there is any better fix now, else then this mail 
>>  will act as a remainder ;)
> 
> 
> This is not (as far as I can tell) a raid1 bug.
> 
>    bio too big device md0
> 
> means that someone sent a request to md0 that was too large. (124K
> instead of the max 100K).
> 
> raid1 never does that.  It send requests to the underlying devices.
> So if you make your raid1 from hde and sda, then a message like
>    bio to big device sda
> might indicate a problem with raid1.
> 
> Are you sure you quoted the error message correctly?
> If you, how was the array being used? What filesystem?
> 
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Is I am sure I did the right quote (copy paste from kern.log).
The array was being recovered (it is a newly created array), copying 
from hda to sda. The filesystem used is ext3.
Btw the first number in the message did vary.

I did the modification in raid1.c based on this mail you wrote :
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&frame=right&th=69e566d020ab2da6&seekm=Pine.LNX.4.58.0312232253140.7841%40infocalypse.jimlawson.org.lucky.linux.kernel#link5

Hope this helps,

Raphaël Rigo
