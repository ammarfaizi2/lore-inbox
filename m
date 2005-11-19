Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVKSFyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKSFyR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 00:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVKSFyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 00:54:17 -0500
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:49055 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750932AbVKSFyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 00:54:16 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 20:18:21 -0800
User-Agent: KMail/1.8.92
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <1132348998.2830.80.camel@laptopd505.fenrus.org> <1132351635.5238.12.camel@localhost.localdomain>
In-Reply-To: <1132351635.5238.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182018.22060.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 18, 2005 2:07 pm, Alan Cox wrote:
> On Gwe, 2005-11-18 at 22:23 +0100, Arjan van de Ven wrote:
> > 1) accessing non-ram memory (eg PCI mmio space) by X and the likes
> >    (ideally should use sysfs but hey, changing X for this will take
> >    forever)
>
> Once sysfs supports the relevant capabilities fixing X actually
> doesn't look too horrible, the PCI mapping routines are abstracted
> and done by PCITAG (ie PCI device). You would need the ISA hole too
> in some cases.

It's actually partly done already (at least for ia64, but the code I put 
together works on x86 too, iirc, and should work elsewhere).  The ISA 
stuff is exported on a per-bus basis in legacy_io and legacy_mem files.

If vbetool and friends want to get at the ROM, they can use the sysfs 
rom file like everyone else.  There are problems with this however, on 
systems where the ROM is unpacked at 0xc0000 or something, especially 
if the unpacked version is modified by the BIOS at startup time, not 
sure how to address that reliably.

Jesse
