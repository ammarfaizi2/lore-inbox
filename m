Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUHKMZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUHKMZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268041AbUHKMZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:25:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:65412 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S268039AbUHKMZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:25:20 -0400
Date: Wed, 11 Aug 2004 14:27:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, "David N. Welton" <davidw@eidetix.com>,
       Sascha Wilde <wilde@sha-bang.de>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040811122711.GA5759@ucw.cz>
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408110131.14114.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 01:31:13AM -0500, Dmitry Torokhov wrote:
> On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> > By putting a series of 'crashme/reboot' calls into the kernel, I 
> > narrowed a possibl cause of it down to this bit of code in 
> > drivers/input/serio.c:753
> > 
> > /*
> >  * Write CTR back.
> >  */
> > 
> > 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> > 		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
> > 		return -1;
> > 	}
> > 
> > If I do the reboot instructions before this, it reboots fine. 
> > Afterwards, and it just sits there, no reboot.
> 
> 
> Hi,
> 
> Could you please try the patch below? I am interested in tests both with
> and without keyboard/mouse. The main idea is to leave ports that have been
> disabled by BIOS alone... The patch compiles but otherwise untested. Against
> 2.6.7.

Well, this has a problem - plugging a mouse later will never work, as
the interface will be disabled by the BIOS if a mouse is not present at
boot.

> 
> BTW, do you both have the same motherboard/chipset? Maybe a dmi entry is in
> order...
> 
> Thanks!
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
