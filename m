Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbTIJInm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTIJInm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:43:42 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:25093 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S264787AbTIJIne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:43:34 -0400
Message-Id: <200309100840.h8A8e0vo002731@alpha.ttt.bme.hu>
From: "Horvath Gyorgy" <HORVAATH@tmit.bme.hu>
Organization: DTT_BUTE
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2003 10:38:06 +0200
Subject: Re: [ANNOUNCE] New hardware - SGA155D dual STM-1/OC3 PCI ad
X-mailer: Pegasus Mail v3.22
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

thank you for your advise!

>====> From Justin Cormack <justin@street-vision.com>
>
>
>You can have a driver core module that finds the cards, then
>subdrivers
>that the user can load, each with a firmware loader interface such
>that
>loading the firmware for a particular card sets the function on that
>card (and registers the devices etc). Probably best to have the
>firmware
>loading from userspace.

OK. But loading from the user-space will be used for development only
-
to see how the new FPGA stuff going. I think it can be done by using
simple device writes to the core driver, and some IOCTLs.

>====> From  Alan Cox <alan@lxorguk.ukuu.org.uk>
>
>On Maw, 2003-09-09 at 15:27, Horvath Gyorgy wrote:
>>   ....
>>    My guess is that I write a core driver for the hardware itself
>>    that can be compiled in the kernel (or can be modularized).
>>    This driver allows manipulating the IP-Core for the FPGA.
>>    Functional drivers are then modularized on demand.
>
>That is probably the right model. We do something similar with dual
>function parallel/serial cards and of course on a huge scale with USB
>where a USB hub means loading many other drivers to use the devices
>attached to it.

I think I was not precise enough. Sorry.
"On demand" - not from the applications' or hot-plug device's
point of view - but the configuration of the given box as a whole.
Let say - passing the string "TTTPP" to the core driver
(as kernel parameter) tells that first three card is
for telephony, and the next two for POS. Is it OK?

>>    BTW Can I insmod other drivers from a kernel driver?
>
>Yes. request_module() and the hotplug interface let you do that in
>various kernels. Right now for example the USB layer goes back to the
>userspace /sbin/hotplug and says "I need a driver for one of these"
>and
>the hotplug layer figures out what to do.

I see... e.g. in generic_ppp.c for compression modules.

>
>> 2. Packet over SONET...
>>    Is syncppp conforming RFC1619, RFC1662, RFC2615?
>>    I can't find notes on this in syncppp.c...
>
>Syncppp is pretty basic and obsoleted by the hdlc driver stuff.

Hmmm... the hdlc.c sais the syncppp.c is used for PPP.
I'll dig it up.

>
>> 3. The telephony part is not yet clear for me.
>>    For the new application in question - there is not much to do
>>    in Linux, since the mass will be driven/sunk by the
>>    hard-disks.  But it might be useful elsewhere...
>>    Anyway - I will dig-up the Linux telephony project for advice
>>    before bothering this list.
>
>Take a look at the Zaptel stuff, thats basically the T1 version of a
>winmodem but might have some interesting ideas in it.

Thank you. I am on it.

>
>> 4. Optionally - and if I have enough time - I'd like
>>    to develop a twin-linear filesystem driver for
>>    time-stamped capture/playback for multiple channels
>>    of data - like a multi-band magnetic tape.
>>    BTW do you know an existing one?
>
>I've seen people do this in user space (just interleaving the disk in
>big chunks in the app and driving it with O_DIRECT raw access) but
>not
>in kernel file system space.

That's quick and dirty - but efficient. OK.
Whistles and bells can wait...

>====> From  Francois Romieu <romieu@fr.zoreil.com>
>
>Greetings,
>
>Horvath Gyorgy <HORVAATH@tmit.bme.hu> :
>[...]
>> 2. Packet over SONET...
>>    There were rumours about a Lucent card, and a driver for it -
>>    but I can't reach that now (a link to the void) - just
>>    for reference.
>
>NTheta Optistar (TM) ?
>
><URL:http://www.fr.zoreil.com/people/francois/misc/oclinux1_0_tar.gz>

Yes, yes, yes, yes!!!! That is it! Goooooooood stuff!
I can't beleive it!!!  Ol' PM5357 from PMC-Sierra for OC-12!
It's been years...

I almost forget that I have already developed an ATM adapter
for 622 Mbps with that chip.
I am totally stupid. THAT CAN DO POS AS WELL.
The CP622E with drivers for VxWorks is actually not in production.
Some info from the early stages of the development can be found
in http://alpha.ttt.bme.hu/~cellpick.
It was used for network monitoring - and performed well.

Let's thinking...
Little HW/FW/SW mods, and I have a POS box - for testing
the SGA155D implementation.
Errr... Actually the only piece of that card that I have is
at a student - for playing with :-)
Yep... And as I remember - that revision of the chip contains a
silicon bug in POS mode...
Life is hard.

Thank you for all again, now I can get started.

Best regards,
Gyuri

Gyorgy Horvath,        Technical University of Budapest
--------------         Dept. of Telecom. and Telematics

Tel.: +36-1-463-1865,  Fax.: +36-1-463-1865
Mail: horvaath@bme-tel.ttt.bme.hu
FTP:  ttt-pub.ttt.bme.hu  ./income
