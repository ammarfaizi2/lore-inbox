Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRLRJIq>; Tue, 18 Dec 2001 04:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283777AbRLRJIh>; Tue, 18 Dec 2001 04:08:37 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:56483 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282850AbRLRJIZ>; Tue, 18 Dec 2001 04:08:25 -0500
Message-Id: <5.1.0.14.2.20011218090504.00adc7d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 18 Dec 2001 09:08:32 +0000
To: Leigh Orf <orf@mailbag.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: modify_ldt returning ENOMEM on highmem 
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200112180340.fBI3eh201952@orf.homelinux.org>
In-Reply-To: <Your message of "Mon, 17 Dec 2001 20:20:25 +0100." <3C1E4579.4A46F32F@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:40 18/12/01, Leigh Orf wrote:
>Manfred Spraul wrote:
>|  > Do you have an NTFS disk mounted? I had a similar problem which was
>|   > "fixed" by not having an NTFS vol mounted. Apparently the ntfs code
>|   > makes a lot of calls to vmalloc which leads to badness.
>|   >
>|   Both modify_ldt and NTFS make lots of calls to vmalloc.
>|
>|   AFAICS this limits the number of concurrently running processes that are
>|   linked to libpthread to less than 2000 on highmem machines, regardless
>|   of the actual free memory.
>|
>|   Could you try the attached patch?
>|   It should permit you to keep the NTFS vol mounted - libpthread doesn't
>|   need a 64 kB LDT. That should reduce the pressure on the vmalloc area.
>|
>|   The patch applies to both 2.4.16 and 2.5.1
>
>Tried your patch against 2.4.16.
>
>After running updatedb with all my vols mounted (including ntfs) I was
>able to start up all applications without trouble, so your patch was
>good in that regard.  However, ntfs isn't happy. A whole lotta this is
>in my syslog:

Hi,

I am going on holiday for two weeks from tomorrow but when I get back I 
will backport the new allocator from ntfs tng to the old ntfs driver. This 
only uses vmalloc if necessary so will decrease the number of vmalloc()s 
dramatically and hopefully this will make your kernel happier.

I will CC: patch to you so you can see if all your problems go away or if 
it is not sufficient.

Best regards,

Anton

>Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. 
>Returning error code -95.
>Dec 17 22:36:55 orf last message repeated 5 times
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 
>0x1000) failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. 
>Returning error code -95.
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 
>0x1000) failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. 
>Returning error code -95.
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 
>0x1000) failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 
>0x1000) failed
>Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
>
>Leigh Orf
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

