Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTLQWnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTLQWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:43:49 -0500
Received: from adsl-64-161-225-63.dsl.lsan03.pacbell.net ([64.161.225.63]:49148
	"EHLO river.thesalmons.org") by vger.kernel.org with ESMTP
	id S264588AbTLQWnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:43:47 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about max_readahead for ide devices in 2.4?
References: <200312152244.hBFMiej6011977@river.thesalmons.org>
	<20031215223903.19687b79.akpm@osdl.org>
From: John Salmon <jsalmon@thesalmons.org>
Date: Wed, 17 Dec 2003 14:43:42 -0800
In-Reply-To: <20031215223903.19687b79.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 15 Dec 2003 22:39:03 -0800")
Message-ID: <m3iskfm5ep.fsf@river.fishnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> John Salmon <jsalmon@thesalmons.org> wrote:
>> 
>> 
>> 
>> Several "tuning" recommendations suggest that sequential accesses of
>> large files, and hence the performance of busy web servers, can be improved
>> by changing the maximum readahead value with, e.g.,
>> 
>> echo 511 > /proc/sys/vm/max-readahead
>> 
>> But it looks to me like get_max_readahead in filemap.c ignores the
>> value set by /proc/sys in favor of max_readahead[major][minor] whenever
>> max_readahead[major] is non-NULL.  And furthermore that 
>> max_readahead[major] IS initialized to non-NULL for ide devices in
>> init_gendisk.  (N.B. I'm looking at 2.4 sources).
>> 
>> Conclusion: echoing a value into /proc/sys/vm/max-readahead won't change the
>> readahead behavior for already-probed IDE devices.
>> 
>> Is this correct, or am I missing something?

Andrew> That's correct - it's all a bit weird.   You should use

Andrew> 	blockdev --setra 511 /dev/hda

Andrew> for IDE devices.  Not sure about scsi.  You may as well set
Andrew> /proc/sys/vm/max-readahead to the same thing.

Are you sure?  It looks like that invokes the BLKRASET ioctl, which
sets an entry in the read_ahead[MAJOR(dev)] array.  But the only code
that uses the read_ahead[] array is in fs/hfs/file.c, and I'm definitely
not using an hfs filesystem.

Or am I missing something else??

Thanks,
John Salmon

P.S.  The weird thing is that I tried the blockdev --setra suggestoin
and it *seemed to* improve performance.  This is why drug tests are
double-blind ... the patient (the computer) may not be susceptible to
the placebo effect, but the doctor (me) may be :-(.


