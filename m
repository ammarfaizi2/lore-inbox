Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWCHMgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWCHMgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWCHMgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:36:04 -0500
Received: from secure.htb.at ([195.69.104.11]:773 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1750939AbWCHMgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:36:02 -0500
Date: Wed, 8 Mar 2006 13:35:40 +0100
From: Richard Mittendorfer <richard@mittendorfer.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SUSPEND] Screen slides down after STR / neomagic
Message-Id: <20060308133540.07cc159a.richard@mittendorfer.com>
In-Reply-To: <20060308110102.GH1710@elf.ucw.cz>
References: <20060306100905.0199e7b5.delist@gmx.net>
	<20060307214337.GA1777@elf.ucw.cz>
	<20060308004555.fe20b052.delist@gmx.net>
	<20060308110102.GH1710@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FGxtI-0007Oy-00*vH5HalLC0MM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@suse.cz> (Wed, 8 Mar 2006 12:01:02
+0100):
> On St 08-03-06 00:45:55, Richard Mittendorfer wrote:
> > Also sprach Pavel Machek <pavel@ucw.cz> (Tue, 7 Mar 2006 22:43:37
> > +0100):
> > > On Po 06-03-06 10:09:05, Richard Mittendorfer wrote:
> > > > Hello,
> > > > 
> > > > Toshiba Libretto; Every time I suspend to RAM an come back to
> > > > Console or later exit Xorg (it's ok within X), the screen is
> > > > somewhat displaced downward:
> > > 
> > > Did you read Doc*/power/video.txt?
> > 
> > Oh, wasn't aware of this file. (Havn't looked there for a while
> > now.) Now I know what went wrong. :-)
> > 
> > Finally the vbetool trick did it.
> 
> Could you
> 
> 1) try to find out if acpi_sleep=* options can fix it too (they are
> better for debugging)

acpi_sleep=s3_bios|s3_mode|s3_bios,s3_mode  didn't do it.
 
> 2) submit patch for video.txt

#include <dontbeatme.h> =)

This patch adds an entry for handling video bios resets during s3
suspends on toshiba's 110ct/100ct neomagic chip. Tested on 110ct; 
100ct should have the same chipset.

--- linux-2.6.15/Documentation/power/video.txt.orig   2006-03-08
12:35:33.000000000 +0100
+++ linux-2.6.15/Documentation/power/video.txt        2006-03-08
12:36:40.000000000 +0100
@@ -130,6 +130,7 @@ Sony Vaio PCG-F403          ??? (*)
 Sony Vaio PCG-N505SN           ??? (*)
 Sony Vaio vgn-s260             X or boot-radeon can init it (5)
 Toshiba Libretto L5            none (1)
+Toshiba Libretto 100CT/110CT   none, see "VBEtool details" below
 Toshiba Satellite 4030CDT      s3_mode (3)
 Toshiba Satellite 4080XCDT      s3_mode (3)
 Toshiba Satellite 4090XCDT      ??? (*)

> 3) if possible, download s2ram from www.sf.net/projects/suspend (from
> CVS) and add your machine to whitelist?

I'll look into this.

> 								Pavel

sl ritch
