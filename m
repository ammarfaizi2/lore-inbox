Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUHQO3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUHQO3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHQO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:28:13 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:27778 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S268266AbUHQOXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:23:22 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Tue, 17 Aug 2004 16:23:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Hang after "BIOS data check successful" with DVI
Cc: Shaun Jackman <sjackman@telus.net>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <EB9C984875@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 04 at 9:51, Zwane Mwaikambo wrote:
> On Tue, 17 Aug 2004, Petr Vandrovec wrote:
> 
> > On 16 Aug 04 at 16:55, Shaun Jackman wrote:
> > > When I have a DVI display plugged into my Matrox G550 video card the
> > > boot process hangs at "BIOS data check successful". I am running Linux
> > > kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
> > > boot without the DVI display plugged in, I can plug it in after the
> > > boot process and the display works.
> >
> > Try disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
> > in arch/i386/boot/video.S. Also which bootloader you use? From
> > quick glance at bootloaders, grub1 seems to set %sp to 0x9000, while
> > LILO to 0x0800. And I think that 2048 byte stack (plus something already
> > allocated by loader) might be too small for DDC call, as MGA BIOS first
> > creates EDID copy on stack...
> 
> Urgh, this bug is still around :(
> 
> http://bugme.osdl.org/show_bug.cgi?id=1458

Yes, it looks like this very same problem. From looking at G400 BIOS
it would need 380 bytes plus whatever PCI BIOS services need - and PCI
BIOS system calls are specced to fit into 1024 bytes on stack. G550 BIOS
seems to need 200 bytes plus whatever PCI BIOS services need. So
LILO's 2KB should be sufficient - and indeed I do not see problem
with G550 & LILO (Debian's 22.5.9) here, with both DVI and analog cables 
connected in.
                                                Best regards,
                                                    Petr Vandrovec
                                                    

