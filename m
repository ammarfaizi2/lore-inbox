Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRAaCew>; Tue, 30 Jan 2001 21:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRAaCen>; Tue, 30 Jan 2001 21:34:43 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:43561 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129235AbRAaCef>;
	Tue, 30 Jan 2001 21:34:35 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol in 2.4.1 depmod. 
In-Reply-To: Your message of "Tue, 30 Jan 2001 18:27:40 CDT."
             <20010130182740.A10610@jhereg.dmeyer.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 13:34:16 +1100
Message-ID: <30322.980908456@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 18:27:40 -0500, 
dmeyer@dmeyer.net wrote:
>In article <4924.980894540@ocs3.ocs-net> you write:
>> On Tue, 30 Jan 2001 14:15:20 -0600 (CST), 
>> Jason Michaelson <micha044@tc.umn.edu> wrote:
>> >Greetings. I've just procured myself a copy of 2.4.1, and tried to build
>> >it. At the tail end of a make modules_install, the following error occurs:
>> >
>> >depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/drivers/md/md.o
>> >depmod:         name_to_kdev_t
>> 
>> name_to_kdev_t is defined in init/main.c.  It is not exported so it
>> cannot be called from modules.  name_to_kdev_t *cannot* be exported
>> because it is defined as __init, the code has gone by the time the
>> module is loaded.  Ask the md maintainer for a fix.
>
>How did this used to work, then?  The call to name_to_kdev_t has been
>in the md code since (according to the code comments) May, 2000; the
>module worked fine as of 2.4.1-pre10, which is the last version I used.

It might have worked as built in code, I would be astounded if it ever
worked as a module on a standard kernel after that code was added.
name_to_kdev_t has been defined as this since at least 2.4.0-test1.

kdev_t __init name_to_kdev_t(char *line)

You cannot export a symbol marked __init and expect it to work.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
