Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUAGIUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265364AbUAGIUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:20:23 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:37638 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265345AbUAGIUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:20:22 -0500
Message-ID: <3FFBC405.80405@aitel.hist.no>
Date: Wed, 07 Jan 2004 09:32:05 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com>
In-Reply-To: <20040106222959.GA3188@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

> 2.) Windows works with buggy BIOSes because of the way it calls them.
> 
> I looked into how Windows handles the PnPBIOS and may have discovered why it
> works on buggy BIOS.  It turns out that exclusively realmode calls are used.
> See www.missl.cs.umd.edu/Projects/sebos/winint/index2.html#pnpbios.  My
> knowledge is limited in this area of the x86 architecture but it is my
> impression that it would not be possible, or perhaps worth it, to implement
> realmode calls for the Linux PnPBIOS driver because of the time it is
> initialized.

Are these PnPBIOS calls needed at boot only?  If so, consider
querying the bios early in the boot code - before
switching to protected mode.  Just store the results,
and let the driver read them later instead of doing
calls that crash.

Helge Hafting

