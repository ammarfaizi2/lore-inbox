Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264828AbSKEI4Y>; Tue, 5 Nov 2002 03:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264829AbSKEI4Y>; Tue, 5 Nov 2002 03:56:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51205 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264828AbSKEI4X>; Tue, 5 Nov 2002 03:56:23 -0500
Date: Tue, 5 Nov 2002 09:02:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
Message-ID: <20021105090256.A17931@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Mon, Nov 04, 2002 at 11:27:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 11:27:28PM -0500, Zwane Mwaikambo wrote:
> The only modifications to this code are a slightly hacked up nmi watchdog 
> timer.

Well, Andi Kleen reported that serial_in appears in his boot time
profile after a boot.

Depending on the baud rate used, serial console printk spends time
spinning waiting for the serial port to send characters.  The slower
the baud rate, obviously the longer it spins.

Andi tried to suggest ways to make serial console asynchronous so we
didn't have to spin, but any solution in that direction means that we:

a) have to rely on interrupts running
b) have to buffer the data somewhere, which may possibly fill up and
   then what do we do with the printk message

Bear in mind that dropping random printk messages because we've filled
a buffer isn't acceptable.  Also note that the behaviour in this area
hasn't changed since 2.4 times.

Obviously, the way to reduce the time spent writing console messages to
the serial port is to increase the baud rate. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

