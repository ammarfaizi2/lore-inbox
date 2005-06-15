Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFOFH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFOFH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVFOFH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:07:57 -0400
Received: from [67.137.28.189] ([67.137.28.189]:7810 "EHLO vger")
	by vger.kernel.org with ESMTP id S261491AbVFOFHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:07:43 -0400
Message-ID: <42AFA2F5.6010707@utah-nac.org>
Date: Tue, 14 Jun 2005 21:39:33 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
References: <20050614094141.GE1467@schottelius.org> <20050614215032.35d44e93.akpm@osdl.org>
In-Reply-To: <20050614215032.35d44e93.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are cases where bitmaps can dirty themselves in the FS's (I have 
had to deal with several of these issues in 2.6) after a sync,
and I have found that:

#
# sync
# sync
#

is required on ext2 in some situations due to some race conditions with 
remote and local clients using device based FS's, so
there are some holes -- and comments in ext2 and several other FS's seem 
to bear this assumption out.

:-)

Jeff

Andrew Morton wrote:

>Nico Schottelius <nico-kernel@schottelius.org> wrote:
>  
>
>>Hello again!
>>
>>When my system shuts down and init calls sync() and after that
>>umount and then reboot, the filesystem is left in an unclean state.
>>
>>If I do sync() two times (one before umount, one after umount) it
>>seems to work.
>>
>>    
>>
>
>That's a bug.
>
>The standards say that sync() is supposed to "start" I/O, or something
>similarly vague and waffly.  The Linux implementation of sync() has always
>started all I/O and then waited upon all of it before returning from
>sync().
>
>And umount() itself will sync everything to disk, so the additional sync()
>calls should be unnecessary.
>
>That being said, if umount was leaving dirty filesystems then about 1000000
>people would be complaining.  So there's something unusual about your
>setup.
>
>What filesystem?  What kernel version?  Any unusual bind mounts, loopback
>mounts, etc?  There must be something there...
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

