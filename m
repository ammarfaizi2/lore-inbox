Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVCBRMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVCBRMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVCBRKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:10:21 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:45039 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262341AbVCBRI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:08:56 -0500
Date: Wed, 02 Mar 2005 12:08:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
In-reply-to: <20050302120332.GA27882@logos.cnet>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503021208.51480.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
 <20050302120332.GA27882@logos.cnet>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 07:03, Marcelo Tosatti wrote:
>On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
>> Hi
>>
>> Never had to log a bug before, hope this is correctly done.
>>
>> Thanks
>>
>> Mark
>>
>> Detail....
>>
>> [1.] One line summary of the problem:
>> SCSI tape drive is refusing to rewind after backup to allow verify
>> and causing illegal seek error
>>
>> [2.] Full description of the problem/report:
>> On backup the tape drive is reporting the following error and
>> failing it's backups.
>>
>> tar: /dev/st0: Warning: Cannot seek: Illegal seek
>>
>> I have traced this back to failing at an upgrade of the kernel to
>> 2.4.29 on Feb 8th. The backups have not worked since. Replacement
>> Drives have been tried and cables to no avail. I noticed in the
>> the changelog that a patch by Solar Designer to the Scsi tape
>> return code had been made.
>
>v2.6 also contains the same problem BTW.
>
>Try this:
>
>--- a/drivers/scsi/st.c.orig 2005-03-02 09:02:13.637158144 -0300
>+++ b/drivers/scsi/st.c 2005-03-02 09:02:20.208159200 -0300
>@@ -3778,7 +3778,6 @@
>  read:  st_read,
>  write:  st_write,
>  ioctl:  st_ioctl,
>- llseek:  no_llseek,
>  open:  st_open,
>  flush:  st_flush,
>  release: st_release,
>-

Interesting Marcelo.  How long has this been true in 2.6?

I thought I had an amanda problem, and eventually went to virtual 
tapes on disk, largely because of this.  However, I have to say it is 
working better than tapes ever did here.  Unforch, that 200GB disk is 
certainly a single point of failure I don't relish thinking about...

>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
