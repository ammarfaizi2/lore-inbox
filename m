Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTLOS0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLOS0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:26:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:54959 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263937AbTLOS0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:26:19 -0500
Date: Mon, 15 Dec 2003 10:26:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDC9DC5.2070302@intel.com>
Message-ID: <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
References: <3FDC9DC5.2070302@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This really isn't appropriate. The

	With PCI-E, config space accessed through memory. Each device gets
	its own 4k memory mapped config, total 256M for all devices.

thing _really_ does not work on x86, since 256M of IO mapping is _way_ way
too much.

You _really_ need to allocate a FIXMAP entry (just one), and then use

	set_fixmap_nocache(FIX_PCIEXPRESS, phys);

to set it up for each device.

That's actually going to be a lot simpler than what you do now.

		Linus

