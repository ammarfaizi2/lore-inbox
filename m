Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVCHGOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVCHGOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCHGNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:13:53 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:55493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261598AbVCHGMn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:12:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iQR8t5e/x5qb2oK+MBUp5pbBkTF7q7lwKTkLcu7g96FWz96UPd3On4Gf026jtJl7vlI3cZF9okZb6/kp9NEzsjpISAuaS2cULqS7WlxTMnwm5954ZQwI3ZlCqWIu9SShGKpyA0A6lenSzcVPg5dTN6ekX9DBs6h4DNrKxAK5mjA=
Message-ID: <9e47339105030722127c697df@mail.gmail.com>
Date: Tue, 8 Mar 2005 01:12:40 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [announce 7/7] fbsplash - documentation
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <200503080418.08804.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 04:18:07 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Dinsdag 08 März 2005 03:17, Michal Januszewski wrote:
> 
> > +It's possible to set path to the splash helper by writing it to
> > +/proc/sys/kernel/fbsplash.
> 
> It should probably just use its own hotplug agent instead of calling
> the helper directly.

Framebuffer is already generating hotplug add/remove messages. 

HOTPLUG_TIME='Mon Feb 28 02:15:25 EST 2005'
PHYSDEVPATH=/devices/pci0000:00/0000:00:01.0/0000:01:00.0
SUBSYSTEM=graphics
HOTPLUG_ARGS=
DEVPATH=/class/graphics/fb0
HOTPLUG_TYPE=graphics
ACTION=add
PHYSDEVDRIVER=radeonfb
DEBUG=yes
PHYSDEVBUS=pci
SEQNUM=537

This event can be caught in early userspace. The helper app will need
to live on initramfs/initrd and be small. Statically link it to klibc.

You can use the modular fb patch that has been recently posted (just
about to go in -mm) to make hotplug fbdev debugging much simpler.

Alternatively you might want to look at how request_firmware works.
You could easily load the picture as if it were firmware. I'm looking
at modifying request_firmware to be more general right now.

A direct call to call_usermodehelper() requires you to build a path
and app name into the driver.

-- 
Jon Smirl
jonsmirl@gmail.com
