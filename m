Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279863AbRJ3Efv>; Mon, 29 Oct 2001 23:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279864AbRJ3Efk>; Mon, 29 Oct 2001 23:35:40 -0500
Received: from host213-123-35-65.dialup.lineone.co.uk ([213.123.35.65]:260
	"EHLO hoffman.vilain.net") by vger.kernel.org with ESMTP
	id <S279863AbRJ3Efa>; Mon, 29 Oct 2001 23:35:30 -0500
Date: Tue, 30 Oct 2001 04:36:02 +0000
From: Sam Vilain <sam@vilain.net>
To: linux-kernel@vger.kernel.org
Subject: eepro100 quirk with APM suspend on Dell laptops
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15yQd9-0005Rm-00@hoffman.vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

With the earlier discussion about the eepro100 vs the e100, and with
hotplug PCI going into the -ac series kernel, I think it's topical I
discuss an APM related quirk.

If you buy a Dell Inspiron with the inbuilt ethernet option, you get a PCI
eepro100.  If you suspend and resume, however, the card seems to be in a
funny state that an rmmod/modprobe won't fix.

I worked around the problem, by adding to the APM config this pre-suspend
action:

  ifdown eth0
  rmmod eepro100

And to the resume action:

  setpci -s8:4 4=17 5=1 c=8 d=20 11=f0 12=ff 13=fb \
               14=c1 15=dc 1a=e0 1b=fb 33=fc 3c=b
  ifup eth0

The setpci command was derived by comparing the contents of the PCI
configuration area for that device before and after a suspend, and
updating only the areas that changed.

Is this a job for `PCI hotplug', a eepro100 driver bug, or something else?

Sam.
