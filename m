Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbTEBACM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEBACM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:02:12 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:34710 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S262809AbTEBABo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:01:44 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Fri, 2 May 2003 03:14:01 +0300
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB0413D.2050200@superonline.com> <200305011801.39014.tmb@iki.fi> <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305020314.01875.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Backlund wrote:
>Viestissä Torstai 1. Toukokuuta 2003 17:49, Alan Cox kirjoitti:
>> On Iau, 2003-05-01 at 16:01, Thomas Backlund wrote:
>> > You mean the patch that only looks at videomode, dont you...
>>
>> I do
>>
>> > Well maybe it's best to use it as default, to avoid this bug
>> > "out of the box"...
>> >
>> > But I will remake a patch to ovverride it so that the users who
>> > need/want the extra memory to be able to allocate it...
>> > since I like the idea of giving the user the choice...
>>
>> Sounds right to me
>
>>Oh well,
>I'm building my testkernel now with the above patch, 
>and will be testing different vram options to "kill" my system...

And here are the results...

the testsystem: 
Amd XP 1800+
nForce2 m/b
256MB DDR RAM
Geforce4 Ti4200 64MB, videomode 1024x768x32
kernel-2.4.21-0.16mdk (i586 optimized)
kernel-2.4.21-0.16mdkent (i686 optimized + HIGHMEM)

without any vram option it allocated:
vesafb: framebuffer at 0xc0000000, mapped to 0xd0800000, size 24576k
as it should...

the standard kernel maxed out at about 755 MB
the enterprise kernel maxed out at about 720 MB

with the enterprise kernel I managed to get it to boot
with an allocation request for 1536MB, but the screen
blacked out at the berginning, even if the kernel seemed
to boot without errors....

booting with 800MB or 1024MB request resulted in an direct 
lockup with flashing keyboard leds....

so it seems to be the 1GB magical limit again...

So it seems useless to try and set an upper limit,
instead just leving it to the users choice to set whatever
he/she wants...


Now I have to get some sleep....

-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

