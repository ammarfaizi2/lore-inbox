Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUG3VDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUG3VDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUG3VDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:03:40 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:26161 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267827AbUG3VDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:03:33 -0400
Message-ID: <b71082d804073014037bc5dd5a@mail.gmail.com>
Date: Fri, 30 Jul 2004 23:03:29 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: gigabit trouble
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040730205412.A15669@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b71082d8040729094537e59a11@mail.gmail.com> <20040729210401.A32456@electric-eye.fr.zoreil.com> <b71082d80407291541f9d6f93@mail.gmail.com> <b71082d804073008157cf1d6c0@mail.gmail.com> <20040730205412.A15669@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are aware that this is a celeron at 400 mhz, and not whatever 400
is or possibly isn't in that annoying new naming scheme? (Just
checking...)

Both systems are not overclocked, so are stable in that respect. The
nonbooting thing was a loose ground wire touching my hard drive
jumpers, making it think it was a slave. I'm surprised winxp managed
to do anything at all. I've used both these systems for ages, never
had any real trouble except for the strange pci slot/irq problems in
my new computer, but that was mostly a work-or-not thing - although it
also increases pci latency. I'm still not sure whether it's a card
that's in there, a card that was in there, (I replaced my sound card,
and can suddently get a much lower midi-to-wave playing latency - but
the sound card has been known to click and pop randomly over several
reconfigurations the last few days) or just a screwy motherboard. I
should hope it's not the last, it's a brand board.

Anyhow, on transmit from the celeron box, under extreme benchy
circumstrances, I've seen it around 16Kints/s on transmit and 13k on
receive. But under everyday nfs/samba, 6400 is about the best it does
either way.

The maximum amount of interrupts/s I've seen so far 22302 (including
the 1000 in the kernel timer, 'course). Nothing much else changes,
except the context switches raising from an idle 10~30 to 1000~1500
to, sometimes 30000. Actually, using netio seems to busy the system
completely:

# top -d 0.5 | grep Cpu\(
Cpu(s):  8.8% us, 36.8% sy,  0.0% ni,  1.5% id,  0.0% wa, 13.2% hi, 39.7% si
Cpu(s):  7.5% us, 38.8% sy,  0.0% ni,  0.0% id,  0.0% wa, 14.9% hi, 38.8% si
Cpu(s):  5.7% us, 41.4% sy,  0.0% ni,  0.0% id,  0.0% wa, 14.9% hi, 37.9% si
Cpu(s):  5.0% us, 44.0% sy,  0.0% ni,  0.0% id,  0.0% wa, 14.5% hi, 36.5% si
Cpu(s):  4.4% us, 50.5% sy,  0.0% ni,  1.1% id,  0.0% wa, 12.1% hi, 31.9% si
Cpu(s):  3.8% us, 50.9% sy,  0.0% ni,  0.0% id,  0.0% wa, 17.0% hi, 28.3% si

But a to-winxp smb file transfer, hangin around 7, 8MB/s, doesn't:
Cpu(s):  3.8% us, 50.0% sy,  0.0% ni, 17.9% id,  0.0% wa,  7.5% hi, 20.8% si
Cpu(s):  5.0% us, 43.0% sy,  0.0% ni, 27.0% id,  0.0% wa,  7.0% hi, 18.0% si
Cpu(s):  4.8% us, 40.4% sy,  0.0% ni, 29.8% id,  0.0% wa,  5.8% hi, 19.2% si
Cpu(s):  5.1% us, 43.9% sy,  0.0% ni, 26.5% id,  0.0% wa,  5.1% hi, 19.4% si
Cpu(s):  5.3% us, 42.5% sy,  0.0% ni, 26.5% id,  0.0% wa,  6.2% hi, 19.5% si
Cpu(s):  5.9% us, 43.1% sy,  0.0% ni, 25.5% id,  1.0% wa,  5.9% hi, 18.6% si
Cpu(s):  4.6% us, 41.7% sy,  0.0% ni, 25.9% id,  0.0% wa,  5.6% hi, 22.2% si
Cpu(s):  6.2% us, 44.6% sy,  0.0% ni, 23.2% id,  0.0% wa,  5.4% hi, 20.5% si
Cpu(s):  4.2% us, 34.7% sy,  0.0% ni, 38.9% id,  0.0% wa,  5.3% hi, 16.8% si

It's not too consistent all over either; windows netio transmits
slowly when packet sizes are >1k (the mtu?), as low as 5MB/s, while
the receive speed for the same packet size goes at ~22MB


Ooh, finally, a proper kernel pan --er, bug, it says. On my old
computer this time.
I know, incidentally, that the memory works; I recently did a three-hour memtest
on this computer. Picture here:
http://www.scarfboy.com/other/panic-30jul.gif

This may be due to fiddling with said wmem, etc values, I set some of them
considerably larger. I did get a few percent apparent speed increase,
incidentally, though that may have been wishful thinking.

I guess I should try >= 2.6.8-rc2-mm1 next?

--Bart Alewijnse
