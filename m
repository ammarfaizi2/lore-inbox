Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSGOC5Q>; Sun, 14 Jul 2002 22:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSGOC5P>; Sun, 14 Jul 2002 22:57:15 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:4293 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317286AbSGOC5N>;
	Sun, 14 Jul 2002 22:57:13 -0400
Date: Mon, 15 Jul 2002 05:00:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020715050000.A32268@ucw.cz>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714213033.GA1030@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714213033.GA1030@wizard.com>; from tyketto@wizard.com on Sun, Jul 14, 2002 at 02:30:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:30:33PM -0700, A Guy Called Tyketto wrote:
> On Sun, Jul 14, 2002 at 02:01:53PM +0200, Vojtech Pavlik wrote:
> > > 
> > >         Just did. dmesg follows:
> > > 
> > > mice: PS/2 mouse device common for all mice
> > > atkbd.c: Sent: f5
> > > atkbd.c: Received fe
> > > serio: i8042 KBD port at 0x60,0x64 irq 1
> > > input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> > > serio: i8042 AUX port at 0x60,0x64 irq 12
> > > NET4: Linux TCP/IP 1.0 for NET4.0
> > > 
> > 
> > Ok. So this is the cause. The driver gets a '0xfe' response, which means
> > "error, command not supported, or device not present'.
> > 
> > A keyboard must support the 0xf5 command ('reset').
> > 
> > So, the error response might be coming either from the mouse, or the
> > controller, and somehow gets passed to the keyboard (they unfortunately
> > share the same registers), or the response somes from the mouse driver
> > first trying to probe for a mouse on the port.
> > 
> > So, please #define I8042_DEBUG_IO in drivers/input/serio/i8042.h as
> > well, and try again. Then we'll know more.
> > 
> 
>         Just gave that a go.. no change in the dmesg output. Nothing written 
> out to stdout or anything via syslogd/klogd. See above for that output.

Are you sure you didn't leave the #undef in that file?

-- 
Vojtech Pavlik
SuSE Labs
