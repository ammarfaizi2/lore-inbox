Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVEOQnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEOQnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVEOQnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:43:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5271 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261675AbVEOQnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:43:20 -0400
Message-ID: <42877C1B.2030008@pobox.com>
Date: Sun, 15 May 2005 12:43:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
CC: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Disk write cache
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>	<200505151121.36243.gene.heskett@verizon.net>	<20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenichi Okuyama wrote:
>>>>>>"Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
> Jeff> On Sun, May 15, 2005 at 11:21:36AM -0400, Gene Heskett wrote:
> 
>>>On Sunday 15 May 2005 11:00, Mikulas Patocka wrote:
>>>
>>>>On Sun, 15 May 2005, Tomasz Torcz wrote:
>>>>
>>>>>On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
>>>>>
>>>>>>>>>However they've patched the FreeBSD kernel to
>>>>>>>>>"workaround?" it:
>>>>>>>>>ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/ht
>>>>>>>>>t5.patch
>>>>>>>>
>>>>>>>>That's a similar stupid idea as they did with the disk write
>>>>>>>>cache (lowering the MTBFs of their disks by considerable
>>>>>>>>factors, which is much worse than the power off data loss
>>>>>>>>problem) Let's not go down this path please.
>>>>>>>
>>>>>>>What wrong did they do with disk write cache?
>>>>>>
>>>>>>They turned it off by default, which according to disk vendors
>>>>>>lowers the MTBF of your disk to a fraction of the original
>>>>>>value.
>>>>>>
>>>>>>I bet the total amount of valuable data lost for FreeBSD users
>>>>>>because of broken disks is much much bigger than what they
>>>>>>gained from not losing in the rather hard to hit power off
>>>>>>cases.
>>>>>
>>>>> Aren't I/O barriers a way to safely use write cache?
>>>>
>>>>FreeBSD used these barriers (FLUSH CACHE command) long time ago.
>>>>
>>>>There are rumors that some disks ignore FLUSH CACHE command just to
>>>>get higher benchmarks in Windows. But I haven't heart of any proof.
>>>>Does anybody know, what companies fake this command?
>>>>
>>>
>>>>From a story I read elsewhere just a few days ago, this problem is 
>>>virtually universal even in the umpty-bucks 15,000 rpm scsi server 
>>>drives.  It appears that this is just another way to crank up the 
>>>numbers and make each drive seem faster than its competition.
>>>
>>>My gut feeling is that if this gets enough ink to get under the drive 
>>>makers skins, we will see the issuance of a utility from the makers 
>>>that will re-program the drives therefore enabling the proper 
>>>handling of the FLUSH CACHE command.  This would be an excellent 
>>>chance IMO, to make a bit of noise if the utility comes out, but only 
>>>runs on windows.  In that event, we hold their feet to the fire (the 
>>>prefereable method), or a wrapper is written that allows it to run on 
>>>any os with a bash-like shell manager.
> 
> 
> 
> Jeff> There is a large amount of yammering and speculation in this thread.
> 
> Jeff> Most disks do seem to obey SYNC CACHE / FLUSH CACHE.
> 
> 
> Then it must be file system who's not controlling properly.  And
> because this is so widely spread among Linux, there must be at least
> one bug existing in VFS ( or there was, and everyone copied it ).
> 
> At least, from:
> 
> 	http://developer.osdl.jp/projects/doubt/
> 
> there is project name "diskio" which does black box test about this:
> 
> 	http://developer.osdl.jp/projects/doubt/diskio/index.html
> 
> And if we assume for Read after Write access semantics of HDD for
> "SURELY" checking the data image on disk surface ( by HDD, I mean ),
> on both SCSI and ATA, ALL the file system does not pass the test.
> 
> And I was wondering who's bad. File system? Device driver of both
> SCSI and ATA? or criterion? From Jeff's point, it seems like file
> system or criterion...

The ability of a filesystem or fsync(2) to cause a [FLUSH|SYNC] CACHE 
command to be generated has only been present in the most recent 2.6.x 
kernels.  See the "write barrier" stuff that people have been discussing.

Furthermore, read-after-write implies nothing at all.  The only way to 
you can be assured that your data has "hit the platter" is
(1) issuing [FLUSH|SYNC] CACHE, or
(2) using FUA-style disk commands

It sounds like your test (or reasoning) is invalid.

	Jeff



