Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTHERRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTHERRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:17:05 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:41856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262385AbTHERRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:17:04 -0400
Subject: Re: IDE locking problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308051414530.7948-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0308051414530.7948-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060103589.1190.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Aug 2003 18:13:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-05 at 13:30, Bartlomiej Zolnierkiewicz wrote:
> HDIO_UNREGISTER_HWIF ioctl.  Together with HDIO_SCAN_HWIF ioctl it
> provides dirty hotswap functionality.  Thats why I mentioned about problem
> with ide_unregister() and non default io bases.

I'm currently testing busstate ioctl based rescanning in 2.4 (long story involving
a laptop). I've made the busstate off code clean up the device - so the hwif becomes
device->present=0 for all devices and busstate on rescans the bus and updates the
device objects.

Its a hack in many ways to keep the base objects present so that the brown and sticky
issues of blk queues in 2.4 never meet the fan of object destruction.

