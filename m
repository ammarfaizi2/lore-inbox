Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUITAEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUITAEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUITAEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:04:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:27580 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264997AbUITAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:04:37 -0400
Subject: Re: udev is too slow creating devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <414D96EF.6030302@softhome.net>
References: <414C9003.9070707@softhome.net>
	 <1095568704.6545.17.camel@gaston>	<414D42F6.5010609@softhome.net>
	 <20040919140034.2257b342.Ballarin.Marc@gmx.de>
	 <414D96EF.6030302@softhome.net>
Content-Type: text/plain
Message-Id: <1095638602.18431.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 10:03:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 00:25, Ihar 'Philips' Filipau wrote:

>    Well, can then anyone explain by which mean (black magic?) kernel 
> mounts root file system? block device might appear any time, file system 
> might take ages to load.
> 
>    Hu? How is init/do_mounts.c still works then? Or it is needs to be 
> fixed with messages a-la "root file system will be available shortly, we 
> do hope" and "please plug in again your hard-wired IDE drive"?

Mounting of the root device is a fragile process that happens to work
by chance on current setups, but there is a reason while distributions
are now moving to a model where an initrd/initramfs is loaded as the
root device first, which then can do the proper selection of a real
root device, eventually waiting for one to show up, and then pivot to
it. The kernel "built-in" root selection already fails most of the
time with usb-storage or sbp2 (ieee1394)

>    People, you must learn doing abstractions carefully. If device is 
> hard-wired - user *will* expect (as kernel itself does) that it is 
> available all the time after modprobe'ing driver.

Arrogance will lead you nowhere here, so step down from your pedestal
and try accepting that your view on things might not be the right one.

Ben.


