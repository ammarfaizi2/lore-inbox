Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRLDDhN>; Mon, 3 Dec 2001 22:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRLDDgE>; Mon, 3 Dec 2001 22:36:04 -0500
Received: from [209.247.255.130] ([209.247.255.130]:53146 "HELO
	raptor.alexa.com") by vger.kernel.org with SMTP id <S280592AbRLDDfT>;
	Mon, 3 Dec 2001 22:35:19 -0500
Message-ID: <A6CFEF730CCE38449F1774A6B5D62B0C031905@shockG.archive.alexa.com>
From: Guolin Cheng <Guolin@alexa.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'andre@linux-ide.org'" <andre@linux-ide.org>,
        "'adam@yggdrasil.com'" <adam@yggdrasil.com>
Subject: where is the patch  ide.2.4.14.11062001.patch, for supporting EID
	E ata133 ??
Date: Mon, 3 Dec 2001 19:34:25 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

 I tried to search the file ide.2.4.14.11062001.patch on internet, but I can
not find it, The search results on google can not help, it disappears:

 
www.jp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.14/readme.48bit.ul
tra133
The latest patch release can be found on:: http://www.linuxdiskcert.org/
ide.2.4.14.11062001.patch
Fresh Release. Regards, Linux ATA Development Linux Disk ... 
1k - Cached - Similar pages

 Another question is: anyone know whether this patch is merged into 2.4.15
and 2.4.16 versions?


 Yours sincerely,
 Guolin Cheng

 

-----Original Message-----
From: Guolin Cheng [mailto:Guolin@alexa.com]
Sent: Monday, December 03, 2001 6:00 PM
To: 'Adam J. Richter'; andre@linux-ide.org
Cc: 'linux-kernel@vger.kernel.org'
Subject: RE: Notes on ATA/133 patch (ide.2.4.14.11062001.patch)


Hi, Adam,

 Thanks a lot that you have tested Maxtor 160G drives under Linux, Could you
tell me which former version linux kernel are you using? can we use the
newest 2.4.16 downloaded from www.kernel.org?

 Do we need to check some special options in the configuration file for
version 2.4.16 to support Promise ata133 card and Maxtor 160G drive? Because
from the kernel configuration file for 2.4.16, only ata33/ata66/ata100 are
supported for Promise card. 

 The last question, do we need to manually change any files beside
downloading the former newest kernel?

 Thanks a lot. 


 Yours sincerely,
 Guolin Cheng
 

-----Original Message-----
From: Adam J. Richter [mailto:adam@yggdrasil.com]
Sent: Saturday, November 17, 2001 4:59 AM
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Notes on ATA/133 patch (ide.2.4.14.11062001.patch)


Hello Andre,

	Thank you very much for implementing the 48-bit ATA controller
support in your recent IDE kernel patches (ide.2.4.14.11062001.patch).
I am using a Maxtor 160GB hard disk with your patches on linux-2.4.15-pre5,
and it seems to be working well so far (two hours).

	I do have a couple of minor notes about your patch.  I could
generate some diffs, but they're simple and I'm not completely sure
about the right solution.

	1. Your patch creates a circular dependency between the ide-mod.o
and ide-probe-mod.o modules, which is only noticible when IDE support
is compiled as a module.  The problem is that ide.c has the
EXPORT_SYMBOL declarations for export_ide_init_queue and
export_probe_for_drive in ide-probe.c.  At the moment, I have
moved the two EXPORT_SYMBOL declarations to the ide-probe.c, but I
believe the correct solution is just to remove the two routines
from your patch, since it appears that nothing uses them yet.

	2. A while ago, I posted a change that modularizes partition
support (in reality, I never use the kernel-based partition code, but
that's another matter).  Your declaration of ide_xlate_1024_hook to
fs/partitions/msdos.c creates a circular dependency in my kernel (but
not in Linus's), which I fixed by moving the declatation to
fs/partitions/check.c.  I do not yet understand the purpose of
ide_xlate_1024 to understand whether it really is specific to the
MSDOS style of partition labeling.

	Anyhow, I hope this information is helpful.  Please let me know
if you want me to geneate a patch or test anything.  So far, your patch
seems to be working very well.  Thank you very much for developing it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
