Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUEWBfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUEWBfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 21:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUEWBfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 21:35:46 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:16775 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261931AbUEWBfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 21:35:44 -0400
Date: Sun, 23 May 2004 03:35:37 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
Message-ID: <20040523013537.GB29269@vana.vc.cvut.cz>
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net> <20040522125108.GB4589@devserv.devel.redhat.com> <40AF55AF.2020506@winischhofer.net> <20040522163214.A32228@electric-eye.fr.zoreil.com> <40AF73D5.5010202@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AF73D5.5010202@winischhofer.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 05:37:57PM +0200, Thomas Winischhofer wrote:
> 
> Hm. Were the matrox folks asked for a "clear interface" in advance when 
> they started using the 'n' ioctls? Am I too polite? ;)

You are too polite. 

In the past ncpfs was using 'n' with 'all' subcodes assigned to it.
Back when I needed some numbers, I simple shrunk ncpfs to 0x00-0xDF, assigning
0xE0-0xFF to matroxfb (I maintain both, so it is simple...). It looks like that
someone visited ncpfs's assignment since then, as now ncpfs has only 0x00-0x7F
assigned to it (according to the ioctl-numbers; I have no idea who made this
0x80-0xDF hole in my nice range).

On other side, matroxfb uses standard VIDIOC_* v4l2 ioctls for exporting
TV-out's brightness/saturation/... to the userspace. And it causes neverending
pain. Currently Debian's /usr/include headers contain VIDIOC_S_CTRL
definition:

#define VIDIOC_S_CTRL           _IOW  ('V', 28, struct v4l2_control)

while kernel uses

#define VIDIOC_S_CTRL           _IOWR ('V', 28, struct v4l2_control)

and so no apps built with /usr/include headers on Debian do work on matroxfb's
(or anyone else's) v4l2 interface :-( Better to not give description of your ioctls to anyone,
or they'll "fix" them.
						Best regards,
							Petr Vandrovec
 
