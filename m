Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWIHRKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWIHRKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWIHRKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:10:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:18853 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWIHRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:10:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z6T382y4FhkGEXmv2f+Y62fiG1FHIVY9YKfi8v50+h58lGC8GYZoOJVIj1ENTCys4394/6PsdMlN2UW9SLvqbXhGZGCO+bec4eDYhcq++Kxd0NaGo267nBSLX7j231ESnhhVXc0NMmCBmaiOI/t2rAVSxndByeKx1UYAOyv9EVg=
Message-ID: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
Date: Fri, 8 Sep 2006 19:10:06 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Driver - cfag12864b Crystalfontz 128x64 2-color Graphic LCD
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just finished a driver for the cfag12864b Crystalfontz 128x64
2-color Graphic LCD Series. You can check them at:
http://www.crystalfontz.com/products/12864b/

The drivers use the parallel port (data & control). Although the
company doesn't recommend it, they say the cfag12864b works fine that
way. The (unofficial) wiring is described at:
http://liquid-mp3.schijf.org/schematics/wiring_CFAG12864BTMIV.gif The
wiring as seen is used by Windows programs like LCDStudio, so although
it isn't official, it's the most popular, so I wrote the driver
expecting that wiring.

The driver works fine, the interface is easy (I think) and I have done
as many tests as I could. I have tried it on some computers, some
different kernel versions with two different LCDs and works well on
all configurations.

Because this kind of driver is unusual and I'm a newbie device driver
writer, I would like to receive some answers/help/suggestions:

1. The cfag12864b has two ks0108 controllers. Each one share the same
wiring, so you have to set one bit to tell the cfag12864b which
controller are you talking to. So I wrote a small driver for the
ks0108 controller, and then a more general cfag12864b driver which
depends on the ks0108 driver. This way, other programmers could use
the ks0108 driver and easily write more Graphic LCD drivers which uses
the same controller, instead of rewriting all the code: "Do one thing
and do it well.". I thought it was the right way to approach the
problem. Was it?

2. The driver right now is requesting ports using request_region at
init time. I know there are the parport_pc, parport and lp drivers. I
set the port as a module parameter, so you can change it easily. That
way, you can load both parport and cfag12864b modules. Still, I'm not
sure if it is the right approach. Should I use the parport interface
to request and use the ports, or leave the driver as is?

3. The module uses a external script to create the neccesary devices.
By now, I have just one device, some like /dev/cfag12864b0 where you
can write, and it will be printed on the screen. Although I have tried
to simplify it as much as possible, still you have to know the way the
LCD is going to print the data you send. Just reading the driver
documentation or doing two or three "echo hello > /dev/cfag12864b0"
you can figure out how your user-space application should write the
device. Still, I wrote a example function application that reads a
128x64 boolean matrix and writes a 1024 bytes vector (128*64/8)
properly that you can send to the device. I can easily write a new
device, like /dev/cfag12864b0matrix where you can write the 128x64
matrix directly, without worrying anything else. But, on the other
side, although it is simpler, I think it is worse, because you have to
wait until you receive all the boolean matrix before the driver can
start converting it to the cfag12864b format. If this makes no sense,
please tell me, I will explain it further.

4. I would like to release the driver to the public, GPL'ed. Has it
any possibility to enter in the mainstream kernel? Who can review it?
...?

It is my first attempt to write an useful Linux device driver, so I
expect this won't be a lame :-)

Thank you,

          Miguel Ojeda
