Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbSLRVu3>; Wed, 18 Dec 2002 16:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267358AbSLRVu3>; Wed, 18 Dec 2002 16:50:29 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:5892 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267356AbSLRVu1>;
	Wed, 18 Dec 2002 16:50:27 -0500
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: dell i8100 touchstick, 2.5 input -- further info
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 18 Dec 2002 16:58:15 -0500
Message-ID: <m3fzsvj8g8.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been researching the touchstick breakage in 2.5 on the i8100.

The board appears to use a SMC lpc47n252 superIO chip for keyboard and
ps/2 support.  Details on the chip are at:

http://www.smsc.com/main/datasheets/47n252.pdf
http://www.smsc.com/main/datasheets/47n252add.pdf

It has four ps/2 ports, matrix kb support and an i8051 compatible
µcore.  The i8051 code, then, is responsible for muxing the four ps/2
ports to the host's 0x60/0x64 ioports.

Dell's bios upgrade tool flashes the 47n252.  

I added some printk()s to i8042.c and confirmed that (unless something
else is accessing the kbc during the mux activation test) the synaptics,
et al mux protocol is not supported.  

Something the 2.5 input system is doing is resetting the kbc to a
state where it no longer muxes its ps2 ports.

Obviously, a dump of the i8051 or bios code would provide all the answers.

Does anyone have any ideas on where to go from here?

Having to use the touchpad is bloody irritating. :(

-JimC


