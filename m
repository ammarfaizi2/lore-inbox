Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVEIRhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVEIRhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVEIRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:37:20 -0400
Received: from [195.23.16.24] ([195.23.16.24]:4249 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261452AbVEIRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:37:04 -0400
Message-ID: <427F9FA2.30506@grupopie.com>
Date: Mon, 09 May 2005 18:36:34 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc4: IRQ14 nobody cared
References: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>	 <427F6F00.9030305@grupopie.com> <58cb370e050509074352e98f6a@mail.gmail.com>
In-Reply-To: <58cb370e050509074352e98f6a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 5/9/05, Paulo Marques <pmarques@grupopie.com> wrote:
>>[...]
>>
>>2.6.12-rc4 halts during boot with a "IRQ 14: nobody cared" message.
>>
>>2.6.12-rc3 boots (and works) fine with the same configuration.
>>
>>[...]
> 
> Perhaps you can try first -rc3 git snapshot (still a lot of stuff):
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc3-git1.bz2

I tried this version with the same results.

It seems that I've got something weird in my compilation setup.

I set up a serial console to see the messages from boot and near the 
beggining I get:

"Unknown bustype PCI    - ignoring"

The code that generates this is at arch/i386/mpparse.c:

> 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI)-1) == 0) {
> 		...
> 	} else if (strncmp(str, BUSTYPE_MCA, sizeof(BUSTYPE_MCA)-1) == 0) {
 >		...
> 	} else {
> 		printk(KERN_WARNING "Unknown bustype %s - ignoring\n", str);
> 	}

BUSTYPE_PCI is defined at include/asm-i386/mpspec_def.h:

#define BUSTYPE_PCI	"PCI"

so that first "if" statement translates to

 > 	} else if (strncmp(str, "PCI", 3) == 0) {

which should be always valid for "PCI   ", and that message should never 
appear :(

Well, sorry about the noise, I must dig deeper now...

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
