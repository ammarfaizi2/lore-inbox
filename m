Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSFMJFP>; Thu, 13 Jun 2002 05:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317556AbSFMJFO>; Thu, 13 Jun 2002 05:05:14 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34310 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317552AbSFMJFN>; Thu, 13 Jun 2002 05:05:13 -0400
Message-ID: <3D08603E.91DE5C75@aitel.hist.no>
Date: Thu, 13 Jun 2002 11:05:02 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>,
        linux-kernel@vger.kernel.org
CC: helge.hafting@broadpark.no
Subject: Re: The buggy APIC of the Abit BP6
In-Reply-To: <000201c21261$3a8fde70$020da8c0@nitemare>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robbert Kouprie wrote:
> 
> Hi all,
> 
> First of all, I know the Abit BP6 is infamous about its APIC, but I
> would like to make sure there's absolutely no solution for this except
> disabling the APIC.
> 
> I am experiencing problems for a long time now, which are always related
> to the NIC in the box (probably due the being a device that generates a
> lot of interrupts). The NIC has changed a couple of times (from 3com 10
> Mbit to Intel eepro100 to 3Com PCI 3c905B Cyclone 100baseTx now), and
> it's NOT placed in the infamous (I believe 3rd) PCI slot of the board
> (mentioned in the manual). Also, /proc/interrups shows NO sharing with
> another device. The running kernel is 2.4.19-pre8-ac5 SMP, though many
> kernels have preceded it, with the same results.
> 
> The problems appear once in a while (in order of days/weeks). They are
> always interluded with an "unexpected IRQ trap at vector 7d", and then
> followed within a minute by chaos in the network driver. I found the
> message of the 3com driver to be the most clear one, see the snippet
> below. When I boot with "noapic", the problems go away.
> 
> Is there a solution that does not require disabling the APIC as a whole
> or is this just too flaky hardware?
> 
> Thanks in advance,
> - Robbert Kouprie
> 
> PS. Please CC me in answers, as I'm not on the list.
> 
> Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d
> Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d

It _can_ be solved - rebooting cures it, so assuming the problem
is autodetectable it _can_ be solved by doing whatever it is
a reboot (or driver reload) does to the APIC.

My guess is that the APIC setup for that IRQ have to be reprogrammed.
you could do that as a quirk for the BP6. 
The first question is if there is a reliable way to detect this
condition.  "No interrupts from a device" could simply mean that
it isn't used much at the time.  You get a unexpected IRQ trap - do
the problem always manifest itself this way?
The second question is if all the PCI card drivers out there
survive a lost interrupt handled outside the driver.  
If not, you have to close+reopen the device, and that involves
userspace.
A network card will need reinitialization, a disk controller
remounting...


Helge Hafting
