Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVA3LIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVA3LIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVA3LIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:08:24 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:13586 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261673AbVA3LHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:07:53 -0500
Date: Sun, 30 Jan 2005 12:16:34 +0100
To: airlied@gmail.com
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Message-ID: <20050130111634.GA9269@hh.idb.hist.no>
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no> <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de> <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F76B4D.8090905@hist.no>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What is the most useful to do now?
>> Binary searching for the crash between bk15 and rc2?   Or:]
>
> I'd keep looking for the crash... the out of memory will probably
> disappear with a later snapshot..


After sorting out a stupid build problem, here is the result for
the binary search for the crash.
2.6.9         crash
2.6.9-rc2     pci-oom
2.6.9-rc3     crash
2.6.9-rc2-bk7 crash
2.6.9-rc2-bk4 crash
2.6.9-rc2-bk2 pci-oom
2.6.9-rc2-bk3 krash in ifconfig  

Up to 2.6.9-rc2-bk2 we don't get a crash, instead the X log shows this:

(EE) RADEON(0): [pci] Out of memory (-1007)

and gives up on drm in an orderly fashion.  
2.6.9-rc2-bk4 crashes though.  As usual, the X log ends with:
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(**) RADEON(0): Option "InitPrimary" "on"
(II) Truncating PCI BIOS Length to 53248


2.6.9-rc2-bk3 wasn't tested further, because the kernel dies upon
running "ifconfig" which must be some other temporary bug.
X will probably be difficult without IPv4 anyway.

Helge Hafting 

