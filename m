Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264762AbSKEKJy>; Tue, 5 Nov 2002 05:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSKEKJy>; Tue, 5 Nov 2002 05:09:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50694 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264762AbSKEKJx>; Tue, 5 Nov 2002 05:09:53 -0500
Date: Tue, 5 Nov 2002 10:16:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
Message-ID: <20021105101626.A20224@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021105090256.A17931@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211050414410.27141-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211050414410.27141-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Tue, Nov 05, 2002 at 04:20:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:20:00AM -0500, Zwane Mwaikambo wrote:
> I'm runnning 115200 :P It looks like a race however because i don't always 
> trigger it, but when i do the trace is always the same. However i'm not 
> going to make you run circles for my potentially dodgy code.

The figures are actually rather horrifing.  There are a couple of
messages I have in my boot log which are rather long - 137 chars
and 79 chars.

Even at 115200 baud is one character every 87us.  This gives:

137 characters: 12ms
79 characters: 7ms

At these types of figures, x86 will drop 1000Hz interrupts like
crazy when writing console messages via the serial port (because
interrupts are turned off.)

With these figures, the longest message we can write at 115200
baud and not drop any timer ticks is 11 characters.  Not many
kernel messages are less than 12 characters.

Now I'll go back and look at your original email... it was for a
slightly different problem. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

