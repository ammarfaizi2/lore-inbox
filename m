Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319377AbSIKXGR>; Wed, 11 Sep 2002 19:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319378AbSIKXGR>; Wed, 11 Sep 2002 19:06:17 -0400
Received: from hermes.domdv.de ([193.102.202.1]:10771 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319377AbSIKXGQ>;
	Wed, 11 Sep 2002 19:06:16 -0400
Message-ID: <3D7FCDE0.200@domdv.de>
Date: Thu, 12 Sep 2002 01:12:32 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Vance <EdV@macrolink.com>
CC: "'dchristian@mail.arc.nasa.gov'" <dchristian@mail.arc.nasa.gov>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 serial drops characters with 16654
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did see something that looks quite similarl like dropped characters on 
Redhat and 2.4.9 based UP systems (that's customers choice and couldn't 
be changed) equipped with a NS-87336.
I can't go into detail but my company did port an application from DOS 
to Linux. The application communicates with an electronic cash device 
over a serial port. The coding for this communication wasn't modified 
during the port from DOS to Linux. It is furthermore important to know 
that both DOS and Linux run on exactly the same hardware.
The only thing different between DOS and Linux regarding the serial port 
is that the DOS application has assembler code for serial port access 
whereas the Linux version uses the standard kernel interface.
What happened was that while the DOS version worked the Linux version 
had communication problems which pointed to single ACK bytes not being 
transmitted sporadically. OTOH logging in the application showed that 
these ACK bytes were delivered to and acceped by the kernel.
The only way th handle this problem was to implement some protocol based 
workaround. I can only state what happened, no testing or analysis is 
possible from my side in this case. The same is true for further 
information, i.e. I can't go any bit more into detail. Sorry.

Ed Vance wrote:
> On Tue, September 10, 2002 at 3:22 PM, Dan Christian wrote:
> 
>>I've got a 2.4.18-10 (RedHat) running on a 2 processor Athlon (1.5Ghz).
>>If I send data over a PCI 16654 serial card (Connect Tech Blue Heat) and 
>>RTSCTS flow control is used, characters are dropped.  The drops are 
>>pretty consistent.  As far as I can tell, the data can only be lost in 
>>the driver (I'm re-trying the write until all the data gets out).
>>
>>If I use a 16550, then everything is fine.  Unfortunately, I can't get 
>>rid of the 16654s.
>>
>>If is use a 1 processor Athlon running 2.4.9-34 (RedHat), then 
>>everything is fine.
>>
>>I haven't been about to test the 2.4.18 SMP system in single processor 
>>mode, because the IO-APIC goes nuts.  But that's another bug...
>>
>>Anybody know why the serial driver is losing data?
>>
>>I'm not on linux-kernel, so please reply directly.
> 
> 
> Hi Dan,
> 
> We use Exar ST16C654D chips on a cPCI 16-port mux we build and have not
> (yet) had a problem report on it for this. Maybe I can reproduce the symptom
> on this board. What vendor marking is on your UARTs? Could you tell me more
> about your test setup and specifically how often data is dropped and how
> many characters are dropped each time? What kind of device is receiving the
> data and how much receive FIFO does it have left when it drops RTS to tell
> the Blue Heat to stop? 
> 
> Best regards,
> Ed
> 
> ---------------------------------------------------------------- 
> Ed Vance              serial24 (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

