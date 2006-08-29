Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965268AbWH2TFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbWH2TFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965272AbWH2TFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:05:54 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:47026
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965268AbWH2TFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:05:51 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Tue, 29 Aug 2006 21:04:24 +0200
User-Agent: KMail/1.9.1
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com>
In-Reply-To: <20060829183208.GA11468@kroah.com>
Cc: Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org, David Lang <dlang@digitalinsight.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292104.24645.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 20:32, Greg KH wrote:
> On Tue, Aug 29, 2006 at 08:46:45AM -0700, David Lang wrote:
> > On Mon, 28 Aug 2006, Greg KH wrote:
> > 
> > >I think the current way we handle firmware works quite well, especially
> > >given the wide range of different devices that it works for (everything
> > >from BIOS upgrades to different wireless driver stages).
> > 
> > the current system works for many people yes, but not everyone.
> > 
> > I'm still waiting to find a way to get the iw2200 working without having to 
> > use modules.
> 
> Sounds like a bug you need to pester the iw2200 developers about then.
> I don't think it has much to do with the firmware subsystem though :)

Well, yes and no.
The ipw needs the firmware on insmod time (in contrast to bcm43xx
for example, which needs it on ifconfig up time).
So ipw needs to call request_firmware at insmod time. In case of
built-in, that is when the initcall happens. No userland is available
and request_firmware can not call the userspace helpers to upload
the firmware to sysfs.
Well, not really easy to find a sane solution for this. :)

-- 
Greetings Michael.
