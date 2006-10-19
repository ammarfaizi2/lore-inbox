Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWJSOMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWJSOMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWJSOMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:12:55 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:63505 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S1161046AbWJSOMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:12:54 -0400
Message-ID: <453787E3.1010408@xs4all.nl>
Date: Thu, 19 Oct 2006 16:12:51 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.18 w/ GPS time source: worse performance
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>	 <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>	 <45365A0B.5030306@xs4all.nl>	 <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>	 <1161207996.15860.134.camel@mindpipe> <1161213459.5875.52.camel@localhost.localdomain>
In-Reply-To: <1161213459.5875.52.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2006-10-18 at 17:46 -0400, Lee Revell wrote:
>> [added John Stultz to cc]
>>
>> On Wed, 2006-10-18 at 15:57 -0400, Valdis.Kletnieks@vt.edu wrote:
>>> On Wed, 18 Oct 2006 18:44:59 +0200, Udo van den Heuvel said:
>>>> It is stuff that is visible by watching ntpq -pn output, by letting mrtg
>>>> graph stuff, etc. Watch the offset and jitter collumns.
>>>> Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.
>>> So... you've presumably done that while identifying there is an issue.
>>> Please share the results.  Have you tried booting back into a 2.6.17
>>> or so and seen offset/jitter improve?  etc etc etc.
> 
> Udo: 
> 	Are you running the linuxpps patches, or is this vanilla 2.6.18 without
> any additional patches? Mind sending your dmesg and some "ntpdc -c
> kerninfo" output? Any of those graphs you mention above would be great
> as well.

I am running the latest LinuxPPS patch from Rodolfo Giometti.

# /usr/sbin/ntpdc -c kerninfo
pll offset:           -0.002536 s
pll frequency:        20.610 ppm
maximum error:        0.007567 s
estimated error:      0.00046 s
status:               0001  pll
pll time constant:    2
precision:            1e-06 s
frequency tolerance:  512 ppm
# ntpq -pn
     remote           refid      st t when poll reach   delay   offset
jitter
==============================================================================
 127.127.1.0     .LOCL.          10 l    7   64  377    0.000    0.000
 0.002
*127.127.20.0    .GPS.            0 l    1   16  377    0.000   -0.268
 0.102
-194.109.22.18   193.79.237.14    2 u  257  512  377    5.511    0.951
 1.444
+193.67.79.202   .GPS.            1 u  250  512  377   16.862    0.398
 4.701
+193.79.237.14   .GPS.            1 u  251  512  377   13.306   -0.001
[cut]

I don't have a dmesg for 2.6.18.1 on this machine (did not save it).
Will do when there is a next reboot of this VIA CL6000E board.

When the machine was idle offset and jitter would be in the 0.00X range.
Now it is more in the 0.XXX range or worse.
Performance for these figures has at least deteriorated a factor of
about 10.

The mrtg graphs are of no use since in the month graph the 'good' part
just moved off the screen and in the year graph the resolution is too
low. :-(

Udo
