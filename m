Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTAZN5Z>; Sun, 26 Jan 2003 08:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTAZN5Y>; Sun, 26 Jan 2003 08:57:24 -0500
Received: from [193.137.96.140] ([193.137.96.140]:706 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id <S266907AbTAZN5X>;
	Sun, 26 Jan 2003 08:57:23 -0500
Message-ID: <3E33E9DB.2070604@alvie.com>
Date: Sun, 26 Jan 2003 13:59:55 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] 2.5.58 hangs at boot
References: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com> <3E300BCE.9080909@alvie.com>
In-Reply-To: <3E300BCE.9080909@alvie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This repeats 'ad infinitum'. Didn't wait for more than a few minutes, 
> but it looks like it will.
>
> The interrupts are handled at acpi_ev_gpe_detect (), which returns 1. 
> At this point in_irq() returns 0x00010000 (or 0x00001000, don't have a 
> serial console :/)
>
I have done some debugging, and here are the not-so-exciting results:

GPE08 is dispatched. My debug shows something like this:

* Is a control method
* Method at AML address d08047a4 length 39D
* Begin method parse Entry=cff43904 obj=cff4238c
* State=cff4ec00
* Completed one call  to walk loop, AE_OK, state=cff4ec00
* Parser exiting, status AE_OK
* Begin method execution Entry=cff43904 obj=cff4238c
* State=cff4ec00
* Completed one call to walk loop, AE_CTRL_TRANSFER State=cff4ec00
* Execute Method 00000000, current state cff4ec00
* State=cff4e800
* Completed one call to walk loop, AE_OK, State=cff4e800
* Parser exiting, status AE_OK
* Starting nested execution, newstate=cff4e800
* Completed one call to walk loop, AE_OK, state=cff4e800
* Completed one call to walk loop, AE_OK, state=cff4ec00
* Parser exiting, status AE_OK

And keeps doing this every time GPE08 is enabled.

Any ideas ? Right now I have disabled the GPE and can trigger an enable 
via /proc, so if you need more info, please tell me.

The hex dump at 0xd08047a4 + 1 shows something like:

5c 2f 04 5f 53 42 5f 50 43 49 30 50 43 49 42 42 52 47 42 60 79 60 0a 18 
60 0c 0b b1 20 00 60 70 0a af
5c 2f 03 5f 53 42 5f 4d 45 4d 5f 49 45 44 49 53 4d 42 52 0b 00 ff 60 0a 
00 0a 00 0a b2 a2 4b 35 91
5c 2f 03 5f 53 42 5f 4d 45 4d 5f 47 50 35 30 91
....

And now a stupid question: on the second line I believe it reads as 
"Root" "Multiname" "3 Segments", but it looks like it has 4 
(_SB_.MEM_.IEDI.SMBR). Is this correct ?

-- 

Álvaro Lopes 
---------------------
A .sig is just a .sig


