Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbRFEKhO>; Tue, 5 Jun 2001 06:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbRFEKhE>; Tue, 5 Jun 2001 06:37:04 -0400
Received: from s7n18.hfx.eastlink.ca ([24.222.7.18]:3468 "EHLO fop.ns.ca")
	by vger.kernel.org with ESMTP id <S262629AbRFEKgx>;
	Tue, 5 Jun 2001 06:36:53 -0400
Date: Tue, 5 Jun 2001 07:36:39 -0300 (ADT)
From: Steve Bromwich <kernel@fop.ns.ca>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.5] Mysterious behaviour of pppd at 56K modem
In-Reply-To: <01060510102500.09957@athlon>
Message-ID: <Pine.LNX.4.10.10106050724140.29115-100000@chizz.foppity.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Andreas Hartmann wrote:

> The speed of the incoming data is always swinging between 5.9kB and 4.4kB. 
> Why? I didn't have this problem with Kernel 2.2.x (with the same 
> pppd-versions).

Well, I'm not seeing the same thing here with 2.4, but I can give you some
general bits and pieces to look at:

* Check ATI6 after disconnect to make sure it's not bit errors (make sure
your comms package doesn't do ATZ on startup or it'll wipe the ATI6 stats)
* Force the mtu to 1500 in your /etc/ppp/options file. Note that this will
stomp on interactive traffic.
* Make sure your modem is well initialised; run minicom or similar, set
the baud rate to 115200, and do ATZ\nAT&F1&W
* Try setting low latency on your serial port, eg, setserial /dev/ttyS0
low_latency

> Neverthless, the overallspeed seems to be equal to kernel 2.2.x (about 
> 5.1kB/s) - but not slower; it even could be faster. But I think, the speed 
> could be much higher, if it wouldn't swing as much.

If you're measuring this with pppstats, bear in mind that if you have a
packet that's half transferred when pppstats does its calculation, that
packet is included in the next second's stats (or so it appears to me).

> I'm using pppd 2.4.0b or 2.4.1. My modem (USR Sportster Message +) is 
> connected with 115200 Baud (56000 tested but doesn't work properly), the 
> connect to my provider is 50,6kB/s.

USR modems don't set the serial interface rate to the connection rate.
They also only use standard transfer speeds such as 300, 2400, 4800, 9600,
19200, 38400, 57600, 115200, and the newer ones support speeds such as
230400 and up. This is based on my experience working with the UK code
back in the mid 90's (pre-3com takeover), though, so it may have changed
since then.

You might also want to confirm packet throughput with another utility (eg,
iptraf) and see what that says. Also try tcpdumping a connection and see
if there's any packets being lost.

Cheers, Steve

