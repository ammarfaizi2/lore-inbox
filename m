Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTHFRCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270734AbTHFRCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:02:52 -0400
Received: from hydrogen.one-2-one.net ([217.115.142.89]:48389 "EHLO
	hydrogen.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S270730AbTHFRCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:02:44 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <d.nuetzel@wearabrain.de>
Organization: WEAR-A-BRAIN
To: Adrian Bunk <bunk@fs.tum.de>, phil@netroedge.com
Subject: Re: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 18:49:01 +0200
User-Agent: KMail/1.5.3
Cc: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, sensors@stimpy.netroedge.com
References: <200308060621.06216.d.nuetzel@wearabrain.de> <20030806100815.GH16091@fs.tum.de>
In-Reply-To: <20030806100815.GH16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308061849.01416.d.nuetzel@wearabrain.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. August 2003 12:08 schrieb Adrian Bunk:
> On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter Nützel wrote:
> > Hello,
>
> Hi Dieter,
>
> > I had it running very well on my dual Athlon MP 1900+ for several months
> > before. Latest Kernel was 2.4.22-pre5+ACPI patch.
> >
> > Any changes?
> > I changed lm_sensors from 2.7.0 (?) to 2.8.0

This one is the culprit.
Reverting to 2.7.0 cure my problems.

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-amd756.o version 2.7.0 (20021208)
i2c-amd756.o: Found AMD768 SMBus controller.
i2c-amd756.o: AMD768 bus detected and initialized

amd76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller
amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 
[Opus] ACPI
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
eeprom.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)

> > System:
> > dual Athlon MP 1900+
> > MSI K7D Master-L
> >
> > 2.4.22-rc1
> > acpi-20030730-2.4.22-pre8.diff
> > preempt-kernel-rml-2.4.21-1.patch
> >...

Work all fine, now.

>
> does an unpatched 2.4.22-rc1 work?

I think it do;-)

amd76x_pm is GREAT!

/home/nuetzel> sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.72 V  (min =  +1.61 V, max =  +1.77 V)
VCore 2:   +2.49 V  (min =  +2.36 V, max =  +2.62 V)
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.01 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.44 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.47 V  (min =  +2.40 V, max =  +3.60 V)
U160:     2327 RPM  (min = 1500 RPM, div = 4)
CPU 0:    4090 RPM  (min = 3000 RPM, div = 2)
CPU 1:    4115 RPM  (min = 3000 RPM, div = 2)
System:   +37.0°C   (limit = +40°C, hysteresis = +37°C) sensor = thermistor
CPU 1:    +29.0°C   (limit = +52°C, hysteresis = +47°C) sensor = 3904 
transistor
CPU 0:    +31.0°C   (limit = +52°C, hysteresis = +47°C) sensor = 3904 
transistor
vid:      +18.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled


Cheers,
	Dieter

-- 
Dieter Nützel
Leiter F&E, WEAR-A-BRAIN GmbH, Wiener Str. 5, 28359 Bremen, Germany
Mobil: 0162 673 09 09

