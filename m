Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbULGDji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbULGDji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbULGDji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:39:38 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:24986 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261750AbULGDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:39:35 -0500
Date: Mon, 06 Dec 2004 22:39:30 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: wakeup_pmode_return jmp failing?
In-reply-to: <20041206133455.GA1213@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Message-id: <41B525F2.7090409@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41B084B4.1050402@sun.com> <20041206133455.GA1213@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
> 
> 
>>Not sure who to direct this to.  I've been trying to get acpi s3 to work
>>on my pentium M laptop (tecra m2).  Without the nvidia driver loaded, I
>>can echo 3 > /proc/acpi/sleep and the machine does indeed suspend (power
>>light throbs and all).  However, when I try to wake up the thing, it
>>would flash the bios screen and throw me back to grub.
>>
>>I've been investigating the code at arch/i386/kernel/acpi/wakeup.S, and
>>have discovered that if I place a busy wait directory before the ljmpl
>>to wakeup_pmode_return, that I indeed do see 'Lin' on the screen instead
>>of the bios screen.
>>
>>The joke is, if I place a busy wait first thing after the
>>wakeup_pmode_return label, it never gets executed and I get a regular boot.
>>
>>It would appear as though the jump from 16bit code into the 32bit code
>>is failing and the bios is kicking in with a regular startup.
> 
> 
> See archives of linux-acpi lists.
> 								Pavel

FYI, Hiro's patch that copies the GDT to the resume page did the trick:

http://marc.theaimsgroup.com/?l=acpi4linux&m=109813262218004&w=2

Thanks,

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

iD8DBQFBtSXydQs4kOxk3/MRAlYIAJ9iDnQArL4Bo+GQYCPGrxM8bU36bwCdEhjD
LcoeEeWMkWcNynBARz/nKsU=
=Zcxz
-----END PGP SIGNATURE-----
