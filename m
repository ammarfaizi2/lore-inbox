Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSEGN5Y>; Tue, 7 May 2002 09:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEGN5X>; Tue, 7 May 2002 09:57:23 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:11310 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315449AbSEGN5U>; Tue, 7 May 2002 09:57:20 -0400
Message-Id: <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 May 2002 14:57:46 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.14 IDE 57
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD7C9F1.2000407@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:34 07/05/02, Martin Dalecki wrote:
>Uz.ytkownik Anton Altaparmakov napisa?:
>>At 12:27 07/05/02, Martin Dalecki wrote:
>>>Tue May  7 02:37:49 CEST 2002 ide-clean-57
>>>
>>>Nuke /proc/ide. For explanations why, please see the frustrated comments 
>>>in the previous change log.
>>
>>This is a big mistake IMO.
>>Nuking the ability to change settings, fair enough, but only if 
>>alternative interface is provided for userspace to tweak everything, 
>>otherwise provide the interface before you remove the existing one. 
>>(There may be already another interface, I don't know...I am sure someone 
>>will tell me if there is!)
>
>Ehmm... There *is* one interface there. hdparm will help
>you. Note: the upcomming release of hdparm should contain the
>following patch which incearses it's usability vastly to the
>average user. Just for convenience I'm attaching it here.

How do I get this information with hdparm please?

[aia21@drop ide]$ cat via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA      UDMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          20ns     600ns     120ns      60ns
Transfer Rate:   99.9MB/s   3.3MB/s  16.6MB/s  33.3MB/s

hdparm is a tool to query a device and how the controller is programmed to 
talk to the device. But it is not designed nor capable of giving 
information about the host itself. I just read the man page for hdparm and 
there are no options in sight to show any of the things I have shown above.

Also the below work as normal user but hdparm requires super user... It is 
debateable whether a normal user should be allowed access but still you are 
taking away existing functionality...

[aia21@drop hda]$ cat cache
1916
[aia21@drop hda]$ cat capacity
80418240
[aia21@drop hda]$ cat geometry
physical     79780/16/63
logical      5005/255/63

And hdparm never gives you the physical geometry AFAICS.

Either I am missing something or you are removing a lot of functionality 
and replacing it with nothingness...

And as I said, I can understand removing the ability to write values into 
/proc/ide/*, what I disagree with is the removal of the information 
provided by read-only access to /proc/ide/*. And that is because I am not 
aware of any other way to get the same information.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

