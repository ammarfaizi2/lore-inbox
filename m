Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJ1Wvl>; Mon, 28 Oct 2002 17:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJ1Wvk>; Mon, 28 Oct 2002 17:51:40 -0500
Received: from mario.gams.at ([194.42.96.10]:21558 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S261650AbSJ1Wvb> convert rfc822-to-8bit;
	Mon, 28 Oct 2002 17:51:31 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Bas Vermeulen <bvermeul@blackstar.nl>
cc: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: 2.4.20pre11aa1 freezes after inserting a PCMCIA ethernet card 
References: <Pine.LNX.4.33.0210280855550.8026-100000@devel.blackstar.nl> 
In-reply-to: Your message of "Mon, 28 Oct 2002 08:59:33 +0100."
             <Pine.LNX.4.33.0210280855550.8026-100000@devel.blackstar.nl> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 28 Oct 2002 23:57:49 +0100
Message-ID: <2071.1035845869@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Vermeulen <bvermeul@blackstar.nl> wrote:
>> I have a Toshiba Satellite 2540 CDT laptop. It works with a stock 
>> Redat-6.2 2.2.14 kernel RPM (but not with the 2.2.19 Update RPM - 
>> symptoms are similar to below). The system is basically a RedHat-7.3 
>> with the 2.2.14 kernel from RedHat-6.2 and some newer RPMS from 
>> RawHide.
>> The Kernel (probably) freezes after inserting a Surecom PCMCIA 
>> Ethernet Card (EP-427/EP-427-T) since it always fsck'es the
>> filesystems during the next boot. If the laptop is booted without
>> the card, everything is working properly (though I do not do much
>> without the network card).
>> This happens if the PCMCIA card already is inserted during startup or 
>> if it is inserted later on (after a successful boot as described above).
>
>You may want to try to cut back on io ports probed by cardmgr.
>Almost the same happens on my box, when I don't cull some of the io ports
>in /etc/pcmcia/config.opts. You can try commenting out some of the ports 
>there (I believe 0x800 was the culprit on my laptop, ymmv).

Hmm, 0x800 seems unused here (at least in /proc/ioports). But 
the pcnet_cs modules uses only 0x300-0x307 and 0x310-0x317, so I 
reduced (in /etc/pcmcia/config.opts) the range from 
"include port 0x100-0x4ff, port 0x1000-0x17ff" to 
"include port 0x300-0x320, port 0x1000-0x17ff" and it seems to work 
now - at least the laptop booted sucessfully and and there is a 
network conection.

Thanks for your help!

	Bernd

-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


