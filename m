Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSGNV1q>; Sun, 14 Jul 2002 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGNV1p>; Sun, 14 Jul 2002 17:27:45 -0400
Received: from emory.viawest.net ([216.87.64.6]:12280 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S317148AbSGNV1o>;
	Sun, 14 Jul 2002 17:27:44 -0400
Date: Sun, 14 Jul 2002 14:30:33 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714213033.GA1030@wizard.com>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714140153.A26469@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 2:27pm  up 3 min,  2 users,  load average: 0.17, 0.20, 0.09
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:01:53PM +0200, Vojtech Pavlik wrote:
> > 
> >         Just did. dmesg follows:
> > 
> > mice: PS/2 mouse device common for all mice
> > atkbd.c: Sent: f5
> > atkbd.c: Received fe
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > 
> 
> Ok. So this is the cause. The driver gets a '0xfe' response, which means
> "error, command not supported, or device not present'.
> 
> A keyboard must support the 0xf5 command ('reset').
> 
> So, the error response might be coming either from the mouse, or the
> controller, and somehow gets passed to the keyboard (they unfortunately
> share the same registers), or the response somes from the mouse driver
> first trying to probe for a mouse on the port.
> 
> So, please #define I8042_DEBUG_IO in drivers/input/serio/i8042.h as
> well, and try again. Then we'll know more.
> 

        Just gave that a go.. no change in the dmesg output. Nothing written 
out to stdout or anything via syslogd/klogd. See above for that output.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

