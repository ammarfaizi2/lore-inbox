Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLHXDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTLHXDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:03:24 -0500
Received: from quechua.inka.de ([193.197.184.2]:10456 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261879AbTLHXDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:03:22 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 00:04:08 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 15:50:45 +0000, William Lee Irwin III wrote:
> I would say it's deprecated at the very least. sysfs and udev are
> supposed to provide equivalent functionality, albeit by a somewhat
> different mechanism.

huh?

aj@simulacron:/dev$ find -type c -mount |grep -v pty |wc -l
    164
aj@simulacron:/dev$ find -type b |wc -l
    157
aj@simulacron:/dev$ find /sys/ -name dev |wc -l
    250

After ignoring .devfsd we are left with 70 devices missing:
 - 15 floppy devices
 - 5 input/ devices
 - full, kmem, kmsg, mem, null, port, random, urandom, zero
 - printers/0 
 - 5 misc/ devices
 - 12 snd/ devices
 - 5 sound/ devices
 - 18 vcc/ devices

I wouldn't call udev deprecated, unless a newer kernel has the
essential devices, too. And is there a udev version that can
do devfs names? last time I checked only lanana names were supported.

Some distributions were quite happy to move from /dev and lanana to
devfs with better names. I doubt everyone will rush to udev with
lanana names, and re-introducing makedev for devices not represented
in sysfs doesn't sound very nice either. So 2.8.* might be a nice time
frame for dropping devfs, or at least give sysfs and udev a few months
to catch up on the issues mentioned.

Andreas

