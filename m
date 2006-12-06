Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760333AbWLFI5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760333AbWLFI5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760329AbWLFI5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:57:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48717 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760328AbWLFI5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:57:17 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457685D1.1080501@s5r6.in-berlin.de>
Date: Wed, 06 Dec 2006 09:56:49 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Ben Collins <ben.collins@ubuntu.com>
CC: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <20061205184921.GA5029@martell.zuzino.mipt.ru>	 <4575FF08.2030100@redhat.com> <1165383349.7443.78.camel@gullible>
In-Reply-To: <1165383349.7443.78.camel@gullible>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Cc: linux1394-devel)

Ben Collins wrote at linux-kernel:
> On Tue, 2006-12-05 at 18:21 -0500, Kristian Høgsberg wrote:
>> Alexey Dobriyan wrote:
>>> On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
>>>> I'm announcing an alternative firewire stack that I've been working on 
>>>> the last few weeks.
>>> Is mainline firewire so hopeless, that you've decided to rewrite it? Could
>>> you show some ugly places in it?
>> Yes.  I'm not doing this lightheartedly.  It's a lot of work and it will
>> introduce regressions and instability for a little while.
>>
>> My main point about ohci1394 (the old stacks PCI driver) is, that if you
>> really want to fix the issues with this driver, you have to shuffle the code
>> around so much that you'll introduce as many regressions as a clean rewrite.
>> The big problems in the ohci1394 drivers is the irq_handler, bus reset
>> handling and config rom handling.  These are some of the strong points of
>> fw-ohci.c:
> 
> My main concern is that when I picked up ieee1394 maint myself, it was
> because it was not big-endian or 64-bit friendly.

I would like to see new development efforts take cleanliness WRT host
byte order and 64bit architectures into account from the ground up. (I
understand though why Kristian made the announcement in this early
phase, and I agree with him that this kind of development has to go into
the open early.)

> I spent the better
> part of 3 months getting this right on PPC and UltraSPARC. Not because
> it's hard to fix these issues, but because the hardware is not well
> defined for a lot of these cases (I know you've seen the ohci1394 code
> to handle endianness).
> 
> So while I can understand that ieee1394 doesn't have much man power
> right now, and that there are some hard to find bugs in the current
> tree, I can't see how starting from scratch alleviates this.
> 
> The tree is years old, and a lot of work has been put into it (lots of
> my work, I'll admit I'm being a little protective). I'm not sure that
> "replacing" it is wise, or even needed. Fork it, clean it up, but
> rewriting just doesn't make sense.
> 
> Granted, this is your time, and you can spend it how you want, I just
> don't want to see the ieee1394 stack take a step backwards in the hopes
> that it will be better a year down the road.

No matter in which way we will put Kristian's work to use, regressions
must not happen --- beyond the measure that unintentionally happens when
bugs get fixed. Mainline's FireWire stack lost a lot of trust at
end-users and application developers because of periods of sometimes
very visible regressions.
-- 
Stefan Richter
-=====-=-==- ==-- --==-
http://arcgraph.de/sr/
