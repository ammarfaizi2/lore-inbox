Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269589AbUINWDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbUINWDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUINWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:00:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:23941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269436AbUINVz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:55:59 -0400
X-Authenticated: #1725425
Date: Wed, 15 Sep 2004 00:03:03 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
Cc: greg@kroah.com, cfriesen@nortelnetworks.com, cate@debian.org,
       linux-kernel@vger.kernel.org, tigran@veritas.com, md@Linux.IT
Subject: Re: udev is too slow creating devices
Message-Id: <20040915000303.5c179979.Ballarin.Marc@gmx.de>
In-Reply-To: <414757FD.5050209@pixelized.ch>
References: <41473972.8010104@debian.org>
	<41474926.8050808@nortelnetworks.com>
	<20040914195221.GA21691@kroah.com>
	<414757FD.5050209@pixelized.ch>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 22:43:41 +0200
"Giacomo A. Catenazzi" <cate@pixelized.ch> wrote:

> 
> After a brief discussion with debian udev maintainer, I've an
> other proposal/opinion.
> 
> The "bug" appear only in two places: at udev start and after
> a modprobe, so IMHO we should correct these two place, so that:

This cannot be fixed easily and there would be little gain but great
risks. For example, I have a device where reading partition tables can
take up to two seconds. Other devices could be broken and modprobe would
never return. This would effectively freeze the system when it happens in
boot scripts.

> - from a user side perspective it is the right thing!
>    (after a successful modprobe, I expect module and devices
>     are created sussesfully)

This assumption is wrong, even with a completely static /dev.
Common example:
modprobe usb-storage / ppa / whatever
Now, for any reason the kernel is unable to read the partition table.
The script tries to access /dev/sda1 => boom
In fact, udev is even an improvement here. Instead of checking the device
node repeatedly you simply wait for udev to call you. When it does you can
be sure that the device node exists and is valid.

> Else every distribution should create a script for
> every init.d script that would eventually use (also
> indirectly) a kernel module.

Why not? This is the best way to achieve true and reliable hotplug
support.

Regards
