Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRDWUYJ>; Mon, 23 Apr 2001 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRDWUX7>; Mon, 23 Apr 2001 16:23:59 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5327 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131276AbRDWUXs>;
	Mon, 23 Apr 2001 16:23:48 -0400
Message-ID: <3AE48F57.2A859328@mandrakesoft.com>
Date: Mon, 23 Apr 2001 16:23:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] some network __init code
In-Reply-To: <200104232015.WAA07001@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. What are the char* -> char array conversions of "version" strings for ?

char*="blah" generates a char pointer variable, pointing to the constant
string "blah".  char[]="blah" eliminates the char pointer variable, so
the resulting code is [slightly] smaller.


> 3. The following patch
>    - marks most of the version strings __initdata/__devinitdata (necessary
>      removing of "const" from their declaration), removes unnecessary format
>      strings from their printk()s, moves to __init/adds log level markers to
>      them (KERN_*)
>    - adds/fixes some other __init code,
>    - removes some unnecessary zero initializers
>    from most of the network drivers.

looks ok at a glance, I will probably apply it after reviewing further.

note a further cleanup is to look at each driver, and make sure (a) it
-always- printk's version if -DMODULE, and (b) if only printk's version
if hardware is found, if not -DMODULE.  You can look at pci net drivers
in 2.4.4-pre6 for an example of how I did this.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
