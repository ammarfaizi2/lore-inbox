Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUJYPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUJYPma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUJYPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:41:36 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3081 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261986AbUJYPfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:35:04 -0400
Message-ID: <417D2027.5000306@techsource.com>
Date: Mon, 25 Oct 2004 11:47:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <9e4733910410201808c0796c8@mail.gmail.com> <Pine.GSO.4.61.0410222209410.11567@waterleaf.sonytel.be> <417984A9.2070305@techsource.com> <20041024104520.GB12665@hh.idb.hist.no>
In-Reply-To: <20041024104520.GB12665@hh.idb.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> On Fri, Oct 22, 2004 at 06:07:37PM -0400, Timothy Miller wrote:
> 
>>
>>Geert Uytterhoeven wrote:
>>
>>>On Wed, 20 Oct 2004, Jon Smirl wrote:
>>>
>>>
>>>>If you implement VGA you will be able to boot and work in any x86
>>>>system without writing any code other than the BIOS.
>>>
>>>
>>>Ugh... I prefer _not_ to have VGA compatibility.
>>
>>Well, some people agree with you, but if I can squeeze it small enough, 
>>it's worth having because it maximized compatibility.  It's vital for 
>>x86 consoles.
> 
> 
> I can't see how it is "vital", or even makes a difference at all.
> Other than upping the price a bit.  The pc doesn't need VGA compatibility
> to boot - because you supply a video bios.  The mainboard bios
> uses the video bios. (There have been pc's with ibm-incompatible
> displays before)
> Linux d(and other open os'es) doesn�'t need VGA at all, because 
> you supply docs.  You probably won't even have to write the driver
> yourself.
> Windows doesn't need VGA - if you supply a windows driver.  That
> shouldn�'t be hard to do.  


We have a number of cards which do not support VGA, and a few years ago, 
I experimented with the idea of writing a VGA BIOS which emulated the 
VGA text screen in software.

What I discovered was that absolutely everything, including the DOS 
shell, expects there to be REAL VGA (or CGA or whatever) hardware there, 
so hooking int 10 just did not do the job... it practically never got 
called.  What I ended up doing was hooking the timer interrupt and 
comparing the text screen against a shadow copy.  That worked very well 
for most DOS applications... except for those which tried to do anything 
in protected mode.  The instant an OS switched to protected mode, the 
interrupt handler got blown away and the display froze.

Then we though we'd put a proper driver into the OS, but the problem is 
that in Windows and Solaris, the console driver doesn't kick in until 
WAY late in the boot process, so you end up with a useless console for 
THE MAJORITY of the boot process.

For Windows, there is a requirement for 640x480x4 and some 320x480x?? 
mode to be supported by the hardware using the standard VGA IO space 
registers.  That is, IF you want a console.  Yes, you can boot without 
VGA, but your screen is blank until the driver kicks in, so if there's a 
PROBLEM, you're hosed.

VGA is so "expected" that pretty much everything just assumes it's there 
and bangs on the hardware directly.

The only thing the VGA BIOS does on most modern cards is configure the 
non-VGA bits of the card to function properly and get it into text mode. 
  After that, it's all VGA until an OS loads a graphics driver.

