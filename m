Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRLRDlD>; Mon, 17 Dec 2001 22:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283782AbRLRDky>; Mon, 17 Dec 2001 22:40:54 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:6784 "EHLO
	orf.homelinux.org") by vger.kernel.org with ESMTP
	id <S283771AbRLRDkq>; Mon, 17 Dec 2001 22:40:46 -0500
Message-Id: <200112180340.fBI3eh201952@orf.homelinux.org>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: Manfred Spraul <manfred@colorfullife.com>
From: Leigh Orf <orf@mailbag.com>
cc: linux-kernel@vger.kernel.org
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: modify_ldt returning ENOMEM on highmem 
In-Reply-To: Your message of "Mon, 17 Dec 2001 20:20:25 +0100."
             <3C1E4579.4A46F32F@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Dec 2001 22:40:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul wrote:

|   > Do you have an NTFS disk mounted? I had a similar problem which was
|   > "fixed" by not having an NTFS vol mounted. Apparently the ntfs code
|   > makes a lot of calls to vmalloc which leads to badness.
|   > 
|   Both modify_ldt and NTFS make lots of calls to vmalloc.
|   
|   AFAICS this limits the number of concurrently running processes that are
|   linked to libpthread to less than 2000 on highmem machines, regardless
|   of the actual free memory.
|   
|   Could you try the attached patch?
|   It should permit you to keep the NTFS vol mounted - libpthread doesn't
|   need a 64 kB LDT. That should reduce the pressure on the vmalloc area.
|   
|   The patch applies to both 2.4.16 and 2.5.1

Tried your patch against 2.4.16.

After running updatedb with all my vols mounted (including ntfs) I was
able to start up all applications without trouble, so your patch was
good in that regard.  However, ntfs isn't happy. A whole lotta this is
in my syslog:


Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. Returning error code -95.
Dec 17 22:36:55 orf last message repeated 5 times
Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. Returning error code -95.
Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_getdir_unsorted(): Read failed. Returning error code -95.
Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec 17 22:36:55 orf kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed

Leigh Orf

