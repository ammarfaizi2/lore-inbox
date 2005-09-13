Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVIMNPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVIMNPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVIMNPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:15:08 -0400
Received: from quechua.inka.de ([193.197.184.2]:13230 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932646AbVIMNPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:15:06 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [udev/vcs] tons of creating/removing /dev/vcs* during boot
To: linux-kernel@vger.kernel.org
Mail-Copies-To: aj@dungeon.inka.de
Date: Tue, 13 Sep 2005 15:14:59 +0200
References: <20050912170618.69e18341.froese@gmx.de> <20050913055533.GA7206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20050913131138.C5B07210BC@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>> Best would be of course to generate only a single event at the same
>> time the tty device is create.
> 
> That's what you are seeing.  And then watching as it's being destroyed.
> And then created.  And then destroyed.  And so on (virtual ttys are
> nasty at times..)

wait a second, the kernel code opens /dev/console before running
init. so that should trigger that first hotplug event. and if
init is a process that does not close stdin/out/err, there should
not be any additional hotplug event, right?

I know for sure that some gentoo machine created > 3000 hotplug
events during bootup. I'm note sure if the init closed stdin/out/err,
and that installation was replaced by debian anyway, but it sure
killed the machine, if I hadn't disabled hotplugging (3000 bash
processes need more ram than a normal machine has).

init strarts processes and those sure have stdin/out/err open,
so they can write to the console. so I somehow doubt it closes
and opens those all the time, but I haven't checked the code.
so I wonder: is or was there any bug in the kernel where hundreds
or thousands of hotplug requests are created, simply because
processed are executed? 

it is a fact I saw thousands of hotplug events during a boot sequence.
I'd like to know why that happened, and whether it would happen again.
rm -rf /sbin/hotplug and switching to udevd is once option to solve
the problem, but not an explanation why it happened in the first place.

Regards, Andreas
p.a. I don't use udevd, but my initramfs disables hotplug and
the last initscript enables it again. also works ok.
