Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131519AbRAEBWf>; Thu, 4 Jan 2001 20:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAEBW0>; Thu, 4 Jan 2001 20:22:26 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:40176
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S129962AbRAEBWB>; Thu, 4 Jan 2001 20:22:01 -0500
From: Jesse Pollard <pollard@cats-chateau.net>
Reply-To: pollard@cats-chateau.net
To: Gunther.Mayer@t-online.de (Gunther Mayer),
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Date: Thu, 4 Jan 2001 19:13:52 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-parport@torque.net, linux-kernel@vger.kernel.org
In-Reply-To: <200101041530.JAA92328@tomcat.admin.navo.hpc.mil> <3A54CD80.4A163381@t-online.de>
In-Reply-To: <3A54CD80.4A163381@t-online.de>
MIME-Version: 1.0
Message-Id: <01010419215503.09343@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2001, Gunther Mayer wrote:
>Jesse Pollard wrote:
>> Originally, (wayback machine on) this was handled by a pull-up resistor
>> in the parallel interface, on the "off-line" signal. ANY time the printer
>> was powered off, set offline, or cable unplugged, the "off-line" signal
>> was raised by the pull-up. No data lost.
>> 
>> Now the parallel interface is bidirectional, and can have multiple devices
>> attached - this "fix" cannot be used. The interface is now more of a
>> buss than a single attached interface, and signals from a missing device
>> (powered off or disconnected) are floating. They may float high or low,
>> and depending on the environment (and which end of the cable is unplugged)
>> any thing in between.
>
>Not true. Electrical characteristics for parallel port implementations/cards
>differ wildly, nevertheless most implementations have:
>- data lines: bidirectional (see datasheets)
>- signal lines: see datasheets, never floating !
>
>Floating signal lines are a silicon bug/bad engineering and have nothing
>to do with bidirectional interfaces ! 

I didn't mean to imply that it was - just that it is much harder to determine
if the device is attached or detatched. That depends on the characteristics of
the interface and the cable (acting as an antenna).

>
>Nowadays most integrated chips have internal signal line pull-ups internally, e.g. 
>W83877TF says:
>-BUSY, ACK, PE, SLCT, ERR:
>  TTL level input pin. This pin is pulled high internally.
>-AFD, STB, INIT, SLIN
>  Open-drain output pin with 12 mA sink capability. Pulled up internally.
>-Data lines:
>  TTL level bi-directional with 24 mA source-sink capability.
>
>Of course I would expect add-in cards to exist, with not so sophisticated chipsets
>and makers that have "forgotten" external pull-ups for economical reasons (2 cents :-)
>We should NOT care for broken hardware !!! I haven't seen any of these yet, even.
>
>On the other hand printer implmentations vary wildly, too.
>LJ1100: leave signal lines alone if powered off (0x7f)
>    i.e. signal printer-not-ready ack-active out-of-paper
>DJ500: signal printer-error and off-line when powered off (0x87) !!!
>    => Linux would dump data on this printer, if switched off.
>
>I think the current linux lp code tries to handle exotic/weird printers 
>gracefully and leaves mainstream printers and users alone.

It all depends - I've seen printers work perfectly ... and yet others
completely fail. The Xerox 5700 printers wouldn't work if the cable were
over 9 feet long. They would if a high signal quality data cable were obtained,
worked at 15', but no longer than that. Even then, they would not identify
(and neither would Zerox) what happens when they were powered off (you loose
data).

And yet no problem with a HP laserjet at 40'.

And the signals do vary if it is unplugged at the printer end and not
at the host end (major difference - shielded cable works MUCH better).

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@cats-chateau.net

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
