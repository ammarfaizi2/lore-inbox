Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269269AbTGUHWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTGUHWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:22:11 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:18124 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S269269AbTGUHWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:22:07 -0400
Date: Mon, 21 Jul 2003 17:37:54 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, frodol@dds.nl, linux-kernel@vger.kernel.org,
       phil@netroedge.com
Subject: Re: 2.6.0-t1: i2c+sensors still whacky
Message-ID: <20030721073753.GA640@zip.com.au>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au> <20030716225452.GA3419@kroah.com> <20030717153348.GO4612@zip.com.au> <20030718023350.GA5902@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718023350.GA5902@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 07:33:51PM -0700, Greg KH wrote:
> On Fri, Jul 18, 2003 at 01:33:48AM +1000, CaT wrote:
> > > sensors package for 2.4 uses?  And 2.4 works just fine, right?
> > 
> > I don't use 2.4. Haven't for ages.
> 
> I would _really_ encourage you to try this, and run the sensors_detect

Good thing you did. :)

> program to have the scripts tell you what hardware you really have, and
> see if the 2.4 drivers work properly for you.

It both does and does not depending on what I do.

> Without that, I don't know how to debug the 2.5 problem.

Well I hope this helps. I can both duplicated and fix the problem under
2.4. To duplicate all I have to do is compile the kernel without ISA
support and, consequently, not use the ISA bus to read the sensors data.
2.4 then displays the exact same symptoms that 2.5 does. If I compile
ISA in and use it for the data then I get my data and kernel works fine.
To test if all was well I compiled 2.5 (for the next test) and constantly
checked the temperature. It went up during the compile nicely and dropped
when it stopped so I'll assume that the sensors stuff works perfectly
fine under 2.4 with ISA.

Next I booted into 2.5. I loaded i2c-core, i2c-dev, i2c-sensor, i2c-isa
and i2c-piix4. All's fine. Loaded adm1021 (which is the correct driver
btw - it's the one the sensors-detect program detected) and boom, kernel
is molasses. Powercycle and try again, this time only doing:

modprobe i2c-isa
modprobe adm1021

Kernel works fine but no sensor data. find returned only empty directories.
I then did:

modprobe i2c-piix4

and boom! molasses again and dmesg was filled with the errors I previously
posted.

I hope this helps. It seems that there's a distinct lack of interaction
between the i2c/sensors code and isa and that is what might be causing
the problem... but that's just what it looks like to me.

Now, if you need any more debugging done, yell. :)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
