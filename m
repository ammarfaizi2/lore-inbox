Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWBMQlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWBMQlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBMQlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:41:31 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:31769 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932147AbWBMQlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:41:11 -0500
Message-ID: <43F0B66A.2080602@cfl.rr.com>
Date: Mon, 13 Feb 2006 11:40:10 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org> <43F0027E.2070207@cfl.rr.com> <9B9A94E5-F23E-4FCD-83DA-7C2AA9AE86E3@mac.com>
In-Reply-To: <9B9A94E5-F23E-4FCD-83DA-7C2AA9AE86E3@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 16:42:00.0306 (UTC) FILETIME=[692B2D20:01C630BC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--21.399000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> This is true for software suspend, but not for hardware suspend (see 
> the differences now?)  This is why the two are independent and should 
> not be

No, that is not necessarily correct.  Sometimes the ACPI bios can leave 
certain devices in a standby mode so they can wake the machine, but it 
does not have to, and often does not.  Thus when suspended to ram, 
typically your usb hard drive and almost allways your ide/sata/scsi 
drive will be completely powered off. 

> mashed together into one "Generic Suspend".  Let me bring up the 
> example of my PowerBook again.  It's RAM is fully powered right now, 
> running from battery, and it has another couple days of sleep-charge 
> left before I have to worry about plugging it in again.  When I open 
> it, the firmware automatically powers up the CPU and other hardware 
> and returns control to the OS.  I can _also_ trigger it to wake by 
> leaving it closed and connecting an external VGA and USB (it wakes 
> every time I connect a USB, but my suspend script puts it to sleep 
> again if it's closed and has no external VGA).
>

Then your motherboard keeps the bus in a lower power state such that it 
is capable of causing a wake event when state changes.  I'm also fairly 
sure that when such a wake event happens, there is no indication to the 
kernel about why it was woken up.  Because of that, and the fact that 
not all systems even support such wake modes, the kernel must reprobe 
all hardware when it wakes up, and hopefully finds the same devices that 
were there when it went to sleep.  It does this for both types of suspend. 

>> and in either case, there is nothing running on the CPU to monitor 
>> device insertion/removal.
>
> You don't need the CPU, just a good USB controller and hubs with 
> low-power modes and such.  The fact that plugging in a USB 
> keyboard/mouse and a VGA monitor is enough to wake the system when 
> properly configured should be proof enough.
>

That is not proof of anything other than the bus controller has the 
capability of generating a wake event.  As I said before, once woken up, 
the kernel must probe all hardware and if there is a new device, it will 
find it.  The hardware only detected that something changed and thus, 
generated a wake even, it did not notice exactly what that change was 
and inform the kernel. 

>> When the system is resumed the kernel decides if the hardware has 
>> changed the same way for either system: it probes the hardware to see 
>> if it is still there.  There isn't anything special that monitors 
>> device insertion/removal while suspended to ram.
>
> Sometimes not, but again, it depends on the hardware.

Again, always not since the hardware doesn't actually tell the kernel 
what happend, it just wakes it up. 

>
> Cheers,
> Kyle Moffett
>
> -- 
> I have yet to see any problem, however complicated, which, when you 
> looked at it in the right way, did not become still more complicated.
>   -- Poul Anderson
>
>
