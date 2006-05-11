Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWEKSqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWEKSqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWEKSqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:46:11 -0400
Received: from news.cistron.nl ([62.216.30.38]:45798 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1750987AbWEKSqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:46:08 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: ext3 metadata performace
Date: Thu, 11 May 2006 18:46:07 +0000 (UTC)
Organization: Cistron
Message-ID: <e400pf$ens$1@news.cistron.nl>
References: <4463461C.3070201@conterra.de> <44635BA8.9060002@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1147373167 15100 194.109.0.112 (11 May 2006 18:46:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <44635BA8.9060002@argo.co.il>,
Avi Kivity  <avi@argo.co.il> wrote:
>Dieter Stuken wrote:
>> after I switched from from ext2 to ext3 i observed some severe 
>> performance degradation. Most discussion about this topic deals
>> with tuning of data-io performance. My problem however is related to 
>> metadata updates. When cloning (cp -al) or deleting directory trees I 
>> find, that about 7200 files are created/deleted per minute. Seems
>> this is related to some ex3 strategy, to wait for each metadata to be
>> written to disk. Interestingly this occurs with my new hw-raid
>> controller (3ware 9500S), which even has an battery buffered disk cache.
>> Thus there is no need for synchronous IO anyway. If I disable the
>> disk cache on my plain SATA disk using ext3, I also get this behavior.
>>
>Try increasing the journal size (mkfs -t ext3 -J size=20000) and see if 
>that improves things.

Also, with 3ware, look in /sys/block/sd* and set queue_depth to
254/(nr_arrays), and nr_requests to at least 2*queue_depth. Also
try another I/O scheduler (deadline instead of as).

Mike.

