Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbRFUM5X>; Thu, 21 Jun 2001 08:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbRFUM5M>; Thu, 21 Jun 2001 08:57:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41090 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264944AbRFUM5E> convert rfc822-to-8bit; Thu, 21 Jun 2001 08:57:04 -0400
Date: Thu, 21 Jun 2001 08:56:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randal, Phil" <prandal@herefordshire.gov.uk>
cc: linux-kernel@vger.kernel.org
Subject: RE: temperature standard - global config option?
In-Reply-To: <AFE36742FF57D411862500508BDE8DD00199504B@mail.herefordshire.gov.uk>
Message-ID: <Pine.LNX.3.95.1010621084450.28391A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Randal, Phil wrote:

> Jonathan Morton wrote:
> 
> > I should instead write 59 ±2°C, since that is the most precision
> > I can possibly know it to.  With some advanced measuring techniques
> > it *may* be acceptable to write 59.43 ±2°C *at most*, and then only
> > if you really know why you need the extra information.
> 
> It's easy to conceive of a device which, for whatever reason, gives
> an "absolute" reading accurate ±2°C, but which tracks temperature
> changes somewhat more accurately.  And hence a small difference
> between successive readings still has significance.  A real-world
> example is a mercury thermometer in which the glass has been
> physically shifted relative to an adjacent scale.  So 18°C reads as
> 20°C, etc.
> 
> Cheers,
> 
> Phil
> 
> ---------------------------------------------
> Phil Randal
> Network Engineer
> Herefordshire Council
> Hereford, UK
> -


The difference between accuracy and resolution is often
not understood. Without insulting everybody with grade-school
math, suffice to say that it is possible, and even useful for
a 8-bit (0 to 255) ADC software to display a number such as
1.23456. It is also possible for the very next value displayed
to be 1.23457, i.e., no missing output codes. Note, 123457
requires 17 bits to be displayed with no missing codes
(intervals).

This is done by sampling the ADC at a fixed time interval
and averaging, actually using an IIR filter. With a very
simple average, i.e. value = (value + new_sample) / 2, you
end up with a bias slightly less than 2, so this is not
useful in precision work, but the result improves the resolution
by sqrt(2) = 1.41. Working versions of sampling + IIR filters
can improve the resolution by any amount you want to wait for.

Accuracy involves comparison against some standard. ADCs are
not generally accurate. However they can be calibrated and
even continuously calibrated so that the result is almost
as accurate as the standard.

The heat sensors in newer Ix86 Machines are not accurate nor
are they meant to be. It is a waste of CPU resources to precisely
sample and filter these sensors. However, very simple integer
math will give you a decimal point. If you don't use a decimal
point, then you are throwing away potentially useful information.

If the heat-sink is getting hotter and hotter and hotter... etc.,
do you want to know it right away or have to wait for the temperature
to get to another even (integer) interval? The answer is obvious.
Don't throw away any information, even though the displayed result
implies some unobtainable accuracy.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


