Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLYFW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 00:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTLYFW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 00:22:56 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:5019 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262805AbTLYFWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 00:22:54 -0500
Subject: Re: 2.6.0 "Losing too many ticks!"
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: wli@holomorphy.com, admin@nectarine.info
Content-Type: text/plain
Organization: 
Message-Id: <1072321519.1742.328.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Dec 2003 22:05:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
> On Wed, Dec 24, 2003 at 07:49:06PM +0100, Giacomo Di Ciocco wrote:

>> today i found a problem when upgrading the kernel of this box from
>> 2.2.20 to 2.6.0, i tried to enable/disable ACPI support in the bios
>> and in the kernel but nothing was resolved. [...]
>> Dec 24 16:36:31 xmas kernel: Losing too many ticks!
>> Dec 24 16:36:31 xmas kernel: TSC cannot be used as a timesource. (Are you
>> running with SpeedStep?)
>> Dec 24 16:36:31 xmas kernel: Falling back to a sane timesource.
>> Contact me for more informations. (or tell me to post it here)
>
> This is not particularly harmful. It just means the kernel
> has detected some variation in the processor's clock speed
> and is using a time source that doesn't change speed along
> with the processor's clock speed.

I sure wouldn't bet on that. More likely, he's simply
losing ticks. He has a Duron processor, which is
highly unlikely to be hooked up to some crummy
speed-changing hardware.

I had a 1 GHz Pentium III box with the same problem.
Linux would give up on the perfectly-correct 1 GHz
clock source in favor of trying, and failing, to
count 1 kHz ticks from the crummy old PIT hardware.
Time loss got so bad that NTP would simply give up.
IDE activity may have had something to do with it.

In his case, maybe ACPI polls something while
interrupts are off.


