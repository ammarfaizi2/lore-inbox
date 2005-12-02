Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVLBAFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVLBAFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVLBAFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:05:05 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:33016 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932566AbVLBAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:05:04 -0500
Date: Thu, 01 Dec 2005 19:03:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438F7D09.6040007@m1k.net>
To: linux-kernel@vger.kernel.org, mkrufky@m1k.net
Cc: Perry Gilfillan <perrye@linuxmail.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>
Message-id: <200512011903.41058.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200512011726.41299.gene.heskett@verizon.net> <438F7D09.6040007@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 17:45, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Thursday 01 December 2005 17:06, Perry Gilfillan wrote:
>>>Mauro Carvalho Chehab wrote:
>>>>After checking the datasheets of Thompson tuner, and I have one
>>>>guess:
>>>>
>>>>At board description, tda9887 is not there. This tuner needs to work
>>>>properly.
>>>>
>>>>This small patch does enable it for your board.
>>>>
>>>>You should notice that you may need to use some parameters for
>>>>tda0887 to work properly, like using port1=0 port2=0 qss=0 as insmod
>>>>options for this module. (these are some on/off bits at the chip, to
>>>>enable some special functions - if 0/0/0 doesn't work you may need
>>>> to test 0/0/1, .. 1/1/1).
>>>
>>>This has fixed it for me!!  I compiled todays cvs, with out this
>>> patch, to watch it fail, then added the line as noted, and reloaded
>>> the modules without rebooting, and it worked.  I did a cold start to
>>> see that it is repeatable, and it continues to work.  I used no
>>> extra parameters, so the defaults are working fine.
>>
>>I haven't built it yet, had to apply the patch by hand for some reason
>>here, after doing a cvs up -D today.
>>
>>2.6.15-rc4 under construction to test it.
>
>Gene, dont bother applying the patch to the cvs code -- It is obviously
>correct, so I have merged it into v4l-dvb cvs.

I did a cvs up -D 2005-12-1, about 1.5 hours ago and it hadn't been
applied yet.

>A simple cvs checkout will get you everything you need.
I'll resuck the whole thing.

>If you like, try to apply it against the kernel, without using cvs.

Ok, that I can probably do.  Unforch, there is a miss-cue in that
file, rc4 says:
struct cx88_board cx88_boards[] = {
        [CX88_BOARD_UNKNOWN] = {
                .name           = "UNKNOWN/GENERIC",
                .tuner_type     = UNSET,
                .radio_type     = UNSET,
                .tuner_addr     = ADDR_UNSET,
                .radio_addr     = ADDR_UNSET,
                .input          = {{
                        .type   = CX88_VMUX_COMPOSITE1,

Note also that the .type = label has been changed.  I'm going to change
that line back to CX88_VMUX_TELEVISION, just for grins.

While the patch says:
@@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
                .radio_type     = UNSET,
                .tuner_addr     = ADDR_UNSET,
                .radio_addr     = ADDR_UNSET,
                .tda9887_conf   = TDA9887_PRESENT,
                .input          = {{
                        .type   = CX88_VMUX_TELEVISION,
                        .vmux   = 0,
And I've added that line from the patch to just above the ".input"
line, its rebuilding now.  And a cold reboot will test it, so I'll send
this first just to let you know not all is well in tv land.

>Anyhow, surely it will work.  Thank you Gene, Don and Perry for helping
>us to solve this bug......... Hopefully we'll be able to get the fix
>into 2.6.15.
>
>Cheers,
>
>Michael Krufky

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

