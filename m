Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUCUNrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263651AbUCUNrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:47:22 -0500
Received: from pop.gmx.net ([213.165.64.20]:55448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263646AbUCUNrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:47:20 -0500
X-Authenticated: #7370606
Message-ID: <405D9CDA.6070107@gmx.at>
Date: Sun, 21 Mar 2004 14:47:06 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com>
In-Reply-To: <20040321074711.GA13232@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
> 
>>Jeff Garzik wrote:
>>
>>
>>>So go ahead, and I'll lend you as much help as I can.  I have the full 
>>>Promise RAID docs, and it seems like another guy on the lists has full 
>>>Silicon Image "medley" RAID docs...

I am the only one without docs? Oh, Crap!

>>
>>If these "soft" RAID implementations only support RAID-0/1/0+1/1+0, is 
>>there really any need for a new DM target? Wouldn't you just need a 
>>userspace tool to recognize the array and do the "dmsetup" operations to 
>>make it usable?
> 
> 
> the later.

Why not join my evms-plugin work? This has 4 advantages over the 
"stand-alone binary" approach:

1. its all within evms
There is no need for additional tools required to setup the volume 
(thinking about installers and initrd...).

2. evms comes with partition handling.
Otherwise someone has to write another tool/library that does the 
partition setup.

3. it works for 2.6 and (patched) 2.4 kernels

4. nice clickety-click user interface
Especially useful for lazy people like me. ;)

My plugin has to be a bit redesigned to allow easier integration of 
support code for other controllers. What is required is basically to 
split the plugin in a common and a per-controller module. No big deal. 
Or we can make a new plugin for every controller...

see: http://marc.theaimsgroup.com/?l=evms-devel&m=107936928618685&w=2

Apropos: If we do evms plugins then we might want to have the 
possibility to detect if some ataraid module aleady has picked up the 
disk. In this case we should not create a volume because of someone 
might try to mount the same volume via the ataraid and evms devicefiles 
which leads to filesystem corruption. I thought about makeing a /proc 
ataraid entry that contains the claimed disks. I think this should be 
supported by all ataraid modules if this is done so I am asking you: 
What do you think?

Regards,
Wilfried
