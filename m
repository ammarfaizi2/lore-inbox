Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268499AbTBNVlQ>; Fri, 14 Feb 2003 16:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTBNVkr>; Fri, 14 Feb 2003 16:40:47 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:60310 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267467AbTBNUyY> convert rfc822-to-8bit; Fri, 14 Feb 2003 15:54:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: John Bradford <john@grabjohn.com>, rmk@arm.linux.org.uk (Russell King)
Subject: Re: RFC/CFT 1/1: SIGWINCH - behaviour change
Date: Fri, 14 Feb 2003 15:03:53 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200302142035.h1EKZLXc001121@darkstar.example.net>
In-Reply-To: <200302142035.h1EKZLXc001121@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302141503.53207.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 February 2003 02:35 pm, John Bradford wrote:
> > I keep on tripping over an annoying "feature" of our tty layer - if
> > you have a session running with multiple jobs (eg, three ssh sessions)
> > and you resize the window, SIGWINCH is only sent to the foreground
> > process, be it the shell, or one of the ssh sessions.
>
> This reminds me of a problem I had, which I'd forgotten about, maybe
> it's related:
>
> I was using a 7N1, (that's not a typo, it really was 7N1), 9600 bps
> serial terminal, and from the shell prompt I connected to a remote
> machine using 8N1.  I logged in successfully, but the shell didn't
> work, yet setting the local serial terminal to 8N1 made it work (!).
> After logging out from the remote machine, I had to set the serial
> terminal back to 7N1 to use the local machine.
>
> Can anybody else reproduce this?  My serial terminal is currently out
> of service, (needs some wires soldered on a DB9 connector :-) ).

I believe this is "normal"  :-)

The remote machine was actually handling 8N0.. so 7N1 was treated
as 8P0 OR 8N0... The shell didn't work because it was possible to have
"mark" parity, and the parity errors would show up preventing the bytes
from being used (mark parity/or parity errors always showed up in the
most significant bit of the character). Everything looks fine, but wouldn't 
work.

Setting the 8N1 forces the parity bit to zero, but including 8 data bits
and one stop bit. 7N1 is the same as 8N0, with the parity showing up as
the 8th bit. The remote (if missing a stop bit) would complete by adding
a "parity" bit...

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
