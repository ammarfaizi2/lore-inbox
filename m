Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVKWPvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVKWPvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKWPvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:51:00 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:36771 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751154AbVKWPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:50:56 -0500
Message-ID: <43838852.8000706@tmr.com>
Date: Tue, 22 Nov 2005 16:06:26 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Tue, 22 Nov 2005, Chris Adams wrote:
> 
>>Once upon a time, Jan Harkes <jaharkes@cs.cmu.edu> said:
>>
>>>The only thing that tends to break are userspace archiving tools like
>>>tar, which assume that 2 objects with the same 32-bit st_ino value are
>>>identical.
>>
>>That assumption is probably made because that's what POSIX and Single
>>Unix Specification define: "The st_ino and st_dev fields taken together
>>uniquely identify the file within the system."  Don't blame code that
>>follows standards for breaking.
> 
> 
> The standards are insufficient however.  For example dealing with named 
> streams or extended attributes if exposed as "normal files" would 
> naturally have the same st_ino (given they are the same inode as the 
> normal file data) and st_dev fields.
> 
> 
>>>I think that by now several actually double check that theinode
>>>linkcount is larger than 1.
>>
>>That is not a good check.  I could have two separate files that have
>>multiple links; if st_ino is the same, how can tar make sense of it?
> 
> 
> Now that is true.  In addition to checking the link count is larger then 
> 1, they should check the file size and if that matches compute the SHA-1 
> digest of the data (or the MD5 sum or whatever) and probably should also 
> check the various stat fields for equality before bothering with the 
> checksum of the file contents.
> 
> Or Linux just needs a backup api that programs like this can use to 
> save/restore files.  (Analogous to the MS Backup API but hopefully 
> less horid...)
> 
In order to prevent the problems mentioned AND satisfy SuS, I would 
think that the st_dev field would be the value which should be unique, 
which is not always the case currently. The st_inod is a file id on 
st_dev, and it would be less confusing if the inode on each st_dev were 
unique. Not to mention that some backup programs do look at that st_dev 
and could be mightily confused if the meaning is not determinant.

Historical application usage assumes that it is invariant, many 
applications were written before pluggable devices and network mounts. 
In a perfect world where nothing broke when things were changed, if 
there were some UUID on a filesystem, so it looks the same mounted over 
network or by direct mount, or loopback mount, etc, then there would be 
no confusion.

A backup API would really be nice if it could somehow provide some 
unique ID, such that a netowrk or direct backup of the same data would 
have the same IDs.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

