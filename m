Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWEKOMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWEKOMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWEKOMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:12:46 -0400
Received: from vvv.conterra.de ([212.124.44.162]:46251 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1751785AbWEKOMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:12:45 -0400
Message-ID: <4463461C.3070201@conterra.de>
Date: Thu, 11 May 2006 16:11:40 +0200
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 metadata performace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after I switched from from ext2 to ext3 i observed some severe 
performance degradation. Most discussion about this topic deals
with tuning of data-io performance. My problem however is related to 
metadata updates. When cloning (cp -al) or deleting directory trees I 
find, that about 7200 files are created/deleted per minute. Seems
this is related to some ex3 strategy, to wait for each metadata to be
written to disk. Interestingly this occurs with my new hw-raid
controller (3ware 9500S), which even has an battery buffered disk cache.
Thus there is no need for synchronous IO anyway. If I disable the
disk cache on my plain SATA disk using ext3, I also get this behavior.

Would it be make sense for ext3, to disable synchronous writes even
for metadata (similar to the "data=writeback" option)? This means, that
ext3 won't protect the (meta) data currently written. This is needed
if running a database or an email server, where the process performing
the IO must be sure, the data is definitely on disk, if it returns form
the system call. In most cases, however, you choose ex3 to ensure the
consistency of your file system after a crash, to avoid an fsck.
If some files, created just before the crash, vanish, does not hurt
me too much.

Dieter.
