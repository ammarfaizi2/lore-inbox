Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318942AbSH1UQt>; Wed, 28 Aug 2002 16:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSH1UQs>; Wed, 28 Aug 2002 16:16:48 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7153 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318942AbSH1UQr>; Wed, 28 Aug 2002 16:16:47 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 28 Aug 2002 14:18:41 -0600
To: walt <walt@nea-fast.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: 2.4.19 ext3 oops with file system damage - possible nfs and ext3 not playing nice together
Message-ID: <20020828201841.GY19435@clusterfs.com>
Mail-Followup-To: walt <walt@nea-fast.com>, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
References: <200208281451.12117.walt@nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208281451.12117.walt@nea-fast.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28, 2002  14:51 -0400, walt wrote:
> I ended up having to delete a mysql index file because fsck couldn't
> repair it.

Hmm, that is strange, since unless the index file was just being created
the file metadata (as opposed to the data) probably doesn't change much.
What was the error there?

> FYI  - I ran into some reproducible problems before with ext3 and possibly 
> NFS. I had a 1365344k oracle database export gzipped down to 263688k and then 
> made into an ISO image. I'd  copy the file from the file server 
> (2.4.3-SGI_XFS_1.0.1) via NFS , mount the ISO image, and burn it to CD 
> without any errors being reported. When I'd try gunzip the file from CD, I'd 
> get CRC errors. I then tried mounting the ISO image and running gunzip and 
> I'd get the same CRC errors. 

Have you tried disabling IDE DMA on this system?

> Aug 28 10:16:55 walt kernel: Unable to handle kernel paging request at virtual 
> address 01
> 38835e
> Aug 28 10:16:55 walt kernel:  printing eip:
> Aug 28 10:16:55 walt kernel: c016bbd7
> Aug 28 10:16:55 walt kernel: *pde = 00000000
> Aug 28 10:16:55 walt kernel: Oops: 0000
> Aug 28 10:16:55 walt kernel: CPU:    0
> Aug 28 10:16:55 walt kernel: EIP:    0010:[<c016bbd7>]    Not tainted
> Aug 28 10:16:55 walt kernel: EFLAGS: 00013202
> Aug 28 10:16:55 walt kernel: eax: cf967eb0   ebx: 01388346   ecx: 00000040   
> edx: 0000001
> 4
> Aug 28 10:16:55 walt kernel: esi: cf1c4eb0   edi: 8d505604   ebp: ce5df430   
> esp: cf967e8
> 4
> Aug 28 10:16:55 walt kernel: ds: 0018   es: 0018   ss: 0018
> Aug 28 10:16:55 walt kernel: Process kjournald (pid: 139, stackpage=cf967000)
> Aug 28 10:16:55 walt kernel: Stack: 00000000 00000000 00000000 00000014 
> cce1b440 cafe5220
>  000017fd 00000096
> Aug 28 10:16:55 walt kernel:        c0195a1c c12e00cc c12e5480 c38c9600 
> c38c9780 c38c9480
>  c38c96c0 c38c9540
> Aug 28 10:16:55 walt kernel:        c38c9120 c38c9a20 c38c9d20 c38c9660 
> c38c9180 c38c9c60
>  c38c9960 c38c9c00
> Aug 28 10:16:55 walt kernel: Call Trace:    [<c0195a1c>] [<c016eeb3>] 
> [<c016ece0>] [<c0107166>] [<c016ed00>]

You need to run this through ksymoops, otherwise it is just a bunch of
random numbers.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

