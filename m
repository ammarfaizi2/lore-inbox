Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCWGBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 01:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUCWGBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 01:01:06 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:56994 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262052AbUCWGAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 01:00:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
Date: Tue, 23 Mar 2004 01:00:37 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl> <200403222332.31308.dtor_core@ameritech.net> <20040323054026.GA27081@vitelus.com>
In-Reply-To: <20040323054026.GA27081@vitelus.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403230100.37255.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 March 2004 12:40 am, Aaron Lehmann wrote:
> On Mon, Mar 22, 2004 at 11:32:29PM -0500, Dmitry Torokhov wrote:
> > Because it is not implementation, it is hardware limitation. Synaptics native
> > protocol uses 6 bytes, standard PS/2 3 or 4. The protocols are not compatible
> > at all so unless the PC has an active multiplexing controller (which provides
> > up to 4 completely independent AUX ports) all devices have to speak the same
> > protocol. 
> 
> This only matters if you plug in a PS/2 mouse. If you have a USB
> mouse, that's another issue entirely. Ideally XFree86 should read
> /dev/input/mice and not have to worry about the specifics of the
> device.

You can do that if you do not care about extended features, just use
/dev/input/mice and all should be fine (well, for tapping to work you will
have to pass psmouse.proto as in-kernel synaptics->PS/2 protocol emulation
does not process taps).

> When you use the synaptics driver, XFree86 won't accept input 
> from USB mice. It may be possible to work around this by using
> multiple Input sections, 

That is correct. You should use one input section for devices speaking
PS/2 protocol and other input sections for devices using other protocols.

>                           but that seems especially awkward when 
> Synaptics events are presented in both /dev/input/mice and /dev/psaux.

Well, that is not a surprise as /dev/input/mice is a synonim for /dev/psaux
in 2.6. If you have your XFree reading from both devices you will get
duplicate events no matter what hardware it is (USB, PS/2, Synaptics).
Now, default XFree86 Synaptics setup has "auto-dev" protocol and "/dev/psaux"
device, but with "auto-dev" protocol the driver actually scans
/dev/input/eventX devices for Synaptics and /dev/psaux is only used as a
fall-back so the same setup works in 2.4.

> 
> I recently switched from the synaptics driver reading /dev/psaux to
> the generic ImPS/2 driver reading /dev/input/mice. (Note that the only
> reason I ever installed the synaptics driver was that a kernel upgrade
> forced me to.) It performs bearably, but I personally wish that I
> could click by tapping and use the odd scrolling button as button3
> (this only works when I hit the button exactly in the middle). 

Try psmouse.proto=bare or psmouse.proto=imps

> At lease I can plug in external mice without hassle.

That means that your hardware does not have the problem I described in my
other mail.

-- 
Dmitry
