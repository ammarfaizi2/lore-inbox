Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVLKTFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVLKTFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLKTFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:05:35 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:51233 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750794AbVLKTFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:05:35 -0500
Date: Sun, 11 Dec 2005 14:05:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <43975A96.9090503@eclis.ch>
To: linux-kernel@vger.kernel.org
Message-id: <200512111405.30081.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512070108.58466.gene.heskett@verizon.net> <43975A96.9090503@eclis.ch>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 16:56, Jean-Christian de Rivaz wrote:
>Gene Heskett a écrit :
>> And, acpi is on, and ntpd is happy with the new bios.  Hurrah!
>
>Good news!
>
>I wonder if it would be a good idea to add something into the kernel
> or into ntpd to alert the users that ntpd can't run normaly because
> of a too fast drift ? Then a BIOS upgrade could be proposed
> (especially on a nForce2 system). I don't know if it's even
> realistc.
>
>Regards,

I don't know as this is a kernel issue in this case.  So if warning are 
to be output to the logs, then they really should come from ntpd IMO.

Frankly, the existing log output from ntpd sucks.  Once it has output a 
msg saying:
 8 Dec 16:38:20 ntpd[1966]: kernel time sync enabled 0001
it is totally mute until:
11 Dec 10:47:29 ntpd[1966]: synchronized to 64.112.189.11, stratum 2
11 Dec 13:04:34 ntpd[1966]: synchronized to 80.96.123.120, stratum 2

Nearly 3 days of silence, during which time it updated the contents of 
the drift file at least 20 times is rather hard to swallow when you 
are trying to see what its doing.  So I have another script being 
started in /etc/init/ntpd that fires off at 30 minute intervals, cats 
the contents of the drift file to the log & runs an instance of ntpq 
-p >>ntp.log.

That looks like this (excuse the word wrap please):
drift=4.353
     remote           refid      st t when poll reach   delay   offset  
jitter
==============================================================================
+time.uswo.net   128.10.252.6     2 u  126 1024  377   85.553   -1.657   
0.167
+rrcs-24-172-8-1 80.64.135.105    3 u  200 1024  377   73.522    6.885   
3.648
*ecoca.eed.usv.r 80.96.120.253    2 u  200 1024  377  206.528    2.798   
3.468
 LOCAL(0)        LOCAL(0)        10 l   39   64  377    0.000    0.000   
0.001

A bit voluminous perhaps, but it sure gives me a much better picture of 
whether I can set my $25 Casio wristwatch to somewhere near the real 
time.  And, now that I've determined it is working, I could shut it 
off, but what happens then when I reboot to a new kernel and foo, bar, 
and baz are all on the missing list as has happened several times?  So 
I'll leave it running until I feel I can realy trust it.

I guess my point is, if we are to have a time synchronizer utility, it 
either should work, or raise hell & stomp its feet all over the logs 
once it determines that it cannot work correctly.  ntpd as implemented 
right now has a very bad case of laringitis(sp).

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
