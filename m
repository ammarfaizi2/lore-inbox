Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTIHMal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbTIHMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:30:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22146 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262202AbTIHMak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:30:40 -0400
Subject: Re: Mapping large framebuffers into kernel space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908001716.78049.qmail@web14901.mail.yahoo.com>
References: <20030908001716.78049.qmail@web14901.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063024131.21050.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 13:28:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On my system I have 1GB physical and 1GB swap. So there should always be some
> open address space in the 1-4GB kernel address space. Would it be better to map

The kernel address space is 3Gb-4Gb (ie 1Gb sized) giving a 3Gb user
address space.

> The kernel DRM drivers map framebuffers up to 256MB in size into user space.
> Could this be mapped as a single 256MB page instead of 64K 4KB ones?

Well the CPU only has 4K/4Mb as the basic choices but you could map it
using 4Mb pages in theory - in practice its rather complicated because
of the VM handling. 2.6 has some basic stuff for doing this kind of
thing with fixed unswappable memory.

However if your radeon driver is touching the RAM often enough to matter
you have another problem.

