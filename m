Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRKXX3g>; Sat, 24 Nov 2001 18:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKXX30>; Sat, 24 Nov 2001 18:29:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39434 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280495AbRKXX3R>; Sat, 24 Nov 2001 18:29:17 -0500
Message-ID: <3C002D41.9030708@zytor.com>
Date: Sat, 24 Nov 2001 15:29:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Stephen Satchell <satch@concentric.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:

> 
> It is the responsibility of the power monitor to detect a power-fail 
> event and tell the drive(s) that a power-fail event is occurring.  If 
> power goes out of specification before the drive completes a commanded 
> write, what do you expect the poor drive to do?  ANY glitch in the write 
> current will corrupt the current block no matter what -- the final CRC 
> isn't recorded.  Most drives do have a panic-stop mode when they detect 
> voltage going out of range so as to minimize the damage caused by an 
> out-of-specification power-down event, and more importantly use the 
> energy in the spinning platter to get the heads moved to a safe place 
> before the drive completely spins down.  The panic-stop mode is EXACTLY 
> like a Linux OOPS -- it's a catastrophic event that SHOULD NOT OCCUR.
> 


There is no "power monitor" in a PC system (at least not that is visible 
to the drive) -- if the drive needs it, it has to provide it itself.

It's definitely the responsibility of the drive to recover gracefully 
from such an event, which means that it writes anything that it has 
committed to the host to write; anything it hasn't gotten committed to 
write (but has received) can be written or not written, but must not 
cause a failure of the drive.

A drive is a PERSISTENT storage device, and as such has responsibilities 
the other devices don't.

Anything else is brainless rationalization.

	-hpa

