Return-Path: <linux-kernel-owner+w=401wt.eu-S933137AbWLaL6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbWLaL6J (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 06:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbWLaL6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 06:58:09 -0500
Received: from iona.labri.fr ([147.210.8.143]:34290 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933137AbWLaL6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 06:58:07 -0500
Message-ID: <4597A5A9.70301@ens-lyon.org>
Date: Sun, 31 Dec 2006 12:57:29 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 device naming problems in 2.6.20-rc2-git1
References: <45977081.6040303@shaw.ca>
In-Reply-To: <45977081.6040303@shaw.ca>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Having some intermittent problems using my ipw2200 wireless card on
> 2.6.20-rc2-git1 (may affect earlier versions as well) under Fedora
> Core 6 i386. It appears that sometimes on bootup the interface gets
> named with a junk name like __tmp32284835 and it doesn't show up in
> ifconfig. rmmod/insmod on ipw2200 fixes the problem and it shows up as
> eth1 again. I don't think this problem happened with Fedora 2.6.18
> kernels..
>

I've seen some problems like this with kernels <= 2.6.19. But it is now
fixed since the following commit (merged in rc1 IIRC). The symptoms were
that it the interface was getting a strange name (something like
"eth0_tmp") when udev was renaming it with DRIVERS=="?*" in the rule.
See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=389250. I removed
DRIVERS from the rule to avoid the problem, but the following commit was
definitely fixing the problem at this point. I didn't check again recently.

Brice



commit 1901fb2604fbcd53201f38725182ea807581159e
Author: Kay Sievers <kay.sievers@novell.com>
Date:   Sat Oct 7 21:55:55 2006 +0200

    Driver core: fix "driver" symlink timing

    Create the "driver" link before the child device may be created by
    the probing logic. This makes it possible for userspace (udev), to
    determine the driver property of the parent device, at the time the
    child device is created.

    Signed-off-by: Kay Sievers <kay.sievers@novell.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


