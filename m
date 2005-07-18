Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVGRUFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVGRUFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGRUFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:05:15 -0400
Received: from ns.solnet.cz ([193.165.198.50]:55254 "EHLO solnet.cz")
	by vger.kernel.org with ESMTP id S261590AbVGRUFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:05:00 -0400
X-AntiVirus: scanned for viruses by soLNet AVirCheck 2.0.29 (http://www.solnet.cz/avircheck)
Message-ID: <42DC0A99.2010304@solnet.cz>
Date: Mon, 18 Jul 2005 22:01:29 +0200
From: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Organization: soLNet, s.r.o.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise TX4200 support?
References: <42DBFC9E.1040607@gentoo.org>
In-Reply-To: <42DBFC9E.1040607@gentoo.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi,
> 
> I recieved an email from someone claiming to be stuck with Linux 2.4,
> due to relying on a Promise TX4200 disk controller (using the fdsata
> driver from promise's website, which is 2.4-only):
> 
> 0000:01:09.0 RAID bus controller: Promise Technology, Inc.: Unknown
> device 3519 (rev 02)
>         Subsystem: Promise Technology, Inc.: Unknown device 3519
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 9
>         I/O ports at dc00 [size=128]
>         I/O ports at d800 [size=256]
>         Memory at ff8ff000 (32-bit, non-prefetchable) [size=4K]
>         Memory at ff8c0000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at ff8e0000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 2
> 
> What is the status of this on 2.6? I found a blank changeset (??) in the
> mail below, from 24th May:
> 
> Jeff Garzik wrote:
>> Please pull the 'new-ids' branch from
>>
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> This add new PCI ids to some SATA drivers.
> <snip>
>> commit 37c15447c565ab458ee3778e198d08f4041caa99
>> tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
>> parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
>> author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005
> 02:41:00 -0400
>> committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 -0400
>>
>> [PATCH] sata_promise: new PCI ID for TX4200
>>
>> [note - blank changeset]
>>
> 
> Was this accidently removed, or is the sata_promise driver actually
> incompatible with this hardware?
> 

We are succesfully running patched sata_promise with 3 disks in a
raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
package.)

# check_partitions
disk: [8.0] => '/dev/sda', 279.4 GB
         1 : /dev/sda1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sda2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sda3 : Linux swap                (     486 MB)
disk: [8.16] => '/dev/sdb', 279.4 GB
         1 : /dev/sdb1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sdb2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sdb3 : Linux swap                (     486 MB)
disk: [8.32] => '/dev/sdc', 279.4 GB
         1 : /dev/sdc1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sdc2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sdc3 : Linux swap                (     486 MB)
disk: [9.0] => '/dev/md',
         0 : /dev/md0  : raid1                     (      55 MB)
                uuid: db3bdcf4:3e4774c7:b2541959:eeef67e0
                0 active sync   /dev/sda1
                1 active sync   /dev/sdb1
                2 active sync   /dev/sdc1
         1 : /dev/md1  : raid5                     (  571280 MB)
                uuid: b9562e24:8a095e31:40702712:19009a40
                0 active sync   /dev/sda2
                1 active sync   /dev/sdb2
                2 active sync   /dev/sdc2

'lspci -v' says:

02:02.0 RAID bus controller: Promise Technology, Inc.: Unknown device
3519 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3519
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        I/O ports at dc00 [size=128]
        I/O ports at d800 [size=256]
        Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at feae0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2

No problems at all.

Regards,

-- 
Mgr. Martin Povolný, soLNet, s.r.o.,
+420777714458, martin.povolny@solnet.cz

