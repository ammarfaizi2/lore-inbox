Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUDQRgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 13:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUDQRf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 13:35:58 -0400
Received: from imap.gmx.net ([213.165.64.20]:55435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262969AbUDQRfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 13:35:45 -0400
X-Authenticated: #21910825
Message-ID: <40816AEC.6020309@gmx.net>
Date: Sat, 17 Apr 2004 19:35:40 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com,
       linux-hotplug-devel@lists.sourceforge.net,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Greg KH <greg@kroah.com>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>,
       Martins Krikis <mkrikis@yahoo.com>, ataraid-list@redhat.com,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] [DRAFT] [udev PATCH] First attempt at vendor RAID support
 in 2.6
References: <Pine.LNX.4.40.0404151458450.30892-100000@jehova.dsm.dk> <40803C61.503@gmx.net>
In-Reply-To: <40803C61.503@gmx.net>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[crossposting this to hopefully relevant lists]
Hi,

since on one side ATARAID support has vanished from 2.6 and on the other
side some parties are pushing for an enhanced MD driver in the kernel, why
 don't we do the setup and metadata handling of all those types of RAID in
userspace?

I got positive feedback by private mail from several kernel developers for
the last incarnations of raiddetect, so if you disagree, speak up now.

Raiddetect is a program to find vendor software RAID superblocks, analyze
them for validity, group them by RAID vendor and (later on) set them up
via MD/DM. It is small (~35kB compiled statically against klibc) and
designed to be run from initrd/initramfs.

raiddetect now supports the following metadata formats:
-Promise RAID
-Highpoint RAID
-Medley RAID
-Intel RAID

If you want support for another metadata format, please tell me which and
I'll try to add it. Patches are preferred ;-) My current wishlist is:
- Adaptec ASR HostRAID
- DDF RAID

Hot-add and hot-remove features can be added easily if raiddetect is
called by an udev rule on block device removal/insertion. If raiddetect
stays loaded into memory or is allowed to save its state, hotplug events
will not trigger any access to devices not related to that particular RAID
array.

It seems that there are some host adapter drivers out there implementing
their own RAID engine which could be consolidated into a single RAID
"library" instead. If you know about such drivers, please speak up.

The following issues remain still to be sorted out:

Carl-Daniel Hailfinger wrote:

> Greg: Would you accept this patch into your udev package?
> 
> Thomas Horsten wrote:
> 
>>On Thu, 15 Apr 2004, Carl-Daniel Hailfinger wrote:
>>
>>
>>>What I need:
>>>- Criticism of coding style/ missing abstraction
> 
> 
> I got a mail from Barlomiej Zolnierkiewicz where he suggested to split the
> vendor dependent code out of raiddetect.c. This will happen in one of the
> next revisions.

This is on hold until I receive feedback from Greg K-H whether this will
be accepted into udev or not.


>>>- People checking the numerous FIXMEs
> 
> 
> I now have the following FIXMEs (aka "I have no idea about it"):
> - 5 FIXMEs in the Medley RAID code. Thomas, could you comment once you're
> back?
> - 3 FIXMEs in the Highpoint RAID code. Wilfried, could you please take a
> look at them?
> - 2 FIXMEs in the Promise RAID code. I will work on those myself.
> 
> - some generic FIXMEs:
>   - Is the sector size of a harddisk always 512 bytes?
>   - Is /sys/block/*/size always in 512-byte units?
>   - Are there controllers out there which occupy more than one PCI device?
>   - How can I find out if a block device under /sys/block is a disk?

Do you have an idea about the generic FIXMEs listed above?


>>>- Help with sorting out who owns which copyrights
> 
> This is still a _big issue_.

Since the patch is already too big (~42kB) for some mailing lists, please
get the latest version from
http://www.hailfinger.org/carldani/linux/patches/raiddetect/

The patch is against the latest udev bitkeeper tree and applies fine to
udev-024 if you prefer working with officially released versions.


Regards,
Carl-Daniel

