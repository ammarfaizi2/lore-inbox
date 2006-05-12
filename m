Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWELAOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWELAOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWELAOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:14:32 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:36176 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750708AbWELAOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:14:32 -0400
Date: Thu, 11 May 2006 18:12:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ext3 metadata performace
In-reply-to: <6bkbC-4V9-27@gated-at.bofh.it>
To: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4463D301.5080302@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <6bkbC-4V9-27@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken wrote:
> after I switched from from ext2 to ext3 i observed some severe 
> performance degradation. Most discussion about this topic deals
> with tuning of data-io performance. My problem however is related to 
> metadata updates. When cloning (cp -al) or deleting directory trees I 
> find, that about 7200 files are created/deleted per minute. Seems
> this is related to some ex3 strategy, to wait for each metadata to be
> written to disk. Interestingly this occurs with my new hw-raid
> controller (3ware 9500S), which even has an battery buffered disk cache.
> Thus there is no need for synchronous IO anyway. If I disable the
> disk cache on my plain SATA disk using ext3, I also get this behavior.
> 
> Would it be make sense for ext3, to disable synchronous writes even
> for metadata (similar to the "data=writeback" option)? This means, that
> ext3 won't protect the (meta) data currently written. This is needed
> if running a database or an email server, where the process performing
> the IO must be sure, the data is definitely on disk, if it returns form
> the system call. In most cases, however, you choose ex3 to ensure the
> consistency of your file system after a crash, to avoid an fsck.
> If some files, created just before the crash, vanish, does not hurt
> me too much.

I think that doing this would destroy all filesystem consistency 
guarantees provided by ext3. In this case you might as well use ext2. In 
order for the journalling to work, the metadata updates must be written 
to the journal before any of them start modifying the actual disk 
metadata, otherwise there is no way to recover in the event of a crash.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

