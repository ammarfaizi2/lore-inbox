Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFZK6L>; Wed, 26 Jun 2002 06:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSFZK6K>; Wed, 26 Jun 2002 06:58:10 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:3749 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S316499AbSFZK6J>;
	Wed, 26 Jun 2002 06:58:09 -0400
Message-ID: <3D199E3B.10305@iram.es>
Date: Wed, 26 Jun 2002 12:58:03 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.5) Gecko/20011016
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <Pine.LNX.3.95.1020624153816.15499A-100000@chaos.analogic.com> <3D1871FA.B974E142@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> 
> 
>>This has been running since I first read your mail about 10:00 this
>>morning. The kernel is 2.4.18
>>
> 
> <code snipped, find it on google>
> 
> Using that code, I can reliably trigger the fault on 2.2.17 on a G4 desktop,
> while it doesn't trigger on 2.4.18 on a G4 cPCI blade.


Given the fact that the relevant code has been almost completely rewritten 
for 2.4 (I'm the culprit), this is not surprising.

The rewrite was mostly to make the code more robust in case of missed 
ticks: all PPC are now guaranteed to withstand at least (HZ-1) lost clock 
interrupts before things go awfully wrong (this was very useful when the
frame buffer drivers blocked interrupts for too long during screen 
switching). There are also several other less visible bug fixes: when 
connected to an NTP server, in some cases the timebase frequency appeared 
to vary depending on system load (fixed by a different algorithm to 
compute values to load into the decrementer) and other bogosities.

Now if you are able to trigger a problem with 2.4. I'm extremely interested.


> 
> I saw this a long time back (a year or two) on 2.2 but never really tracked it
> down properly as it wasn't a showstopper and I had other things to do at the
> time.


I have a patch for 2.2, but it is mixed up in a set of huge patches for 
Motorola VME boards (MVME2600 and 2400 series) with a bootloader 
(including an x86 emulator to initialize graphics boards by executing the 
BIOS ROM), VME drivers and other things that you can find at:

	ftp://vlab1.iram.es/pub/linux-2.2

I could extract the timing patches if somebody is interested, but not in 
the next few days (I have patches which apply to more recent versions than 
the ones I put on the FTP area).

	Gabriel.

