Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUF0R6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUF0R6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUF0R60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:58:26 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:64348 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S261184AbUF0R6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:58:07 -0400
Message-ID: <40DF0A98.9040604@travellingkiwi.com>
Date: Sun, 27 Jun 2004 18:57:44 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
References: <1088160505.3702.4.camel@tyrosine> <1088268145.14987.248.camel@zion.2good.net> <40DDBA7A.6010404@travellingkiwi.com>
In-Reply-To: <40DDBA7A.6010404@travellingkiwi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamie wrote:

> David Eriksson wrote:
>
>> On Fri, 2004-06-25 at 12:48, Matthew Garrett wrote:
>>  
>>
>>> If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
>>> acpi_sleep=s3_bios passed on the command line). If I have the ioapic
>>> enabled, however, I get no interrupts after resume. Hacking in a 
>>> call to
>>> APIC_init_uniprocessor in the resume path improves things - I get edge
>>> triggered interrupts, but anything flagged as level triggered doesn't
>>> work. How can I get the ioapic fully initialised on resume?
>>>   
>>
>>
>> Maybe you've found this bug?
>>
>> http://bugme.osdl.org/show_bug.cgi?id=2643
>>
>>  
>>
> I think you're right... I've applied the patch to 2.6.7, and I'm still 
> running after a boot-suspend-resume cycle. Hopefully it isn't just a 
> fluke :)
>

Nope... A fluke... Mostly...

FWIW the sound & networking appear to run fine for a while after 
resuming. But I just started a DVD. It ran fine for about 30 seconds and 
then the sound went. About 30 seconds later the video froze and the app 
(xine) has frozen also. (kill -9 time...).

restarting xine it runs the viodeo for about 10 secs before freezing 
again... With no sound...

Checking /proc/interrupts with juk running (Supposedly playing music)

hamish@ballbreaker:~$ cat /proc/interrupts; sleep 10; cat /proc/interrupts
           CPU0      
  0:   10175817          XT-PIC  timer
  1:       2077          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     169347          XT-PIC  Intel 82801DB-ICH4, yenta
  8:          4          XT-PIC  rtc
  9:      49257          XT-PIC  acpi
 11:       8852          XT-PIC  yenta, uhci_hcd, uhci_hcd, uhci_hcd, 
ehci_hcd, eth0
 12:     110067          XT-PIC  i8042
 14:      63045          XT-PIC  ide0
 15:      38071          XT-PIC  ide1
NMI:          0
ERR:          0
           CPU0      
  0:   10185825          XT-PIC  timer
  1:       2077          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     169347          XT-PIC  Intel 82801DB-ICH4, yenta
  8:          4          XT-PIC  rtc
  9:      49301          XT-PIC  acpi
 11:       8857          XT-PIC  yenta, uhci_hcd, uhci_hcd, uhci_hcd, 
ehci_hcd, eth0
 12:     110586          XT-PIC  i8042
 14:      63055          XT-PIC  ide0
 15:      38071          XT-PIC  ide1
NMI:          0
ERR:          0
hamish@ballbreaker:~$ ping 192.158.254.254
PING 192.158.254.254 (192.158.254.254): 56 data bytes
64 bytes from 192.158.254.254: icmp_seq=0 ttl=239 time=191.1 ms
64 bytes from 192.158.254.254: icmp_seq=1 ttl=239 time=188.5 ms


The ethernet does still work though... Maybe it's fixed half the problem...

dmesg shows no errors...

radeonfb: suspending to state: 2...
PM: Entering state.
 hwsleep-0304 [42487] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hStart = 1656, hEnd = 1848, hTotal = 2160
vStart = 1202, vEnd = 1205, vTotal = 1250
h_total_disp = 0xc7010d    hsync_strt_wid = 0x180670
v_total_disp = 0x4af04e1           vsync_strt_wid = 0x304b1
pixclock = 6172
freq = 16202
lvds_gen_cntl: 000cffa5
radeonfb: resumed !
ACPI: IRQ9 SCI: Edge set to Level Trigger.
Restarting tasks... done
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e1908000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hw_random: RNG not detected
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
hamish@ballbreaker:~$


