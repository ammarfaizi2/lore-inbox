Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVATQGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVATQGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:04:16 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:12934
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262179AbVATQCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:02:24 -0500
Date: Thu, 20 Jan 2005 11:01:51 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Jean Delvare <khali@linux-fr.org>
cc: sensors@Stimpy.netroedge.com, lkml <linux-kernel@vger.kernel.org>,
       Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-Reply-To: <CPrisGfK.1106219326.9605690.khali@localhost>
Message-ID: <Pine.LNX.4.61.0501201042300.5315@localhost.localdomain>
References: <CPrisGfK.1106219326.9605690.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Jean Delvare wrote:

> 
> Hi Nicolas,
> 
> > > I would also appreciate a dump of the chip (isadump 0x295 0x296 unless
> > > it lives at some uncommon address) to confirm the guess.
> >
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: 11 10 80 00 37 ff 00 37 ff 07 13 5b 00 51 40 ff
> > 10: fe fe ff 71 d7 fe 7f fe 00 00 ff ff ff ff ff ff
> 
> Interesting. Your chip does seem to be configured (i.e. pwm polarity is
> high), so whatever your problem is, it is probably different from what
> Simone experienced.
> 
> Your configuration is as follow:
> * PWM outputs active high.
> * PWM 2 and 3 in on/off mode, set to on.
> * PWM 1 in "smart guardian" mode, set to automatic PWM depending on
> temp3.

Sensible.

> I would like to know how temperature channels are used by your
> motherboard, and how fans are used as well. Which temperature and fan
> channels correspond to your CPU? What other temperature sensors and fans
> are present?

It looks like only temp3 is used for the CPU temperature, fan1 is the 
CPU fan and fan2 the case fan.

> The values dumped here make me believe that the PWM outputs were
> configured by the BIOS. Now maybe not the correct way, at least for you.

I experimented with isaset tweaking individual bits in register 0x14 
(blindly I confess, haven't read the datasheet) and flipping bit 3 from 
0 to 1 (writing 0xdf) apparently reverses the behavior, i.e. the CPU fan 
speed now increases with the CPU temperature.

> I would like you to give a try to a recent version of the it87 driver (as
> found in 2.6.11-rc1-bk7 or 2.6.11-rc1-mm2).

Will try to do soon.  In the mean time I'm willing to try out things 
with isaset if you can suggest basic tests (easier than upgrading kernel 
for the time being).


Nicolas
