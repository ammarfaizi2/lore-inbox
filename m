Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSLKDbW>; Tue, 10 Dec 2002 22:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266993AbSLKDbW>; Tue, 10 Dec 2002 22:31:22 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:59654 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266989AbSLKDbU>; Tue, 10 Dec 2002 22:31:20 -0500
Subject: Re: "bio too big" error
From: Wil Reichert <wilreichert@yahoo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3DF6A673.D406BC7F@digeo.com>
References: <1039572597.459.82.camel@darwin>  <3DF6A673.D406BC7F@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039577938.388.9.camel@darwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 22:38:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exact error with debug is:

darwin:/a01/mp3s/Skinny Puppy/Too Dark Park# ogg123 -q 01\ -\
Convulsion.ogg
bio too big device ide0(3,4) (256 > 255)
Call Trace: [<c020055e>]  [<e09ff46d>]  [<e09ff558>]  [<e09ff5f5>] 
[<c020050a>]  [<c02005f4>]  [<c017048e>]  [<c0170a79>]  [<c0187770>] 
[<c01472e6>]  [<c0187770>]  [<c0140edd>]  [<c01977fc>]  [<c01473e4>] 
[<c01475be>]  [<c0137ac8>]  [<c0137e60>]  [<c0138124>]  [<c0137e60>] 
[<c01381ca>]  [<c014eadb>]  [<c01094cb>]
[<e09def98>]  [<c01113bf>]  [<c0110ac2>]  [<c014ebce>]  [<c014ee6e>] 
[<c010967f>]

I'm guessing its perhaps a 2.5 / lvm issue?  Here's 'vgdisplay -v' in
case:

    Finding all volume groups
    Finding volume group "cheese_vg"
  --- Volume group ---
  VG Name               cheese_vg
  System ID             darwin1025684717
  Format                lvm2
  Metadata Areas        6
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                256
  Cur LV                1
  Open LV               1
  Max PV                256
  Cur PV                5
  Act PV                5
  VG Size               330.05 GB
  PE Size               16.00 MB
  Total PE              21123
  Alloc PE / Size       21123 / 330.05 GB
  Free  PE / Size       0 / 0
  VG UUID               WF3vAx-k1r3-NUjU-az7z-I4SM-oorx-rvoYSt
   
  --- Logical volume ---
  LV Name                /dev/cheese_vg/blah
  VG Name                cheese_vg
  LV UUID                000000-0000-0000-0000-0000-0000-000000
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                330.05 GB
  Current LE             21123
  Segments               7
  Allocation             next free
  Read ahead sectors     1024
  Block device           254:0
   
  --- Physical volumes ---
  PV Name               /dev/discs/disc1/disc     
  PV Status             allocatable
  Total PE / Free PE    4769 / 0
   
  PV Name               /dev/ide/host2/bus0/target0/lun0/disc     
  PV Status             allocatable
  Total PE / Free PE    7361 / 0
   
  PV Name               /dev/ide/host2/bus1/target0/lun0/disc     
  PV Status             allocatable
  Total PE / Free PE    5961 / 0
   
  PV Name               /dev/discs/disc0/part4     
  PV Status             allocatable
  Total PE / Free PE    2431 / 0
   
  PV Name               /dev/discs/disc4/disc     
  PV Status             allocatable
  Total PE / Free PE    601 / 0


Wil

On Tue, 2002-12-10 at 21:44, Andrew Morton wrote:
> Wil Reichert wrote:
> > 
> > Hi,
> > 
> > I'm getting a "bio too big" error with 2.5.50.  I've got a 330G lvm2
> > partition formatted with ext3 using the -T largefile4 parameter.
> > Everything seems ok at first, but any sort of access will die very
> > unhappily with said error messsage after about 10 seconds of operation
> > or so.  The only google search results are the patch submission.  Eeek.
> > 
> 
> How odd.
> 
> Please send the full diagnostic output.
> 
> And add this:
> 
> 
> --- 25/drivers/block/ll_rw_blk.c~a	Tue Dec 10 18:42:54 2002
> +++ 25-akpm/drivers/block/ll_rw_blk.c	Tue Dec 10 18:43:13 2002
> @@ -1921,6 +1921,7 @@ end_io:
>  			       bdevname(bio->bi_bdev),
>  			       bio_sectors(bio),
>  			       q->max_sectors);
> +			dump_stack();
>  			goto end_io;
>  		}
>  
> 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Wil Reichert <wilreichert@yahoo.com>

