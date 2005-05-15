Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVEOQaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVEOQaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEOQaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:30:14 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:30686 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262832AbVEOQ3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:29:41 -0400
Date: Mon, 16 May 2005 01:27:40 +0900 (JST)
Message-Id: <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
To: jgarzik@pobox.com
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Disk write cache
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20050515152956.GA25143@havoc.gtf.org>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	<200505151121.36243.gene.heskett@verizon.net>
	<20050515152956.GA25143@havoc.gtf.org>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> On Sun, May 15, 2005 at 11:21:36AM -0400, Gene Heskett wrote:
>> On Sunday 15 May 2005 11:00, Mikulas Patocka wrote:
>> >On Sun, 15 May 2005, Tomasz Torcz wrote:
>> >> On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
>> >> > > > > However they've patched the FreeBSD kernel to
>> >> > > > > "workaround?" it:
>> >> > > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/ht
>> >> > > > >t5.patch
>> >> > > >
>> >> > > > That's a similar stupid idea as they did with the disk write
>> >> > > > cache (lowering the MTBFs of their disks by considerable
>> >> > > > factors, which is much worse than the power off data loss
>> >> > > > problem) Let's not go down this path please.
>> >> > >
>> >> > > What wrong did they do with disk write cache?
>> >> >
>> >> > They turned it off by default, which according to disk vendors
>> >> > lowers the MTBF of your disk to a fraction of the original
>> >> > value.
>> >> >
>> >> > I bet the total amount of valuable data lost for FreeBSD users
>> >> > because of broken disks is much much bigger than what they
>> >> > gained from not losing in the rather hard to hit power off
>> >> > cases.
>> >>
>> >>  Aren't I/O barriers a way to safely use write cache?
>> >
>> >FreeBSD used these barriers (FLUSH CACHE command) long time ago.
>> >
>> >There are rumors that some disks ignore FLUSH CACHE command just to
>> > get higher benchmarks in Windows. But I haven't heart of any proof.
>> > Does anybody know, what companies fake this command?
>> >
>> >From a story I read elsewhere just a few days ago, this problem is 
>> virtually universal even in the umpty-bucks 15,000 rpm scsi server 
>> drives.  It appears that this is just another way to crank up the 
>> numbers and make each drive seem faster than its competition.
>> 
>> My gut feeling is that if this gets enough ink to get under the drive 
>> makers skins, we will see the issuance of a utility from the makers 
>> that will re-program the drives therefore enabling the proper 
>> handling of the FLUSH CACHE command.  This would be an excellent 
>> chance IMO, to make a bit of noise if the utility comes out, but only 
>> runs on windows.  In that event, we hold their feet to the fire (the 
>> prefereable method), or a wrapper is written that allows it to run on 
>> any os with a bash-like shell manager.


Jeff> There is a large amount of yammering and speculation in this thread.

Jeff> Most disks do seem to obey SYNC CACHE / FLUSH CACHE.


Then it must be file system who's not controlling properly.  And
because this is so widely spread among Linux, there must be at least
one bug existing in VFS ( or there was, and everyone copied it ).

At least, from:

	http://developer.osdl.jp/projects/doubt/

there is project name "diskio" which does black box test about this:

	http://developer.osdl.jp/projects/doubt/diskio/index.html

And if we assume for Read after Write access semantics of HDD for
"SURELY" checking the data image on disk surface ( by HDD, I mean ),
on both SCSI and ATA, ALL the file system does not pass the test.

And I was wondering who's bad. File system? Device driver of both
SCSI and ATA? or criterion? From Jeff's point, it seems like file
system or criterion...
---- 
Kenichi Okuyama
