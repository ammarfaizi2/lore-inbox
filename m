Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUCaS3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUCaS3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:29:13 -0500
Received: from [168.159.2.31] ([168.159.2.31]:14512 "EHLO mailhub.lss.emc.com")
	by vger.kernel.org with ESMTP id S262273AbUCaS3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:29:09 -0500
Message-ID: <406B0DB6.7050102@emc.com>
Date: Wed, 31 Mar 2004 13:28:06 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de>	 <200403201723.11906.bzolnier@elka.pw.edu.pl>	 <1079800362.11062.280.camel@watt.suse.com>	 <200403201805.26211.bzolnier@elka.pw.edu.pl>	 <1080662685.1978.25.camel@sisko.scot.redhat.com>	 <1080674384.3548.36.camel@watt.suse.com>	 <1080683417.1978.53.camel@sisko.scot.redhat.com>	 <1080684797.3546.85.camel@watt.suse.com>	 <1080741817.1991.34.camel@sisko.scot.redhat.com> <1080743276.3547.146.camel@watt.suse.com>
In-Reply-To: <1080743276.3547.146.camel@watt.suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.1.1.86173
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As one of the large users of the Jens and Chris's barrier support in 
2.4, I am very motivated to help validate and benchmark the new version.

Stephen, if you have a specific mysql workload or usage case, I can try 
to through that into the mix.  We do a lot of Sleepycat DB testing, 
would results from that help?

Ric


Chris Mason wrote:

>On Wed, 2004-03-31 at 09:03, Stephen C. Tweedie wrote:
>  
>
>>Hi,
>>
>>On Tue, 2004-03-30 at 23:13, Chris Mason wrote:
>>
>>    
>>
>>>Most database benchmarks are done on scsi, and the blkdev_flush should
>>>be a noop there.  For IDE based database and mail server benchmarks, the
>>>results won't be pretty.  
>>>      
>>>
>>Yep.  I'm really not too worried about big database benchmarks -- those
>>are very much special cases, using rather specialised storage setup
>>(SCSI or FC, striped over lots of small disks rather than fewer large
>>ones.)  I'm much more concerned about your average LAMP user's mysql
>>database, and how to keep performance sane on that.
>>
>>    
>>
>In some cases, it's going to be so much slower that it will look like
>the old code wasn't writing the data at all.  I don't think there's much
>we can do about that.
>
>  
>
>>>The reiserfs fsync code tries hard to only flush once, so if a commit is
>>>done then blkdev_flush isn't called.  We might have to do a few other
>>>tricks to queue up multiple synchronous ios and only flush once.
>>>      
>>>
>>Batching is really helpful when you've got lots of threads that can be
>>coalesced, yes.  ext3 does that for things like mail servers.  I'm not
>>sure whether the same tricks will apply to the various databases out
>>there, though.
>>    
>>
>
>We can do better in general when there's more then one process doing an
>fsync.  reiserfs and ext3 both try to be smart about batching log
>commits, but I think we could do more to streamline the data writes.
>
>I'm playing with a few ideas, I'll post more when I've got real code to
>back things up.
>
>If there's only one process doing fsyncs, there's not much the kernel
>can do except provide an aio fsync call.
>
>-chris
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
