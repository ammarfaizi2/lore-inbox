Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbTBNVNP>; Fri, 14 Feb 2003 16:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268046AbTBNVNH>; Fri, 14 Feb 2003 16:13:07 -0500
Received: from [81.2.122.30] ([81.2.122.30]:13064 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268143AbTBNVMk>;
	Fri, 14 Feb 2003 16:12:40 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302142123.h1ELNShW004938@darkstar.example.net>
Subject: Re: RFC/CFT 1/1: SIGWINCH - behaviour change
To: pollard@admin.navo.hpc.mil (Jesse Pollard)
Date: Fri, 14 Feb 2003 21:23:28 +0000 (GMT)
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200302141503.53207.pollard@admin.navo.hpc.mil> from "Jesse Pollard" at Feb 14, 2003 03:03:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I keep on tripping over an annoying "feature" of our tty layer - if
> > > you have a session running with multiple jobs (eg, three ssh sessions)
> > > and you resize the window, SIGWINCH is only sent to the foreground
> > > process, be it the shell, or one of the ssh sessions.
> >
> > This reminds me of a problem I had, which I'd forgotten about, maybe
> > it's related:
> >
> > I was using a 7N1, (that's not a typo, it really was 7N1), 9600 bps
> > serial terminal, and from the shell prompt I connected to a remote
> > machine using 8N1.  I logged in successfully, but the shell didn't
> > work, yet setting the local serial terminal to 8N1 made it work (!).
> > After logging out from the remote machine, I had to set the serial
> > terminal back to 7N1 to use the local machine.
> >
> > Can anybody else reproduce this?  My serial terminal is currently out
> > of service, (needs some wires soldered on a DB9 connector :-) ).
> 
> I believe this is "normal"  :-)
> 
> The remote machine was actually handling 8N0.. so 7N1 was treated
> as 8P0 OR 8N0... The shell didn't work because it was possible to have
> "mark" parity, and the parity errors would show up preventing the bytes
> from being used (mark parity/or parity errors always showed up in the
> most significant bit of the character). Everything looks fine, but wouldn't 
> work.
> 
> Setting the 8N1 forces the parity bit to zero, but including 8 data bits
> and one stop bit. 7N1 is the same as 8N0, with the parity showing up as
> the 8th bit. The remote (if missing a stop bit) would complete by adding
> a "parity" bit...

Hmmm, I understand how 7N1 looks the same as 8P0 on the wire, but
surely the remote machine should never get to see that, and the local
shell works fine.

 --------         ----------            --------------
|Terminal|==7N1==|My machine|--TCP/IP--|Remote machine|
 --------         ----------            --------------

If I send an A, although my terminal is sending:

..111111111111101000001111111...
               ^       ^
             Start    Stop

my machine will just send a 65 over the TCP/IP connection.

John.
