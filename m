Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRAZRKm>; Fri, 26 Jan 2001 12:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbRAZRKX>; Fri, 26 Jan 2001 12:10:23 -0500
Received: from smart.visp-europe.psi.com ([212.222.105.5]:58522 "EHLO
	smart.visp-europe.psi.com") by vger.kernel.org with ESMTP
	id <S131246AbRAZRKR>; Fri, 26 Jan 2001 12:10:17 -0500
Message-ID: <01C087C3.20151940.nicog@snafu.de>
From: Nicolas GOUTTE <nicog@snafu.de>
To: "'holindho@mail.niksula.cs.hut.fi'" <holindho@mail.niksula.cs.hut.fi>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: fat32 corruption with 2.4.0
Date: Fri, 26 Jan 2001 18:08:19 +0100
X-Mailer: Microsoft Internet E-Mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me! Thank you in advance!

I don't know if I can help you but who knows!
I am running Windows 95 without problems beside Linux, so my knowledge could
be not the right one for your problem!

1. Codepages
What is the code page used in Finnland by Windows 98 (surely not the American one: 437)?
Do you have this code page explicitly in your mounting options for Linux?
(For example for Westen Europe: codepage=850)
I don't know if Windows 98 can mess up file names coded with wrong code pages.
Don't forget to compile the needed NLS codepage in Linux!

2. Linux 2.4.0-test9
In old versions, they were three bugs for VFAT.
One was that Windows 9x did not like the short file name created for a long name.
I do remember that it was fixed but I do not remember in which version. The bug was without
real consequences, as Windows's SCANDISK could correct the short name without problem.
The second one was that file names with less than twelve characters were treated as 8+3 short
files if their first character was lower case. This has been fixed in test12 final or in 2.4.0 final
(sorry, I can't remember which one it was)!
The third is the "truncate problem". There is a security since Linux 2.4.0, so it does not trigger.
The -ac tree has a correct fix for it (need also for NTFS).

If your problem with test9 is an other one, then it may be still in the current VFAT code!

3. Different Disk Geometries
It seems that lately there are many complaints of Windows 98 or ME eating up VFAT partitions,
because Windows recognised another disk geometry than Linux. Have you checked these messages? 

4. Modules or in kernel?
My good experience is also perhaps due that all FAT/VFAT/NLS stuff is compiled as modules.
May be you should also try to compile the floppy driver as module (or in kernel if it's already a module)!
Do you use DEVFS? I personnaly do not!

May my ideas help you!

--- Original Message ---
>Hello, 
>I haven't seen much vfat/fat32 complaints lately, so: 
>2.4.0 destroyed my windows partition. There seemed to be some trouble in 
>2.4.0-test9, too. I don't know if this was a known problem or not, but 
>2.4.0-test9 wrote filenames in a wrong way. It could be observed by 
>running windows (98 in my case) file system checker (not scandisk, but the 
>graphical one) after copying some files with non-8.3 names to a fat32 
>partition. There was no noticable data loss, however. 
>
>Yesterday, with 2.4.0 release kernel, mounting a fat32 filesystem caused 
>data loss. The filesystem seemed to mount ok at a first glance, but 
>reported falsely 100% space usage. Then, after unmounting it, the oldest 
>(probably at start of the partition) directories "windows" and "my 
>documents" were mangled beyond recognition. I think, in this case, the 
>filenames got written REALLY wrong and showed as something like 
>"? * ~ ?. ? ?". Running scandisk caused most directories and files 
>in root directory to change to FILE0xxx.CHK and DIR0xxx.CHK. Most of the 
>data was intact, however - and subdirectories below DIR0xxx.CHK's were 
>good, too. I had VIA (868B) UDMA enabled, but don't think that was the 
>cause since it worked fine with ext2 partitions. 
>
>In addition, trying to write to vfat /floppy with 2.4.0 also didn't 
>work. Kernel complained about (bad?) sectors. Whereas 2.2.0 did the job 
>fine (obviously, to the same floppy). 
>
>-- Heikki Lindholm 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
