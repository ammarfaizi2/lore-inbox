Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbTIIOdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTIIOdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:33:14 -0400
Received: from postal.usc.edu ([128.125.253.6]:58348 "EHLO postal.usc.edu")
	by vger.kernel.org with ESMTP id S264140AbTIIOdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:33:12 -0400
Date: Tue, 09 Sep 2003 07:33:02 -0700
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Linux IDE bug in 2.4.21 and 2.4.22 ?
In-reply-to: <200309091448.36231.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5DE49E.50500@ipom.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827
 Debian/1.4-3
References: <20030908225107.GE17108@earthlink.net>
 <200309091448.36231.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 09 of September 2003 00:51, Phil Dibowitz wrote:
> 
>>Hey folks,
>>
>>I think I may have found a bug in the Linux IDE subsystem
>>introduced in 2.4.21 and still present in 2.4.22.
> 
> 
> Nope, user error :-).

I thought there was a reasonable chance of that! =)

> Nope, your CMD649 was handled by generic PCI IDE driver.

Ah, OK. Makes sense.

>>As of 2.4.21, this configuration no longer works -- which is not
>>necessarily a bug. I'm almost there, stay with me. =)
> 
> Assumption that current .config will work with future kernel versions is *false*.

Agreed. I said that wasn't a bug. =)

> Just add these two lines to your .config:
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_BLK_DEV_CMD64X=y

Doh!! Didn't see the VIA driver down there at the bottom. Double doh! My 
appologies, I should have been able to figure that out.

That works quite well, thank you! Still have a question though...

> Your VIA IDE controller was handled by generic IDE chipset driver which
> did probe devices *after* PCI controllers are probed, so CMD649 took
> ide0 and ide1 first.

But, what about the case when I built in the generic driver, but made 
the CMD649 driver a module, and loaded it after boot. That shouldn't 
have *changed* what ide0 and ide1 are, right? I had ide0 and ide1 
assigned, did a modprobe, and CMD649 changed what ide0 adn ide1 where, 
and then forgot about the previous ones.. like all of a sudden it told 
the generic driver "no, no, you were wrong, there's no VIA chipset here, 
go back to sleep."

I may well be misunderstanding something precedence in the kernel here, 
but I figured while I'm bugging you, I might as well get the full picture.

Thanks for your time!
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


