Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTDVWmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTDVWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:42:18 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:17343 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S263884AbTDVWmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:42:14 -0400
Message-ID: <3EA5C816.2060303@acm.org>
Date: Tue, 22 Apr 2003 17:54:14 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <3EA4B038.7000509@acm.org> <Pine.LNX.4.53L.0304221848240.1726@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0304221848240.1726@freak.distro.conectiva>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure.

The changes are:

    * Move poll_wait() outside a spinlock, since it can sleep
    * Modify the state machine to restart the timer immediately on
      starting a new message.  Firmware updates went down from 30
      minutes to 5.
    * Allocate a the main KCS state machine variable the right size (it
      was too big).
    * Fix recovery from the HOSED state machine state so that the driver
      will recover properly if the IPMI controller fails temporarily.
    * Call some spinlocks with "unsigned long flags" instead of "int flags".
    * Add buffer leak checking.
    * Fix the handling of watchdog conditions, they were incorrect in
      many cases.
    * Fix the watchdog so the first write starts it, not the second write.
    * Fix the watchdog so pretimeouts are handled properly and don't
      necessarily result in a reset.
    * Add some missing symbol exports that the watchdog code needs.

Almost all of these are bug fixes, with the exception of the buffer leak
checking, and possibly the immediate timer restart.

-Corey

Marcelo Tosatti wrote:

>On Mon, 21 Apr 2003, Corey Minyard wrote:
>
>  
>
>>The attached patch brings the IPMI driver in 2.4.21-rc1 up to the most
>>current version.
>>
>>-Corey
>>
>>Marcelo Tosatti wrote:
>>
>>    
>>
>>>Here goes the first candidate for 2.4.21.
>>>
>>>Please test it extensively.
>>>      
>>>
>
>Corey,
>
>Could you please describe the fixes ?
>
>We're at -rc stage already, so I want to apply critical fixes only.
>  
>


