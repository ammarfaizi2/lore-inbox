Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVJSTVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJSTVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVJSTVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:21:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:37809 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751238AbVJSTVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:21:08 -0400
Date: Wed, 19 Oct 2005 21:23:18 +0200
To: Zoltan Szecsei <zoltans@geograph.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20051019192318.GA21589@aitel.hist.no>
References: <4316E5D9.8050107@geograph.co.za> <20050911223414.GA19403@aitel.hist.no> <43566DCE.5040705@geograph.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43566DCE.5040705@geograph.co.za>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 06:01:18PM +0200, Zoltan Szecsei wrote:
> Hi Helga (et al),
> 
> I'm just back on this issue and am trying to make changes to the basic 
> xorg.conf without yet connecting the 2nd VGA,Kyb & mouse.
> 
> I thought if I set up a template for the config then it would be easier 
> to copy & make changes for when I connect the 2nd KVM devices.
> 
> I'm having a problem with the "Dev Phys" option as I keep getting:
> (EE) Generic Keyboard: cannot register with evdev brain
> No core keyboard.
> 
> (man xorg.conf does not show "Dev Phys" - should it not be "Device" ??
> 
> The real issue is that I cannot find the keyboard device in /dev/input 
> (Ubuntu 5.04 )
> In /dev/input I only have 6 devices: event0, 1 and 2; mice, mouse0 and ts0
> 
> Are you able to tell me what parameter to put in this Option "Dev Phys" ?
> 
> TIA,
> Zoltan
> 

(USe a 2.6 kernel)
$ cat /proc/bus/input/devices

On my machine:
I: Bus=0003 Vendor=09da Product=001a Version=0001
N: Name="A4Tech RF USB Mouse"
P: Phys=usb-0000:00:10.2-2/input0
H: Handlers=mouse0 event0 
B: EV=7 
B: KEY=ff0000 0 0 0 0 
B: REL=303 

I: Bus=0011 Vendor=0001 Product=0002 Version=ab83
N: Name="AT Raw Set 2 keyboard"
P: Phys=isa0060/serio1/input0
H: Handlers=kbd event1 
B: EV=120013 
B: KEY=402000000 3802078f840d001 f2ffffdfffefffff fffffffffffffffe 
B: MSC=10 
B: LED=7 

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event2 
B: EV=120013 
B: KEY=402000000 3802078f840d001 f2ffffdfffefffff fffffffffffffffe 
B: MSC=10 
B: LED=7 

Look for lines saying Handlers=kbd eventX
In the same block, you find Phys=<something>
Copy this into xorg.conf, yielding Dev Phys=<something>
The proc/bus/input/devices file tells you about all input devices,
such as keyboards, mice, joysticks...  Take care not trying to
interpret a mouse as a keyboard.. :-)


Helge Hafting 
