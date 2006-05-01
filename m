Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWEAPAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWEAPAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWEAPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:00:55 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:63250 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932127AbWEAPAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:00:54 -0400
Message-ID: <445622B5.9030006@gmail.com>
Date: Mon, 01 May 2006 17:00:46 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr> <20060501141901.GA7267@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0605011042450.20917@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605011042450.20917@chaos.analogic.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
X-Notice: Fixed RFC822 violation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

linux-os (Dick Johnson) napsal(a):
> On Mon, 1 May 2006, Alexey Dobriyan wrote:
> 
>> On Mon, May 01, 2006 at 04:00:09PM +0200, Jan Engelhardt wrote:
>>>> +Please don't use things like "vps_t".
>>>> +It's a _mistake_ to use typedef for structures and pointers. When you see a
>>>> +	vps_t a;
>>>> +in the source, what does it mean?
>>>> +In contrast, if it says
>>>> +	struct virtual_container *a;
>>>> +you can actually tell what "a" is.
>>>> +
>>>> +Lots of people think that typedefs "help readability". Not so. They are
>>>> +useful only for:
>>> [...]
>>>
>>> What about task_t vs struct task_struct? Both are used in the kernel.
>> task_t			=> struct task
>> struct task_struct	=> struct task
>>
>> Roughly 2765 hits :-\
> 
> Yes, also 'current' is probably the most used. Any, since this
> has become a FAQ, maybe it's about time to put something in the
> Documentation?
> 
> --- /usr/src/linux-2.6.16.4/Documentation/CodingStyle.orig	2006-05-01 10:17:03.000000000 -0400
> +++ /usr/src/linux-2.6.16.4/Documentation/CodingStyle	2006-05-01 10:37:09.000000000 -0400
> @@ -343,6 +343,33 @@
>   Remember: if another thread can find your data structure, and you don't
>   have a reference count on it, you almost certainly have a bug.
> 
> +	typedefs and and structs
> +
> +Typedefs should never be used for information hiding. In other words,
> +if a typedef defines an aggregate type, and the individual components
> +are accessed anywhere in the code, a typedef should not be used.
> +
> +An example of proper usage:
> +typedef struct opaque_type FILE;	// In a header
> +
> +	FILE *fp;			// In a program block
> +
> +The type 'FILE' in this example is something that was defined in
> +a 'C' runtime library. The code uses pointers to this opaque type,
> +but never even knows, and doesn't care, what's inside that structure.
> +Therefore, FILE can have been defined using a typedef.
> +
> +An example of incorrect usage:
> +
> +typedef struct file_operations FO;	// In a header
> +
> +	FO	fo;			// In a program block
> +	memset(&foo, 0x00, sizeof(foo));
> +
> +In this case, object FO contains structure members that will be
> +accessed by the code. It should not have been defined. Instead,
> +the structure name should have been used directly.
> +
> 
>   		Chapter 11: Macros, Enums and RTL
> 
> 
> 
> In case the M$ server mangles the patch, it's included as an attachment.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
> New book: http://www.lymanschool.com
> _
> 
> 
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 
> 
> ------------------------------------------------------------------------
> 
> --- /usr/src/linux-2.6.16.4/Documentation/CodingStyle.orig	2006-05-01 10:17:03.000000000 -0400
> +++ /usr/src/linux-2.6.16.4/Documentation/CodingStyle	2006-05-01 10:37:09.000000000 -0400
> @@ -343,6 +343,33 @@
>  Remember: if another thread can find your data structure, and you don't
>  have a reference count on it, you almost certainly have a bug.
>  
> +	typedefs and and structs
> +
> +Typedefs should never be used for information hiding. In other words,
> +if a typedef defines an aggregate type, and the individual components
> +are accessed anywhere in the code, a typedef should not be used.
> +
> +An example of proper usage:
> +typedef struct opaque_type FILE;	// In a header
> +
> +	FILE *fp;			// In a program block
> +
> +The type 'FILE' in this example is something that was defined in
> +a 'C' runtime library. The code uses pointers to this opaque type,
> +but never even knows, and doesn't care, what's inside that structure.
> +Therefore, FILE can have been defined using a typedef.
> +
> +An example of incorrect usage:
> +
> +typedef struct file_operations FO;	// In a header
> +
> +	FO	fo;			// In a program block
You meant 'FO foo', didn't you?
> +	memset(&foo, 0x00, sizeof(foo));
> +
> +In this case, object FO contains structure members that will be
> +accessed by the code. It should not have been defined. Instead,
> +the structure name should have been used directly.
> +
>  
>  		Chapter 11: Macros, Enums and RTL
>  

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEViK1MsxVwznUen4RAi8wAJ9km1HybAI8qRUR5IY9y52+LDHdogCfSy4O
ENhfqjTKF/+zdyjmuV7wXws=
=yZTA
-----END PGP SIGNATURE-----
