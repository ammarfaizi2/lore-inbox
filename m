Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWFTIdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWFTIdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWFTIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:33:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:50631 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965038AbWFTIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ob1VmoDe/edlpc9s0Mz+kEL0Hrg0Prg08HwvXS+w+vgFyxKl3y9UeCNJZyuCZ2NO2YmPlSnhkQjs2di2dA98GXmNVpH08tkILI1AxZaQ7REBfrAIZRqI0ldm4xhXjgkyyCjsh7azsqH6Fu1Uio6jbtlL+zaPU0qbS9wi4pLkat4=
Message-ID: <4497B2B5.4040001@gmail.com>
Date: Tue, 20 Jun 2006 16:32:53 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
References: <44957026.2020405@gmail.com>	 <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>	 <44974AC7.4060708@gmail.com> <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
In-Reply-To: <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/19/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > I gave this patch a try and it seems to work. I say seems because I
>> > could not get the nvidiafb driver to set a usable mode after it was
>> > bound/unbound.
>>
>> What do you mean by this?  You mean that you cannot restore vgacon?
>> If that's the case, then yes, that is perfectly understandable as
>> nvidiafb does not restore VGA to text mode.
> 
> modprobe fbcon
> modprobe nvidiafb
> 
> Display is messed up.
> 
> I used to fix this by switching to X and back but the nvidia X driver
> won't build on the mm kernel. I can try again and write a script to
> echo a mode into sysfs after the modprobe.
> 
> When fbcon first gets a new fbdev driver registered with it, should it
> pick one of the modes is supports and set it automatically?

All fbdev drivers have a startup mode that should always be valid. All
fbcon does is enable that mode.

You can load nvidiafb like this instead:

modprobe nvidiafb mode_option=1024x768@60

> 
>>  or would it be better for each driver to set in a
>> > default mode that it understands when it gets control? The fbdev
>> > driver should not set a mode when it loads, but that doesn't mean
>> > fbcon can't set one when it is activated. Similarly VGAcon would set
>> > the mode (and load its fonts) when it regains control.
>>
>> The problem with vgacon setting its own mode is that it does not know
>> anything about the hardware. So VGA text mode will need to rely on
>> a secondary program to set the mode (whether it's vbetool, another
>> fb driver, or X does not matter).
> 
> How does vbetool save state?

vbetool basically calls an int10 function that saves the state.  This
function is unique per video BIOS, ie you cannot use the state file in
another machine even if the graphics chipset is the same.

> Could VGAcon do whatever vbetool is doing?
 
No it can't.  Once the card is in graphics mode, vgacon cannot go to
text mode on its own.  It has to know how to write to other VGA
registers which are unique per hardware.

Tony

