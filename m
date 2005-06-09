Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVFIVI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVFIVI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVFIVI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:08:26 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:56917 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262470AbVFIVHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:07:55 -0400
Message-ID: <42A8AFA5.3090703@tls.msk.ru>
Date: Fri, 10 Jun 2005 01:07:49 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>	 <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr>	 <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com>	 <42A4D1AB.3090508@tls.msk.ru>	 <1118224334.3245.89.camel@localhost.localdomain>	 <42A75525.3050704@tls.msk.ru> <1118274762.29855.2.camel@localhost.localdomain>
In-Reply-To: <1118274762.29855.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> On Thu, Jun 09, 2005 at 12:29:25AM +0400, Michael Tokarev wrote:
> 
>>Adam Belay wrote:
>>[]
>>
>>>>>>[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
>>>>>>as Content-Type: text/plain, for some reason.  I grabbed iasl
>>>>>>and converted that stuff into .dsls, available at:
>>>>>>http://www.corpit.ru/mjt/hpml310.dsl and
>>>>>>http://www.corpit.ru/mjt/hpml150.dsl ]
[]
>>>1.) a complete dmesg after initial boot with the patch
>>>2.) kernel message output after "rmmod parport_pc" and "modprobe
>>>parport_pc" with the patch

Hello again.  This whole conversation seems to be a bit...
slow, probably due to $TZ differences and the fact that
I can do experiments only at evenings, because the test
machine (and non-test one too) are busy during work hours.

Adam, I built 2.6.12-rc6 with your last patch, and tried it on
both ML150 and ML310 machines.  And in both cases, the whole
thing worked.

Dmesg from HPML150:

[modprobe parport_pc]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
[rmmod parport_pc]
pnp: Device 00:07 disabled.
[modprobe parport_pc]
pnp: building resource template
pnp: encoding resources
pnp: attempting to fix irq flags
bug squashed - dma
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:07 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]

The same applies to 8250_pnp module:

[modprobe 8250_pnp]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[rmmod 8250_pnp]
pnp: Device 00:06 disabled.
[modprobe 8250_pnp]
pnp: building resource template
pnp: encoding resources
pnp: attempting to fix irq flags
bug squashed - dma
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:06 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A


And HP ML 310 box:

[modprobe parport_pc]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[rmmod parport_pc]
pnp: Device 00:06 disabled.
[modprobe parport_pc]
pnp: building resource template
pnp: encoding resources
pnp: attempting to fix irq flags
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:06 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]

[modprobe 8250_pnp]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[rmmod 8250_pnp]
pnp: Device 00:07 disabled.
pnp: Device 00:08 disabled.
[modprobe 8250_pnp]
pnp: building resource template
pnp: encoding resources
pnp: attempting to fix irq flags
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:07 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: building resource template
pnp: encoding resources
pnp: attempting to fix irq flags
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:08 activated.
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

There are two questions still.

First of all, why disable the device on module unload?
If it was enabled initially, before any module has been
loaded, why it needs to be disabled, why not leave it
enabled and all, just like it has been before?

And this 8250 vs 8250_pnp (and 8250_pci etc, but
especially 8250_pnp as it is the most interesting one).
When loading 8250 alone (note that 8250_pnp depends
on 8250, so 8250 gets loaded first), it detects standard
serial port(s) just fine.  8250_pnp "redetects" them again
(see first `modprobe 8250_pnp' above: each ttySN line
gets repeated twice). But when unloading 8250_pnp, both
standard ttySNs are deactivated, even when 8250 is still
here.  More, when unloading both 8250_pnp and 8250, and
loading *only* 8250 after that, no standard ports gets
detected until 8250_pnp will be loaded (as the devices
are disabled, and 8250_pnp re-enables them).  Ie, this
whole stuff does not look right.  Probably a nitpicking,
but a bit.. strange.  Probably if 8250_pnp will stop
deactivating the devices (as per above), everything will
look ok here too.  Or, maybe it's a good idea to just
combine 8250 and 8250_pnp modules (and maybe 8250_serial
too), esp, since the latter is very small anyway ?

Thank you!

/mjt
