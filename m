Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUEAQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUEAQbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUEAQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:31:17 -0400
Received: from pop.gmx.de ([213.165.64.20]:55760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261156AbUEAQbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 12:31:14 -0400
X-Authenticated: #7370606
Message-ID: <4093D0C8.5010905@gmx.at>
Date: Sat, 01 May 2004 18:31:04 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Thomas Horsten <thomas@horsten.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       medley@lists.infowares.com, linux-hotplug-devel@lists.sourceforge.net,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC] [DRAFT] [udev PATCH] First attempt at vendor RAID support
 in 2.6
References: <Pine.LNX.4.40.0404151458450.30892-100000@jehova.dsm.dk> <40803C61.503@gmx.net>
In-Reply-To: <40803C61.503@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just returned from my vacation and checked my emails. That's why the 
response is so late.

Carl-Daniel Hailfinger wrote:
>>>- People checking the numerous FIXMEs
> 
> 
> I now have the following FIXMEs (aka "I have no idea about it"):
> - 5 FIXMEs in the Medley RAID code. Thomas, could you comment once you're
> back?
> - 3 FIXMEs in the Highpoint RAID code. Wilfried, could you please take a
> look at them?

1) FIXME: Does "no array defined" correspond to HPT_T_SINGLEDISK?
I have to check this but I believe it is so.

2) FIXME: Is HPT_T_RAID_01_RAID_1 a value that can ever be found?
I think this is the new style raid-10 format that is supported by hpt374 
and upwards. I do not have such a controller so I cannot verify this.

3) FIXME: what does HPT_MAGIC_BAD mean?
You get this if you pull one disk out of a raid-0 array for example. The 
HPT-BIOS detects that the raid is not operational and marks the array as 
bad (writes the HPT_MAGIC_BAD to the remaining disks).

[snip]

>>>- More data about Medley/Highpoint vendor superblocks (can I check for
>>>bogus values?)
> 
> 
> Wilfried, is there any consistency check I can add for Highpoint?

I have not found any crc or so. But since HPT marks any disks that is 
not in an array as HPT_T_SINGLEDISK or HPT_MAGIC_BAD we should be fine 
unless someone writes some garbage to the superblock.

> 
> 
> 
>>>- Help with sorting out who owns which copyrights
> 
> 
> This is still a _big issue_.

The HPT copyrights look fine.

I am looking forward to see the part that writes the dm configuration so 
that I can integrate it into the evms plugin.

bye,
wilfried

PS: add_disk_to_raidlists() does never return retval!
