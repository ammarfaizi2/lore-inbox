Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265759AbTFSKfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbTFSKfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:35:22 -0400
Received: from smtp.inet.fi ([192.89.123.192]:41931 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S265759AbTFSKfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:35:15 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: [2.5.72-mm1] Matroxfb behaves buggy
Date: Thu, 19 Jun 2003 13:49:45 +0300
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306191349.45382.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Relevant .config

# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_MATROX_MULTIHEAD is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

I used the same append="video:matrox..." line as with Debian 2.4.20 kernel, 
which defines 1280x1024@60Hz for my TFT

append="elevator=as video=matrox:vesa:0x31B,pixclock:8028,    \
left:32,right:32,upper:21,lower:21,hslen:432,vslen:10"

I tried both MATROX_G450 and MATROX_G100 drivers, first G450 and then G100.  I 
find it odd that both are configured, since selecting G450 hides G100 in 
"make menuconfig", so I have all the time assumed it is disabled when it's 
hidden.  Might the problem be caused by including both?  I'll go and see, but 
I think it's not the only problem.

What's the difference between them?  .config help ought to tell this briefly.

When 2.4.20 switches to 1280x1024, the screen goes black with 2.5.72, then 
some seconds pass and 1. vertical dark gray lines appear, and 2. some dark 
blue areas between them.  Some seconds pass and X comes up as if nothing was 
wrong.

I logged in to the console as root, not seeing anything.  The TFT display 
reported 640x480@60Hz in it's menu.  I typed "fbset 1280x1024" for my custom 
1280x1024@60Hz mode.  Oddly, X display appeared at 1280x1024 resolution, mode 
parameters being something between the fbset and X modes, but I could do 
nothing, so I pushed the reset button.

syslog had a screenful of "^@^@^@^@^@^@^@^@^@^@^@" between time before the 
lockup and next boot, as did kern.log

Additionally, syslog had another screenful of 
"<9C><B5><EC><FF>^N^NNz<FC><FF>^S<C4>^?<A9><C7><FF><AB>  \
<B1><82><DE>^_\<CB>W<C0><CE><CE><DE>      \
<CE><F5><93>!<FF>^ZT<FC>fI^?td<F4>"

  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc MGA G400 AGP (rev 4).
      IRQ 16.
      Master Capable.  Latency=16.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd2000000 [0xd3ffffff].
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4003fff].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd57fffff].

SMP and pre-empt enabled.

-Kimmo Sundqvist

