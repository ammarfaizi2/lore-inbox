Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRKDAfS>; Sat, 3 Nov 2001 19:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRKDAfI>; Sat, 3 Nov 2001 19:35:08 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:14497 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S276759AbRKDAe6>;
	Sat, 3 Nov 2001 19:34:58 -0500
Date: Sun, 04 Nov 2001 00:34:55 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] IBM T23; quirks force enable interrupts in APM set
 power state, causes crash on suspend
Message-ID: <552962010.1004834094@[195.224.237.69]>
In-Reply-To: <1004833243.5995.852.camel@thanatos>
In-Reply-To: <1004833243.5995.852.camel@thanatos>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

--On Saturday, 03 November, 2001 7:20 PM -0500 Thomas Hood 
<jdthood@mail.com> wrote:

>> Summary: dmi_scan.c forces interrupt enable on during PCI BIOS
>> call for all IBM machines, which breaks T23, which needs it
>> off it seems.
> [...]
>> BIOS Vendor: IBM
>> BIOS Version: 1AET38WW (1.01b)
>> BIOS Release: 07/27/2001
>
> I would suggest that you try upgrading your firmware before
> concluding that your patch is necessary.  The latest firmware
> listed on IBM's website is version 1.03 = 1AET43WW,
> released 19 October 2001.  There have been a LOT of changes since
> version 1.01 of the firmware.  Here is IBM's changelog:

Here's the results

With my patch on 2.4.12-ac5, it was working.

First I took Arjan's pci-bridge patch alone (no BIOS
upgrade etc.). It crashes the machine on suspend.

Then I tried upgrading the BIOS firmware (to 1.03) and
the embedded controller firmware (to 1.02) - i.e. without
Arjan's patch, still running 2.4.12-ac5. It doesn't
resume properly and hung APM but didn't crash.
I believe this may be because I fixed the .config
to run the sound driver at the same time, and it oops'd,
and generally annoyed the suspend process - tsk tsk
changing too many variables at once.

Then I upgraded to 2.4.13-ac7 (which has Arjan's patch
in). All is now well. Any luck & I'll have sound working
too :-)

My conclusion is that the BIOS upgrade fixed the
necessity to call APM BIOS with interrupts off,
so the dmi_scan.c stuff which forces interrupts on
is now harmless.

So if you want to put a patch in, I guess it could
at least not break things on early T-23 BIOS's
(as that's what the dmi_scan does - as the config
option no longer has any effect), or at the /very/
least, document the fact that a BIOS & embedded
controller upgrade is extremely advisable.

[ I am recording T23 experiences at
    http://www.alex.org.uk/T23
  for anyone interested - especially in contributing]

--
Alex Bligh
