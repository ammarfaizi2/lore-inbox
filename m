Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSAXTX1>; Thu, 24 Jan 2002 14:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSAXTXS>; Thu, 24 Jan 2002 14:23:18 -0500
Received: from dpc6682034030.direcpc.com ([66.82.34.30]:260 "EHLO
	oscar.hatestheinter.net") by vger.kernel.org with ESMTP
	id <S288955AbSAXTXE>; Thu, 24 Jan 2002 14:23:04 -0500
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
From: Disconnect <lkml@sigkill.net>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201221817410.11025-200000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201221817410.11025-200000@infcip10.uni-trier.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 14:19:35 -0500
Message-Id: <1011899975.2029.9.camel@oscar>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 12:21, Daniel Nofftz wrote:
> if you want to test this patch:
> 1. first apply the patch
> 2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
>    in the kernel config
> 3. add to the "append" line in /etc/lilo.conf the "amd_disconnect=yes"
> statemand (or after reboot enter at the kernel-boot-prompt
> "amd_disconnect=yes")
> 4. build a knew kernel
> 5. report to me, whether you have problems ...

I just finished testing the patch, and it shows huge temperature savings
(10 to 15C when idle).  The problem is, it screws up v4l (bttv), usb
keyboard under X becomes effectively unusable, etc.

V4l - using xinerama, xvideo, v4l under X4.1.0.1 - the picture gets
jagged lines through it (offset scanlines maybe?) and tends to be jumpy.

usb keyboard - its slightly bad under X anyway (sticky keys, modifiers,
etc) but with this patch I had to log in from another system just to
shut down - even ctrl-alt-delete wouldn't work. In about 15 mins of
arguing with it I probably got 20 keystrokes into the xserver. (mouse
continued to work fine however.)

Seems like a great idea, if these problems can be solved. I'd love to
get my cpu back down to 30C on a regular basis ;)

(Currently running the same kernel w/o amd_disconnect=yes and it isn't
showing any problems at all.)

Motherboard is an Iwill kk266 (kt133) w/ a 1.2G tbird, 512M ram, 2
aic7xxx (one pcb w/ pci bridge)
Primary video: nvidia geforce2 mx (yah yah but it works ;) ..)
Second/Third video: matrox mga g100 (4port card, 2 ports in use)

Also, I noticed an odd problem w/ ACPI. dmesg shows:
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
..and:
 ls -l /proc/acpi/button/
total 0
dr-xr-xr-x    2 root     root            0 Jan 24 14:19 power/
dr-xr-xr-x    2 root     root            0 Jan 24 14:19 power/


