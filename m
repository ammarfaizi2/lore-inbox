Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318312AbSG3Pue>; Tue, 30 Jul 2002 11:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSG3Pud>; Tue, 30 Jul 2002 11:50:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318312AbSG3Puc>; Tue, 30 Jul 2002 11:50:32 -0400
Date: Tue, 30 Jul 2002 16:53:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Matthew Wilcox <willy@debian.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020730165351.C7677@flint.arm.linux.org.uk>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk> <008801c237d6$8b7dc640$294b82ce@connecttech.com> <20020730161940.P1441@parcelfarce.linux.theplanet.co.uk> <00f801c237df$d09d4e40$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00f801c237df$d09d4e40$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, Jul 30, 2002 at 11:43:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:43:13AM -0400, Stuart MacDonald wrote:
> No, I was wondering if leaving the USB serial major 18[89] alone would
> be a better idea. Since posting, I've been thinking that the usb
> serial driver presents the same interface to the tty layer as any
> other serial device so I guess it's not a bad idea.

To be able to suck in USB (and some of the other drivers), two changes
need to be made to the core:

1. the change_speed method needs to be handled differently; we currently
   assume a UART-style implementation here.  We need to change this
   around before 2.6 anyway for ports which don't support all the
   termios settings (SuSv3 requires that any unimplemented features
   retain their original values, so for example if we don't have RTS
   and CTS lines on a particular implementation, CRTSCTS should be
   initially off and not turn on-able.)

2. USB devices want "packets" of data to write rather than the ring-
   buffer we currently use for UARTs.

(time to start ebaying for USB serial devices...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

