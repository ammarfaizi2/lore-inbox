Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132188AbRCVUe1>; Thu, 22 Mar 2001 15:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132185AbRCVUeI>; Thu, 22 Mar 2001 15:34:08 -0500
Received: from netel-gw.online.no ([193.215.46.129]:7181 "EHLO
	InterJet.networkgroup.no") by vger.kernel.org with ESMTP
	id <S132181AbRCVUd5>; Thu, 22 Mar 2001 15:33:57 -0500
Message-ID: <3ABA6167.309E6DB2@powertech.no>
Date: Thu, 22 Mar 2001 21:32:39 +0100
From: Geir Thomassen <geirt@powertech.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no> <20010322140852.A4110@think>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 
> On Thu, Mar 22, 2001 at 07:21:28PM +0100, Geir Thomassen wrote:
> > My program controls a device (a programmer for microcontrollers) via the
> > serial port. The program sits in a tight loop, writing a few (typical 6)
> > bytes to the port, and waits for a few (typ. two) bytes to be returned from
> > the programmer.
> 
> Check out the man page for the "low_latency" configuration parameter
> in the setserial man page.  This will cause the serial driver to burn
> a small amount of additional CPU overhead when processing characters,
> but it will lower the time between when characters arrive at the
> RS-232 port and when they are made available to the user program.  The
> preferable solution is to use a intelligent windowing protocol that
> isn't heavily latency dependent (all modern protocols, such as kermit,
> zmodem, tcp/ip, etc. do this).  But if you can't, using setserial to
> set the "low_latency" flag will allow you to work around a dumb
> communications protocol.
> 

I have tried this on both a stock Redhat 7.0 kernel and on 2.2.19pre5 with
your serial-5.05 driver, and I could not measure any difference with and
without the "low_latency" parameter to setserial ....

#setserial -a /dev/ttyS1
/dev/ttyS1, Line 1, UART: 16550A, Port: 0x02f8, IRQ: 3
	Baud_base: 115200, close_delay: 50, divisor: 0
	closing_wait: 3000
	Flags: spd_normal skip_test low_latency


The serial port chip is 16550A, which has a built in fifo. Can this be
the source of my problems ?

Geir
