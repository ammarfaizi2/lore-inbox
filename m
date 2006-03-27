Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWC0NPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWC0NPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 08:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWC0NPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 08:15:19 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:54937 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751013AbWC0NPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 08:15:18 -0500
Message-ID: <4427E560.4080702@keyaccess.nl>
Date: Mon, 27 Mar 2006 15:15:12 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Clemens Ladisch <clemens@ladisch.de>
CC: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] [ALSA] AdLib FM card driver
References: <442710A1.5030207@keyaccess.nl> <20060327083113.GB2521@turing.informatik.uni-halle.de>
In-Reply-To: <20060327083113.GB2521@turing.informatik.uni-halle.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Ladisch wrote:

> Rene Herman wrote:

>> I also stuck a very tiny HOWTO in ALSA-Configuration.txt, assuming
>> quite a few people would have no idea how to operate the thing,
>> even if they do happen across a card. Is it okay there?
> 
> It should probably go into a seperate file below Documentation/.

Probably. Documentation/sound/alsa/adlib.txt is ofcourse okay but I saw 
a few other remark type things in ALSA-Configuration as well. Seeing as 
how it's very small, and given the tendency of Documentation/ to not be 
updated alongside code itself, I thought I'd try to get away with just 
keeping things in the one file...

>> + This module supports multiple cards. It does not support autoprobe, so
>> + the port must be specified. For actual AdLib FM cards it will be 0x388.
> 
> Does it make sense to support more than one card or a non-default port
> address?

Yes. Ofcourse, in a practical sense not many people will desperately 
want to have multiple AdLib cards installed in one machine (and mine 
doesn't actually have a jumper to set it to a different address; maybe 
others do) but this driver could also be used to drive the AdLib part of 
a SoundBlaster for example, which would live at 0x220, 0x240, ...

Sure, not many people will want to do _that_ either, but it is most 
importantly more effort to not support multiple cards than it is 
supporting them. Not so much while writing, but when updating these old, 
largely unused, drivers to new infrastructure work you want things to 
look as alsa-generic as possible.

The only ALSA ISA card driver that does not support multiple cards is 
opti9xx and, sure enough, when changing over to the platform_driver 
interface recently, it came out wrong(-ish). I actually offered to 
update it to the generic form already a while ago (will be getting 
around to that).

> I think at least the port address for the first card should be
> defaulted to 0x388.

No, you never want to autoprobe ISA due to the non-discoverability of 
the old non-PnP ISA bus. If you just start poking at addresses you might 
touch something sensitive. The generic example of this is screwing over 
a Novell NIC and while there are still some ALSA drivers that do ISA 
autoprobing (es1688, es18xx, gus, opti9xx, sb8, sb16) this has been 
verboten in the tree in general for some time now.

Hardcoding addresses and probing there might be a bit more userfriendly 
but people who install an 8-bit ISA AdLib FM in this day and age are 
likely not the type to care deeply about userfriendlyness anyway...

Note lastly that the adlib_card OSS driver also needed the address 
passed in.

Many thanks for the comments though!

Rene.

