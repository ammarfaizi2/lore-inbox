Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRIPNNb>; Sun, 16 Sep 2001 09:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRIPNNW>; Sun, 16 Sep 2001 09:13:22 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:55820 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270992AbRIPNNC> convert rfc822-to-8bit; Sun, 16 Sep 2001 09:13:02 -0400
From: Michael Schroeder <mdhs@gmx.de>
Date: Sun, 16 Sep 2001 13:32:06 GMT
Message-ID: <20010916.13320600@sirius.imsch.de>
Subject: Bug in console driver? 
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2; Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I suppose there is a bug in the 2.4-kernel console driver 
(../drivers/char/console.c).

It seems that (if there is a slow video device) this driver disables the 
handling of interrupts while writing or switching the consoles. 

Symptoms:

If you use the VESA framebuffer, switching to another console prevents 
updating the internal kernel clock (jiffies, xtime) for a short time. 
This effect can grow up to some seconds:

Load the GNU Midnight Commander (mc) and synchronize kernel clock and 
hardware clock with the command 'hwclock --hctosys'.

Then you can see the the difference with 'hwclock && date'.

  # hwclock && date
  Sun Sep 16 10:31:33 2001  -0,154753 ...
  Sun Sep 10 10:31:32 CEST 2001

Now hold down the keys <Ctrl+o> for a some seconds. (This switches the 
window of the Midnight Commander on/off many times)

If you now compare the clocks you yield a difference of some seconds:

  # hwclock && date
  Sun Sep 16 10:33:17 2001  -0,456384 ...
  Sun Sep 16 10:33:12 CEST 2001

5 seconds - I think this is a bug.


My system:

Intel Pentium II, 512 MB RAM
NVIdia Riva TNT2 M64 with 32 MB
Kernel 2.4.4 and 2.4.7
SuSE Linux 7.2
VESA Framebuffer 


Greetings

Michael





