Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLURzB>; Sat, 21 Dec 2002 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSLURzB>; Sat, 21 Dec 2002 12:55:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23712 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262808AbSLURzA>; Sat, 21 Dec 2002 12:55:00 -0500
Message-ID: <3E04AB96.5030408@BitWagon.com>
Date: Sat, 21 Dec 2002 09:57:42 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: AnonimoVeneziano <voloterreno@tin.it>,
       Patrick Petermair <black666@inode.at>,
       Roland Quast <rquast@hotshed.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: vt8235 fix, hopefully last variant
References: <20021219112640.A21164@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the important piece:
-----
> +	/* Always use 4 address setup clocks on ATAPI devices */
> +	if (drive->media != ide_disk)
> +		t.setup = 4;
-----
it seems to me that using 4 for t.setup also should be done unless _all_ devices
on that cable are ide_disk.  In particular, if one device is ide_disk but the
other is not, then "t.setup = 4;" should be used even when talking to the ide_disk.
Otherwise the non-ide_disk device might get confused, respond when it should not,
and garble the transaction.  Or, is such a bad thing prevented in some other way?

-- 
John Reiser, jreiser@BitWagon.com

