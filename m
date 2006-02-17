Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWBQXMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWBQXMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWBQXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:12:45 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:56765
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750972AbWBQXMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:12:44 -0500
Message-ID: <43F65824.8050204@microgate.com>
Date: Fri, 17 Feb 2006 17:11:32 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
References: <20060217222529.14155.qmail@science.horizon.com> <20060217223938.GA24170@flint.arm.linux.org.uk>
In-Reply-To: <20060217223938.GA24170@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Feb 17, 2006 at 05:25:29PM -0500, linux@horizon.com wrote:
>>CRTSCTS	CRTSHDX	Handshaking
>>off	off	None.  (Computer might as well send RTS< but ignores CTS)
>>on	off	Full-duplex RTS/CTS
>>off	on	RS-485.  CTS ignored, RTS enables transmitter.
>>on	on	RS-232 half-duplex.  RTS is request, CTS is grant.
...
> Also, !CRTSCTS is most likely the state used by any existing userspace
> RS485 implementations which would be using TIOCMBIC/TIOCMBIS to
> manipulate the RTS signal, so having RTS manipulated in this state
> would be an undesirable change of behaviour.
> 
> Hence, I'm very much in favour of having the default flow control
> method to preserve in as many ways as possible existing behaviour
> for CRTSCTS.

It is important to maintain the "driver doesn't touch RTS/CTS"
semantics without regard to other (new) control flags.
An application might read the existing termios, and modify only
the bits it is aware of without verifying that new bits are zero.
CFLOWXXX also maintains a free setting for future flow modes, such as:
CFLOWZEN = alter RTS based on /dev/random

--
Paul Fulghum
Microgate Systems, Ltd
