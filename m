Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUKRRNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUKRRNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUKRRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:05:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63987 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262767AbUKRRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:03:49 -0500
In-Reply-To: <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
MIME-Version: 1.0
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF43CCF252.FCCFAB5B-ON88256F50.005CE35E-88256F50.005D8559@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 18 Nov 2004 09:00:36 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M2_07222004 Beta 2|July
 22, 2004) at 11/18/2004 12:03:46,
	Serialize complete at 11/18/2004 12:03:46
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  2) doing non-blocking asynchronous writepage
>
>In the second case there is no deadlock, because the memory subsystem
>doesn't wait for data to be written.  If the filesystem refuses to
>write back data in a timely manner, memory will get full and OOM
>killer will go to work.

I don't see how the OOM killer can help you here.  The OOM killer deals 
with the system being out of virtual memory; writepage is about freeing 
real memory.  The real memory allocator will wait forever if it has to for 
pageouts to complete so that it can evict a page and free up real memory.

If a pageout requires a user space process to run, and the user space 
process requires additional real memory (e.g. in order to swap something 
in from swap space) to do the pageout, you can have a deadlock.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
