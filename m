Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbULCREu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbULCREu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbULCREu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:04:50 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:43502 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262397AbULCREU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:04:20 -0500
Date: Fri, 03 Dec 2004 12:04:22 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: wakeup_pmode_return jmp failing?
In-reply-to: <41B09D4B.3090906@tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41B09C96.7090207@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41B084B4.1050402@sun.com> <41B09D4B.3090906@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Davidsen wrote:
> Mike Waychison wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hello,
>>
>> Not sure who to direct this to.  I've been trying to get acpi s3 to work
>> on my pentium M laptop (tecra m2).  Without the nvidia driver loaded, I
>> can echo 3 > /proc/acpi/sleep and the machine does indeed suspend (power
>> light throbs and all).  However, when I try to wake up the thing, it
>> would flash the bios screen and throw me back to grub.
>>
>> I've been investigating the code at arch/i386/kernel/acpi/wakeup.S, and
>> have discovered that if I place a busy wait directory before the ljmpl
>> to wakeup_pmode_return, that I indeed do see 'Lin' on the screen instead
>> of the bios screen.
>>
>> The joke is, if I place a busy wait first thing after the
>> wakeup_pmode_return label, it never gets executed and I get a regular
>> boot.
>>
>> It would appear as though the jump from 16bit code into the 32bit code
>> is failing and the bios is kicking in with a regular startup.
>>
>> Anybody have any suggestions?
> 
> 
> Install a 2.4 kernel with apm enabled and use that.
> 
> That's serious, I have an IBM, Tecra, Dell, and Acer, and 5-6 friends
> running Linux on laptops. Every one (other than the Acer) works with
> "apm -s" and recovers. Some work with "apm -S". The Acer never had a 2.4
> kernel, and I haven't rebuilt with apm on 2.6 (or even looked to see if
> it was supported). All of these suspend fine with ACPI, none ever wakes up.

FWIW, my last attempts (months ago) at getting suspend to work with acpi
on 2.4 appeared to fail the same way.  That is, when I could get the
machine to boot properly with acpi enabled.

> 
> Is suspend even supposed to be generally functional? I thought it was a
> WIP not expected to work except on certain models which have been hand
> tuned by the developers. In fact I have a message somewhere saying you
> have to get out of X to a text console, manually shutdown the network,
> and then it might work. Then start everything up again.
> 

Well, I'm doing this with no X, no network, no usb.  Like I said, it
appears to suspend fine, but fails in the early wakeup code.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBsJyWdQs4kOxk3/MRAvm0AKCaMgXg5KZDi6h8bOjWlwml+HlzlQCfRjzV
1rLlgYtJ4dY4e3N1EsQmOsg=
=qtoe
-----END PGP SIGNATURE-----
