Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSK0Rgj>; Wed, 27 Nov 2002 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSK0Rgj>; Wed, 27 Nov 2002 12:36:39 -0500
Received: from mail.wincom.net ([209.216.129.3]:20487 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S264631AbSK0Rgi>;
	Wed, 27 Nov 2002 12:36:38 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 27 Nov 2002 12:52:45 -0500
Subject: Re: A Kernel Configuration Tale of Woe
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de507c7.1c64.0@wincom.net>
X-User-Info: 129.9.27.146
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 2002-11-26 at 19:28, Dennis Grant wrote:

>> Agreed - so then the association between "board" 
>> and "chipset" must be capable of being multi-valued,
>> and when there is a mult-valued match there must be 
>> some means of further interrogating the user (or user agent)
>> for more information.

> Much simpler to just include "modular everything" and let
> user space sort it out. Guess why every vendor takes this path

Oh, OK... Now I see what you're getting at.

Build a kernel where everything is a module, boot with some sort of absolute-bare-minimum
bootloader kernel, and then self-configure dynamically. Either to, from there,
generate a specific kernel config file from which to build a box-specific kernel
- or just to hell with it, and self-configure every time at boot.

Well... yeah. Assuming all the modules can autodetect, or that there's some
sort of sane userspace module loader doing autodetection, reading from a config
file, or both... yeah, that works.

I'll be honest - certain aspects of this offends some of my asthetics... but
that's not a requirement. Functionality is.

And with the assumption that all the modules needed, plus the mechanism to determine
if a given module is/is not loaded (and if loaded, how it is to be configured)
are availible on the box, this is 100% functional.

But....

I don't think this would have solved any of my problems.

I haven't had the opportunity to test it yet, but I have every confidence that
my ATA speed problems are a product of an incompletely-supported motherboard
chipset (wrt the kernel I compiled), and that once the 20-pre3+ac patches are
applied, that I'll have the correct drivers availible and everything will Just
Work. Certainly this was the case with the onboard Ethernet (I had to track
down a vendor driver, as it appears there is no support anywhere in a 2.4 series
kernel as of yet).

So even if 2.4.19 _had_ the "everything as modules" option, plus the required
userspace glue, you'd still be hearing from me, because there is no module there
to be autoloaded that matches my hardware.

And then there's still the issue of enough information being presented out of
the modules to allow one to examine the dmesg output from a boot and actually
determine that modules were missing (or missing features, or whatever)

So I think there's still a need for the hardware->kernel version+config database.
Perhaps the need for the query mechanism to generate an actual working kernel
config is less than I first imagined, but certainly the ability to generate
(if nothing else) the minimum kernel version required to support a give set
of hardware has value - it would have kept me away at least. :)

DG 
