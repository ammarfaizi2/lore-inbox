Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbTGTXDD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbTGTXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:03:02 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:54792
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S268791AbTGTXDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:03:00 -0400
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1058738091.5980.63.camel@localhost.localdomain>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
	 <1058738091.5980.63.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1058743074.4425.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 16:17:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 14:54, Jeremy Fitzhardinge wrote: 
>  Setting root=0303 (in your case) might helps things along.

root=0302 works for me, but root=/dev/hda2 and root=hda2 both fail, even
though /sys/block/hda/hda2/dev contains good values.

Hm, looks like try_path() in init/do_mounts.c generates paths which
don't exist.  If you specify root=/dev/hda2, try_paths will look in 
/sys/block/hda2/dev, but it needs to be /sys/block/hda/hda2/dev.  I
tried playing with it a bit, but then it started trying to mount from
hda4 for no obvious reason...

But this should be enough to go on with.

	J

