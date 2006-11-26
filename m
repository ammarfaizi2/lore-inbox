Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967249AbWKZDJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967249AbWKZDJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 22:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967250AbWKZDJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 22:09:18 -0500
Received: from free.hands.com ([83.142.228.128]:36578 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S967249AbWKZDJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 22:09:17 -0500
Date: Sun, 26 Nov 2006 03:09:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>,
       kernel-discuss@handhelds.org
Subject: Re: tty line discipline driver advice sought, to do a 1-byte header and 2-byte CRC checksum on GSM data
Message-ID: <20061126030901.GB5207@lkcl.net>
References: <20061125040614.GI16214@lkcl.net> <20061125230826.22d69a35@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125230826.22d69a35@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 11:08:26PM +0000, Alan wrote:
> > userspace, which would be a hell of a lot easier, but would make
> > applications a pain, because they would need to use a library instead of
> > just opening /dev/ttySN just like any other phone app, to transfer AT
> > commands.
> 
> Like gnokii for example ?
> 
> You can do both - use a pty/tty pair to front the daemon

 heya alan,

 thanks for responding.

 what i was hoping was, like the motorola e680/a780 'mux_cli' driver,
 which is an abortion-and-a-half, to be able to run gnokii or anything
 like it _without_ having binary data in the /dev/ttySN datastream.

 the way that harald plans to do this is to have a userspace daemon which
 handles the actual serial data, and then hands it _back_ to kernelspace
 (via ioctls?) for it to hand out to the relevant _dummy_ serial device.
 one of these devices is what gnokii (or any other program) listens on, to
 handle phone calls (ATH, ATA, ATDTNNNNN etc.).  another is what you would
 start pppd on - even at the same time as making a call, if you had UTMS
 (i think that's right...) but you get the idea.

 both harald's plan - and motorola's abortional 'mux_cli' driver -
 achieve this.  in motorola's case, it's SIXTEEN separate dummy serial
 devices.

 also, trolltech have already implemented the same thing, entirely in
 userspace, and you connect to their daemon on TCP sockets on various
 different ports, to get the different data (battery life, signal
 strength, send/receive SMS etc.)

 so there are many approaches.  motorola went entirely kernelspace and
 the driver is a fxxxxxg mess - 6,000 lines of unmaintainable shit.
 trolltech (and, independently, the guys who did the h63xx port) went
 entirely user-space.  harald, for the openmoko neo1973 has gone for a
 mixed approach, with a 'helper' daemon which does the hard work in a
 sensible place - USERSPACE are you LISTENING motorola? :)

 i _could_ wait for harald's work to make its way out of FIC, which
 should be some time in january.  i'd like to roughly know what i'm
 doing before then :)

 not least because harald's code certainly won't have support for e.g. the
 htc universal's _awful_ audio management, part of which is done over
 the serial link to the UTMS radio module!  (there is device-switching
 to the four separate speakers (!), volume control, bluetooth enabling
 etc. it's horrendous)

 that would need to have its own 'audio management' demuxed dummy serial
 'port'.

 plus, i don't believe that the eriksson k700 gsm radio module supports
 TS07.10 (which is what is used on the Neo1973, the Greenphone, the
 Motorola linux phones and many others).  it's an entirely different - and proprietary - multiplexing protocol.

 so i would have to do quite a bit of adaptation.

 alternatively, someone else can buy one of these damn good - expensive -
 pda/phones with gps built-in - and do it instead.

	 http://wiki.xda-developers.com/index.php?pagename=Ipaq6915

 (i've about 90% finished the device-driver support: suspend/resume is
 the only significant big task).

 l.

 p.s. if the linux kernel design could be compiled up (optionally, of
 course, not as a total replacement redesign, of course, to avoid the
 polarised bun-fights about which way is better) with options based
 around the same principles that Gnu/Hurd was - message-passing and
 used IPC and an RPC compiler to help turn IDL files into drivers -
 then this would be an entirely moot point.
 
 there would _be_ no awful/awkward kernelspace/userspace decisions like
 this to make, as it would be possible to write a userspace daemon that
 then 'republished' to the kernel the de-multiplexed serial ports.

 but, i am sure you would agree: that's another looong story :)

-- 
--
lkcl.net - mad free software computer person, visionary and poet.
--
