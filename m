Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWBTHVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWBTHVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWBTHVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:21:20 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:63724 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932612AbWBTHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:21:20 -0500
Message-ID: <43F96DE9.7070209@namesys.com>
Date: Sun, 19 Feb 2006 23:21:13 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>, Chris Mason <mason@suse.com>
CC: Dave Jones <davej@redhat.com>, Nathan Scott <nathans@sgi.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, bjd <bjdouma@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       reiserfs-list@namesys.com, Vitaly Fertman <vetalf@inbox.ru>
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com> <20060219215209.GB7974@redhat.com> <20060220070916.GA8101@kevlar.burdell.org>
In-Reply-To: <20060220070916.GA8101@kevlar.burdell.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks kindly Sonny, Chris is this bug known/fixed?

Hans

Sonny Rao wrote:

>On Sun, Feb 19, 2006 at 04:52:09PM -0500, Dave Jones wrote:
><snip> 
>  
>
>>Just for kicks, I just hacked this up..
>>
>>#!/bin/bash
>>wget http://www.digitaldwarf.be/products/mangle.c
>>gcc mangle.c -o mangle
>>
>>dd if=/dev/zero of=data.img count=70000
>>
>>while [ 1 ];
>>do
>>        mkfs.xfs -f data.img >/dev/null
>>		./mangle data.img $RANDOM
>>        sudo mount -t xfs data.img mntpt -o loop
>>        sudo ls -R mntpt
>>        sudo umount mntpt
>>done
>>    
>>
>
>Cool script, you might want to multiply $RANDOM by some factor (I used
>8) to catch some more stuff, I know JFS, for example, doesn't put
>anything in the first 32k, so the first time I ran it on JFS it did
>nothing ;-) 
>
>
>Reiserfs folks, 
>
>I also found an infinte loop in Reiserfs on 2.6.15, if the Reiser
>folks are interested, I've gziped the fs and put it here:
>
>http://burdell.org/~sonny/data.img.breaks.reiserfs.gz
>
>The fs is only 52k when zipped, so its not too bad to download.
>
>This is under stock 2.6.15, sorry I can't post dmesg output because I
>end up having to reboot when it happens and don't have time to debug
>right now.  It looks like it's in the journal replay code where it
>keeps trying to grab some block with a ridiculously large offset. 
>
>
>  
>
>>xfs wins the award for 'noisiest fs in the face of corruption' :-)
>>After a few dozen backtraces from xfs_corruption_error,
>>this fell out...
>>
>>divide error: 0000 [1] SMP
>>    
>>
><snip trace>
> 
>  
>
>>(The kernel is based on 2.6.16rc4)
>>    
>>
>
>I see a similar breakage (divide error) on x86 using 2.6.15
>
>Sonny
>
>
>  
>

