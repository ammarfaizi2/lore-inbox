Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271272AbTG2F7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271274AbTG2F7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:59:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:46819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271272AbTG2F7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:59:32 -0400
Date: Mon, 28 Jul 2003 22:59:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S. Anderson" <sa@xmission.com>
Cc: sa@xmission.com, pavel@xal.co.uk, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-Id: <20030728225914.4f299586.akpm@osdl.org>
In-Reply-To: <20030728231812.A20738@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk>
	<20030728201954.A16103@xmission.xmission.com>
	<20030728202600.18338fa9.akpm@osdl.org>
	<20030728231812.A20738@xmission.xmission.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S. Anderson" <sa@xmission.com> wrote:
>
> Thanks, that fixes the oops Pavel reported!
> 
> But I now realize the oops I am getting is different...
> 
> It happens only if any of these "i810fb, i810_audio or intel-agp"
> are compiled in the kernel or insterted as modules.
> 
> i810fb, i810_audio or intel-agp load up fine and seem to all work
> properly. I only get the oops when I put a card into my cardbus slot.
> 
> this is what i think happens, when I put the card in, it sets off some
> functions that will try to get a driver for the card I just inserted.
> when it gets to the pci_bus_match function, my cards vendor and device 
> numbers are tested against a drivers id_table. when that driver is 
> "i810fb, i810_audio or intel-agp" (and i810fb, i810_audio or intel-agp
> is allready loaded) the id_table is at an address that cant be handled, 
> thus cauing the oops. I am having trouble figuring out why 
> pci_drv->id_table isnt valid in this case.

Everything seems happy here:

vmm:/home/akpm> lsmod
Module                  Size  Used by
i810fb                 31572  0 
cfbcopyarea             4700  1 i810fb
vgastate               10660  1 i810fb
cfbimgblt               4068  1 i810fb
cfbfillrect             4820  1 i810fb
intel_agp              16940  1 
agpgart                32496  1 intel_agp
i810_audio             34208  0 
ac97_codec             18932  1 i810_audio
rtc                    15744  0 

Can you do modprobe-by-hand, see which one causes the oops?
