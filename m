Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUDLJIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 05:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUDLJIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 05:08:42 -0400
Received: from bolt.sonic.net ([208.201.242.18]:39648 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262650AbUDLJIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 05:08:41 -0400
Date: Mon, 12 Apr 2004 02:08:17 -0700
From: David Hinds <dhinds@sonic.net>
To: Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Message-ID: <20040412090817.GA3158@sonic.net>
References: <200404120145.22679.daniel.ritz@gmx.ch> <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass> <20040412082801.A3972@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412082801.A3972@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 08:28:01AM +0100, Russell King wrote:
> 
> > 3) FOR FURTHER INVESTIGATION: Does linux hdsp driver force the f0
> > value upon the 0x81 register or is it that in Linux one simply
> > cannot select d0 value for whatever reason
> 
> I suspect it may be caused by using a byte access to a longword-sized
> register.  0x81 is supposed to be accessed via:
> 
> setpci -s a.0 0x80.l
> 
> which of course means its bits 8 to 15.

I don't think so; I'm not sure what the PCI spec has to say about it,
but I have not had problems doing byte reads/writes for longer PCI
configuration registers.  Bit 9 of the sysctl register for the TI 1410
is "socket activity"; it is read only and is cleared after each read.
The key change is setting bit 14 (enable upstream burst reads).

Regarding the register at 0xc9, I don't think that is defined in any
TI bridge data sheet; it is in a "reserved" range.

-- Dave
