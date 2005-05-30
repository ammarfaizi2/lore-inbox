Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVE3Tz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVE3Tz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVE3Tz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:55:27 -0400
Received: from guru.webcon.ca ([216.194.67.26]:20910 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S261724AbVE3Txm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:53:42 -0400
Date: Mon, 30 May 2005 15:53:36 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Q: swsusp with S5 instead of S4?
In-Reply-To: <20050502214932.GA4650@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0505301540410.20347@light.int.webcon.net>
References: <20050502214932.GA4650@elf.ucw.cz>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005, Pavel Machek wrote:

>> works just fine, in terms of general computing anyways, after resume.
>>
>> However, some of the ancilary functions, such as LCD brightness, RF kill
>> switch, and volume mute button do not work after resuming.
>>
>> Figuring that some hardware parameters were not being restored, I verified
>> that by forcing a cold boot (boot up to GRUB, issue the 'halt' command to
>> power off, then power on again and let the kernel resume from swsusp),
>> everything works perfectly again just as it should because the BIOS takes
>> care of the initialisation then, which it normally skips after a
>> soft-off/S4.
>>
>> Asside from trying to figure out exactly what hardware parameteres are not
>> being saved/restored, I'm happy to let the BIOS initialise those things.
>> But, I need a way to perform a normal power-off/S5 after swsusp instead of a
>> soft-off/S4 so that I don't have to go though the double-grub-boot process
>> every time. Can this be done?
>
> echo shutdown > /sys/power/disk should do that. If it does
> not... well, see what is different in those two codepaths...

I found out that 'shutdown' is the default and that I was already using
that. Strange.

I did finally now get around to doing a more through battery of tests with
many combinations of hibernating with 'platform' and 'shutdown' modes, and
various GRUB 'halt' and 'reboot' commands. What I came up with is that
basically nothing works.

In essentially all cases (except for rare inexplicable instances when it
_does_ work, though I cannot replicate it with any consistency) the special
keys _are_ functional immediately after power-on, through GRUB, through
kernel initialization, through reading the suspended image. But then
immediately after control is passed to the resumed system, the keys stop
working.

Does this give you any other clues as to what might be going on?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
  Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
  imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
     *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
