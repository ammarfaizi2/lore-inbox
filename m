Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281822AbRKRXtb>; Sun, 18 Nov 2001 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRKRXtV>; Sun, 18 Nov 2001 18:49:21 -0500
Received: from mail.htn.de ([193.254.18.42]:20121 "EHLO mail.htp-tel.de")
	by vger.kernel.org with ESMTP id <S280051AbRKRXtN>;
	Sun, 18 Nov 2001 18:49:13 -0500
Date: Sun, 18 Nov 2001 16:32:45 +0100
From: Ingo Saitz <Ingo.Saitz@stud.uni-hannover.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Debugging (?) output in 2.4.14 breaks radeon framebuffer
Message-ID: <20011118163244.A1100@pinguin.subspace.exe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

MoiN

On bootup when the kernel activates the framebuffer console all
its revious messages remain on the screen, the tux logo is
displayed in the top corner and all remaining boot messages are
printed in one line over the belly of the pinguin. After bootup
all other consoles are working correctly and I can clean up the
mess on the first console by logging in and running "reset".

The last line displayed before linux activates the framebuffer is

radeonfb: ref_clk=2700, ref_div=60, xclk=16000 from BIOS

The next for lines, which are printk()d in radeon_write_mode():

CRTC_H_TOTAL_DISP = 0x4f0063, H_SYNC = 0x8c02a2
CRTC_V_TOTAL_DISP = 0x1df020c, V_SYNC = 0x8201ea
PPLL_DIV_3 = 0x301bf, PPLL_REF_DIV = 0x3c
DDA_CONFIG = 0x108032f, DDA_ON_OFF = 0x3e85924

seem to be the offending ones, because they are printed on the
screen _during_ the setup of the registers. Commenting them out
(see attached patch) does revert to a working console in
framebuffer mode.

My system: I have a Radeon (QD) SDR 32MB on AGP and a PII Celeron
533MHz on Intel LX Board (Elitegroup P6LX-A+)

    Ingo
-- 
/* So there I am, in the middle of my `netfilter-is-wonderful' talk in
 * Sydney, and someone asks `What happens if you try to enlarge a 64k
 * packet here?'.  I think I said something eloquent like `fuck'.  */
               -- net/ipv4/netfilter/ip_nat_ftp.c in linux 2.3.99-pre2

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeon-bf.diff"

diff -Ndurp linux/drivers/video/radeonfb.c linux/drivers/video/radeonfb.c
--- linux/drivers/video/radeonfb.c	Sun Nov 18 13:24:46 2001
+++ linux/drivers/video/radeonfb.c	Sun Nov 18 13:20:10 2001
@@ -2347,7 +2347,7 @@ static void radeon_write_mode (struct ra
 	OUTREG(CRTC_OFFSET, 0);
 	OUTREG(CRTC_OFFSET_CNTL, 0);
 	OUTREG(CRTC_PITCH, mode->crtc_pitch);
-#if 1
+#if 0
 	printk("CRTC_H_TOTAL_DISP = 0x%x, H_SYNC = 0x%x\n",
 		mode->crtc_h_total_disp, mode->crtc_h_sync_strt_wid);
 	printk("CRTC_V_TOTAL_DISP = 0x%x, V_SYNC = 0x%x\n",

--wRRV7LY7NUeQGEoC--
