Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSGNRej>; Sun, 14 Jul 2002 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSGNRei>; Sun, 14 Jul 2002 13:34:38 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:47353 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S316961AbSGNReh>;
	Sun, 14 Jul 2002 13:34:37 -0400
Date: Sun, 14 Jul 2002 19:37:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714173729.GA15065@win.tue.nl>
References: <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714121731.GA15055@win.tue.nl> <20020714143702.A26584@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714143702.A26584@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:37:02PM +0200, Vojtech Pavlik wrote:

>>>> atkbd.c: Sent: f5
>>>> atkbd.c: Received fe

>>> Ok. So this is the cause. The driver gets a '0xfe' response, which means
>>> "error, command not supported, or device not present'.

>> In principle nothing is wrong when one gets a 0xfe.
>> The request is just: please say that again.

> 0xfe
>   Resend. Keyboard will send this if it didn't receive the last command
> correctly.
> 
> Unfortunately, 0xfe also happens when you send a command to a keyboard
> that's not plugged, or when the keyboard doesn't understand the command.
> Resending in those cases (which are the most common) would cause an
> infinite loop ...

Not so pessimistic. The first resend may be needed because the keyboard
does not stabilize so quickly after power on. 
You wait 25 ms and try again. Wait 500 ms and try again. Give up.

But if this is really the first command sent to the keyboard, then
I think 0xf5 is uncommon.

One usually sees a sequence like:
Send 0xaa to port 64. Wait for the 0x55 ack.
Do things to enable A20, IRQ1, set scancode translation.
Send 0xff to port 60. Wait for the 0xfa ack. Wait for the 0xaa good status.

When 0xf5 fails, one might consider trying a more standard sequence.

Andries
