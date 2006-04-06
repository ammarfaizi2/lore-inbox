Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWDFJd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWDFJd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 05:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDFJd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 05:33:26 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:55281
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1750921AbWDFJdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 05:33:24 -0400
Message-ID: <026001c6595c$f6c5a890$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Chris Caputo" <ccaputo@alt.net>
Cc: <dax@gurulabs.com>, <axboe@suse.de>,
       =?UTF-8?B?Iijlu6Plronnp5HmioAp5a6J5Y+vTyI=?= 
	<billion.wu@areca.com.tw>,
       "\"Al Viro\"" <viro@ftp.linux.org.uk>,
       "\"Andrew Morton\"" <akpm@osdl.org>,
       "\"Randy.Dunlap\"" <rdunlap@xenotime.net>,
       "\"Matti Aarnio\"" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>,
       "\"James Bottomley\"" <James.Bottomley@steeleye.com>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003><20060330155804.GP13476@suse.de><Pine.LNX.4.64.0603311700310.14317@nacho.alt.net><Pine.LNX.4.64.0603311748010.14317@nacho.alt.net><20060331202202.GH14022@suse.de> <Pine.LNX.4.64.0603312028500.14317@nacho.alt.net>
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
Date: Thu, 6 Apr 2006 17:32:01 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_025D_01C659A0.033B86B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 06 Apr 2006 09:28:11.0640 (UTC) FILETIME=[6C5AEF80:01C6595C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_025D_01C659A0.033B86B0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit

Dear Chris Caputo,

I am so sorry that I reply this mail today.
At 2006/4/3 my mother unexpectedly got paralysis and dead.
I can not do any more "request testing" with this bug for some days.
I do dump_stack as your request and attach it.
And I do "fsck" before test this volume every time.
It appears fine when do fsck with each testing volume.
You can easily reproduce this bug from copy a 900MB file from ARECA volume 
(mkfs.ext2, mount -t ext2) to none ARECA volume.

Best Regards
Erich Chen

----- Original Message ----- 
From: "Chris Caputo" <ccaputo@alt.net>
To: "Jens Axboe" <axboe@suse.de>
Cc: "erich" <erich@areca.com.tw>; "Andrew Morton" <akpm@osdl.org>; 
<linux-kernel@vger.kernel.org>
Sent: Saturday, April 01, 2006 4:37 AM
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)


> On Fri, 31 Mar 2006, Jens Axboe wrote:
>> On Fri, Mar 31 2006, Chris Caputo wrote:
>> > On Fri, 31 Mar 2006, Chris Caputo wrote:
>> > > On Thu, 30 Mar 2006, Jens Axboe wrote:
>> > > > I can't really say, from my recollection of leafing over lkml 
>> > > > emails, I
>> > > > seem to recall someone saying he hit this with a newer kernel where 
>> > > > as
>> > > > the older one did not?
>> > > >
>> > > > What are the sectors exactly it complains about, eg the full line 
>> > > > you
>> > > > see?
>> > >
>> > > I see:
>> > >
>> > >   attempt to access beyond end of device
>> > >   sdb1: rw=0, want=134744080, limit=128002016
>> >
>> > I believe the "rw=0" means that was a simple read request, and not a
>> > read-ahead.
>>
>> Correct.
>>
>> > 128002016 equals about 62 gigs, which is the correct volume size:
>> >
>> >   Filesystem           1K-blocks      Used Available Use% Mounted on
>> >   /dev/sdb1             62995364   2832696  56962620   5% /xxx
>> >
>> >   /dev/sdb1 on /xxx type ext2 (rw,noatime)
>>
>> How are you reproducing this, through the file system (reading files),
>> or reading the device? If the former, is the file system definitely
>> sound - eg does it pass fsck?
>
> Filesystem level interaction via bonnie++.  Basic repro is, using ccaputo
> user, is:
>
>  mke2fs -j -L /xxx /dev/sdb1
>  mount -t ext2 /dev/sdb1 /xxx
>  cd /xxx ; mkdir ccaputo ; chown ccaputo ccaputo ; cd ccaputo ; su ccaputo
>  /usr/sbin/bonnie++
>
> Filesystem is believed to be sound since it is from a fresh mke2fs.
>
> The one strange thing I do is that I format it as ext3 (-j) but mount it
> as ext2, but I didn't think that would be an issue and I'd be surprised if
> Erich is doing the same in his tests, which also fail, with ext2.  (I do
> it in case I later decide to mount the volume as ext3.)
>
> Chris 

------=_NextPart_000_025D_01C659A0.033B86B0
Content-Type: text/plain;
	format=flowed;
	name="for_request_of_dump_stack.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="for_request_of_dump_stack.txt"

ARECA RAID ADAPTER0: 64BITS PCI BUS DMA ADDRESSING SUPPORTED=0A=
ARECA RAID ADAPTER0: FIRMWARE VERSION V1.39 2006-2-9=0A=
scsi1 : ARECA SATA HOST ADAPTER RAID CONTROLLER (RAID6-ENGINE Inside)=0A=
        Driver Version 1.20.0X.13=0A=
  Vendor: Areca     Model: ARC-1160-VOL#00   Rev: R001=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
SCSI device sda: 781249536 512-byte hdwr sectors (400000 MB)=0A=
sda: Write Protect is off=0A=
sda: Mode Sense: cb 00 00 08=0A=
SCSI device sda: drive cache: write back=0A=
SCSI device sda: 781249536 512-byte hdwr sectors (400000 MB)=0A=
sda: Write Protect is off=0A=
sda: Mode Sense: cb 00 00 08=0A=
SCSI device sda: drive cache: write back=0A=
 sda: sda1=0A=
sd 1:0:0:0: Attached scsi disk sda=0A=
sd 1:0:0:0: Attached scsi generic sg0 type 0=0A=
  Vendor: Areca     Model: ARC-1160-VOL#01   Rev: R001=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
SCSI device sdb: 312499712 512-byte hdwr sectors (160000 MB)=0A=
sdb: Write Protect is off=0A=
sdb: Mode Sense: cb 00 00 08=0A=
SCSI device sdb: drive cache: write back=0A=
SCSI device sdb: 312499712 512-byte hdwr sectors (160000 MB)=0A=
sdb: Write Protect is off=0A=
sdb: Mode Sense: cb 00 00 08=0A=
SCSI device sdb: drive cache: write back=0A=
 sdb: sdb1=0A=
sd 1:0:1:0: Attached scsi disk sdb=0A=
sd 1:0:1:0: Attached scsi generic sg1 type 0=0A=
  Vendor: Areca     Model: ARC-1160-VOL#02   Rev: R001=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
SCSI device sdc: 312499712 512-byte hdwr sectors (160000 MB)=0A=
sdc: Write Protect is off=0A=
sdc: Mode Sense: cb 00 00 08=0A=
SCSI device sdc: drive cache: write back=0A=
SCSI device sdc: 312499712 512-byte hdwr sectors (160000 MB)=0A=
sdc: Write Protect is off=0A=
sdc: Mode Sense: cb 00 00 08=0A=
SCSI device sdc: drive cache: write back=0A=
 sdc: sdc1=0A=
sd 1:0:2:0: Attached scsi disk sdc=0A=
sd 1:0:2:0: Attached scsi generic sg2 type 0=0A=
  Vendor: Areca     Model: RAID controller   Rev: R001=0A=
  Type:   Processor                          ANSI SCSI revision: 00=0A=
 1:0:16:0: Attached scsi generic sg3 type 3=0A=
arcmsr device major number 254=0A=
linux:~ # fsck /dev/sdb1=0A=
fsck 1.38 (30-Jun-2005)=0A=
e2fsck 1.38 (30-Jun-2005)=0A=
/mnt/sdb1 (/dev/sdb1): clean, 12/19546112 files, 876811/39062039 blocks=0A=
linux:~ # mount /dev/sdb1 /mnt/sdb1=0A=
linux:~ # cp /mnt/sdb1/aa ./ff=0A=
cp: reading `/mnt/sdb1/aa': Input/output error=0A=
#dump=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on sdb1, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015b23c>{__alloc_pages+87} =
<ffffffff8021af8b>{radix_tree_node_alloc+19}=0A=
       <ffffffff8021b3b5>{radix_tree_insert+244} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8021af8b>{radix_tree_node_alloc+19} =
<ffffffff8021b3b5>{radix_tree_insert+244}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8015d571>{__pagevec_lru_add+204}=0A=
       <ffffffff8019a42f>{mpage_bio_submit+31} =
<ffffffff8019b36e>{mpage_readpages+277}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015b23c>{__alloc_pages+87}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757934808=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126967088, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D-757935408=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D12126966488, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a833>{do_mpage_readpage+686} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff80182c45>{inode_get_bytes+16} =
<ffffffff880cb1f1>{:reiserfs:inode2sd+246}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8019b301>{mpage_readpages+168}=0A=
       <ffffffff882a7d0b>{:ext3:ext3_get_block+0} =
<ffffffff8015c910>{__do_page_cache_readahead+318}=0A=
       =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757934800=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771288, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff880db298>{:reiserfs:pathrelse+35} =
<ffffffff8020ddd9>{submit_bio+184}=0A=
       <ffffffff8015d571>{__pagevec_lru_add+204} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019b36e>{mpage_readpages+277} =
<ffffffff882a7d0b>{:ext3:ext3_get_block+0}=0A=
       <ffffffff8015c910>{__do_page_cache_readahead+318} =
<ffffffff880ce0a4>{:reiserfs:reiserfs_submit_file_region_for_write+408}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff880d01c1>{:reiserfs:reiserfs_file_write+5813}=0A=
       <ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8015cd19>{make_ahead_window+129} =
<ffffffff8015ce8c>{page_cache_readahead+347}=0A=
       <ffffffff801575cc>{do_generic_mapping_read+294} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8019a42f>{mpage_bio_submit+31}=0A=
       <ffffffff8019a96e>{mpage_readpage+51} =
<ffffffff801576a5>{do_generic_mapping_read+511}=0A=
       <ffffffff801563d1>{file_read_actor+0} =
<ffffffff80157f86>{__generic_file_aio_read+334}=0A=
       <ffffffff80158174>{generic_file_aio_read+52} =
<ffffffff8017a2d2>{do_sync_read+199}=0A=
       <ffffffff80143420>{autoremove_wake_function+0} =
<ffffffff8017a54d>{vfs_read+203}=0A=
       <ffffffff8017afaa>{sys_read+69} =
<ffffffff8010a8fe>{system_call+126}=0A=
maxsector=3D312496317 nr_sectors=3D8 sector=3D757935400=0A=
attempt to access beyond end of device=0A=
sdb1: rw=3D0, want=3D22232771888, limit=3D312496317=0A=
=0A=
Call Trace: <ffffffff8020d8a8>{generic_make_request+163}=0A=
       <ffffffff8020ddd9>{submit_bio+184} =
<ffffffff8015cc39>{blockable_page_cache_readahead+83}=0A=
       <ffffffff8019a42f>{mpage_bio_submit+31} =
<ffffffff8019a96e>{mpage_readpage+51}=0A=
       <ffffffff801576a5>{do_generic_mapping_read+511} =
<ffffffff801563d1>{file_read_actor+0}=0A=
       <ffffffff80157f86>{__generic_file_aio_read+334} =
<ffffffff80158174>{generic_file_aio_read+52}=0A=
       <ffffffff8017a2d2>{do_sync_read+199} =
<ffffffff80143420>{autoremove_wake_function+0}=0A=
       <ffffffff8017a54d>{vfs_read+203} <ffffffff8017afaa>{sys_read+69}=0A=
       <ffffffff8010a8fe>{system_call+126}=0A=
linux:~ #=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_025D_01C659A0.033B86B0--

